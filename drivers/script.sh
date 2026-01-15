sudo rmmod pynq_uio_mapper 2>/dev/null

cat > pynq_char_mapper.c << 'EOF'
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/slab.h>
#include <linux/list.h>
#include <linux/mm.h>
#include <linux/io.h>
#include <asm/pgtable.h>

#define DRIVER_NAME "pynq_char"
#define MAX_DEVICES 32

struct buffer_mapping {
    struct list_head list;
    unsigned long vm_offset;    // Offset virtuale per mmap
    phys_addr_t phys_addr;      // Indirizzo fisico reale
    size_t size;                // Dimensione buffer
    char buffer_id[64];         // ID buffer
};

struct tenant_device {
    struct cdev cdev;
    char tenant_id[64];
    struct list_head buffers;   // Lista buffer_mapping
    struct mutex lock;
    dev_t devnum;
    struct device *device;
};

static struct class *pynq_char_class;
static dev_t base_devnum;
static struct tenant_device *tenant_devices[MAX_DEVICES];
static int device_count = 0;
static DEFINE_MUTEX(devices_lock);

// Open: associa tenant al file
static int pynq_char_open(struct inode *inode, struct file *filp)
{
    struct tenant_device *tenant = container_of(inode->i_cdev, 
                                                struct tenant_device, cdev);
    filp->private_data = tenant;
    pr_info("pynq_char: Device opened for %s\n", tenant->tenant_id);
    return 0;
}

// mmap: mappa buffer in base all'offset
static int pynq_char_mmap(struct file *filp, struct vm_area_struct *vma)
{
    struct tenant_device *tenant = filp->private_data;
    unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
    unsigned long vma_size = vma->vm_end - vma->vm_start;
    struct buffer_mapping *mapping;
    int found = 0;
    
    pr_info("pynq_char: mmap for %s, offset=0x%lx, size=%lu\n",
            tenant->tenant_id, offset, vma_size);
    
    mutex_lock(&tenant->lock);
    
    // Cerca buffer con questo offset
    list_for_each_entry(mapping, &tenant->buffers, list) {
        if (mapping->vm_offset == offset) {
            unsigned long required_size = PAGE_ALIGN(mapping->size);
            
            if (vma_size > required_size) {
                pr_err("pynq_char: VMA too large\n");
                mutex_unlock(&tenant->lock);
                return -EINVAL;
            }
            
            // Write-combining (no cache)
            vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
            
            // Mappa memoria fisica
            if (remap_pfn_range(vma, vma->vm_start,
                               mapping->phys_addr >> PAGE_SHIFT,
                               vma_size, vma->vm_page_prot)) {
                pr_err("pynq_char: remap_pfn_range failed\n");
                mutex_unlock(&tenant->lock);
                return -EAGAIN;
            }
            
            pr_info("pynq_char: Mapped buffer '%s' @ phys 0x%llx\n",
                   mapping->buffer_id, (unsigned long long)mapping->phys_addr);
            found = 1;
            break;
        }
    }
    
    mutex_unlock(&tenant->lock);
    
    if (!found) {
        pr_err("pynq_char: No buffer at offset 0x%lx\n", offset);
        return -EINVAL;
    }
    
    return 0;
}

static struct file_operations pynq_char_fops = {
    .owner = THIS_MODULE,
    .open = pynq_char_open,
    .mmap = pynq_char_mmap,
};

// Sysfs: aggiungi buffer
// Format: "offset,phys_addr,size,buffer_id"
static ssize_t add_buffer_store(struct device *dev,
                                struct device_attribute *attr,
                                const char *buf, size_t count)
{
    struct tenant_device *tenant = dev_get_drvdata(dev);
    struct buffer_mapping *mapping;
    unsigned long offset, size;
    unsigned long long phys_addr;
    char buffer_id[64];
    
    if (sscanf(buf, "%lx,%llx,%lx,%63s", &offset, &phys_addr, &size, buffer_id) != 4) {
        pr_err("pynq_char: Invalid format. Use: offset,phys_addr,size,buffer_id\n");
        return -EINVAL;
    }
    
    pr_info("pynq_char: Adding buffer '%s' for %s\n", buffer_id, tenant->tenant_id);
    pr_info("  offset=0x%lx, phys=0x%llx, size=%lu\n", offset, phys_addr, size);
    
    mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
    if (!mapping)
        return -ENOMEM;
    
    mapping->vm_offset = offset;
    mapping->phys_addr = phys_addr;
    mapping->size = size;
    strncpy(mapping->buffer_id, buffer_id, sizeof(mapping->buffer_id) - 1);
    
    mutex_lock(&tenant->lock);
    list_add_tail(&mapping->list, &tenant->buffers);
    mutex_unlock(&tenant->lock);
    
    pr_info("pynq_char: Buffer added successfully\n");
    
    return count;
}

// Sysfs: rimuovi buffer
static ssize_t remove_buffer_store(struct device *dev,
                                   struct device_attribute *attr,
                                   const char *buf, size_t count)
{
    struct tenant_device *tenant = dev_get_drvdata(dev);
    struct buffer_mapping *mapping, *tmp;
    unsigned long offset;
    
    if (kstrtoul(buf, 0, &offset))
        return -EINVAL;
    
    mutex_lock(&tenant->lock);
    
    list_for_each_entry_safe(mapping, tmp, &tenant->buffers, list) {
        if (mapping->vm_offset == offset) {
            pr_info("pynq_char: Removing buffer '%s'\n", mapping->buffer_id);
            list_del(&mapping->list);
            kfree(mapping);
            mutex_unlock(&tenant->lock);
            return count;
        }
    }
    
    mutex_unlock(&tenant->lock);
    
    pr_err("pynq_char: Buffer at offset 0x%lx not found\n", offset);
    return -ENOENT;
}

// Sysfs: lista buffer
static ssize_t list_buffers_show(struct device *dev,
                                 struct device_attribute *attr,
                                 char *buf)
{
    struct tenant_device *tenant = dev_get_drvdata(dev);
    struct buffer_mapping *mapping;
    ssize_t len = 0;
    
    mutex_lock(&tenant->lock);
    
    list_for_each_entry(mapping, &tenant->buffers, list) {
        len += scnprintf(buf + len, PAGE_SIZE - len,
                        "offset=0x%lx phys=0x%llx size=%zu id=%s\n",
                        mapping->vm_offset,
                        (unsigned long long)mapping->phys_addr,
                        mapping->size,
                        mapping->buffer_id);
    }
    
    mutex_unlock(&tenant->lock);
    
    return len;
}

static DEVICE_ATTR_WO(add_buffer);
static DEVICE_ATTR_WO(remove_buffer);
static DEVICE_ATTR_RO(list_buffers);

static struct attribute *tenant_attrs[] = {
    &dev_attr_add_buffer.attr,
    &dev_attr_remove_buffer.attr,
    &dev_attr_list_buffers.attr,
    NULL,
};

ATTRIBUTE_GROUPS(tenant);

// Crea device per tenant
static int create_tenant_device(const char *tenant_id)
{
    struct tenant_device *tenant;
    int ret;
    
    if (device_count >= MAX_DEVICES)
        return -ENOMEM;
    
    tenant = kzalloc(sizeof(*tenant), GFP_KERNEL);
    if (!tenant)
        return -ENOMEM;
    
    strncpy(tenant->tenant_id, tenant_id, sizeof(tenant->tenant_id) - 1);
    INIT_LIST_HEAD(&tenant->buffers);
    mutex_init(&tenant->lock);
    
    // Alloca device number
    tenant->devnum = MKDEV(MAJOR(base_devnum), device_count);
    
    // Init cdev
    cdev_init(&tenant->cdev, &pynq_char_fops);
    tenant->cdev.owner = THIS_MODULE;
    
    ret = cdev_add(&tenant->cdev, tenant->devnum, 1);
    if (ret) {
        kfree(tenant);
        return ret;
    }
    
    // Crea device file
    tenant->device = device_create_with_groups(pynq_char_class, NULL,
                                               tenant->devnum, tenant,
                                               tenant_groups,
                                               "pynq_mem_%s", tenant_id);
    if (IS_ERR(tenant->device)) {
        cdev_del(&tenant->cdev);
        kfree(tenant);
        return PTR_ERR(tenant->device);
    }
    
    tenant_devices[device_count++] = tenant;
    
    pr_info("pynq_char: Created device for %s at /dev/pynq_mem_%s\n",
            tenant_id, tenant_id);
    
    return 0;
}

// Sysfs globale: crea nuovo tenant device
static ssize_t create_device_store(struct class *class,
                                   struct class_attribute *attr,
                                   const char *buf, size_t count)
{
    char tenant_id[64];
    int ret;
    
    if (sscanf(buf, "%63s", tenant_id) != 1)
        return -EINVAL;
    
    mutex_lock(&devices_lock);
    ret = create_tenant_device(tenant_id);
    mutex_unlock(&devices_lock);
    
    return ret ? ret : count;
}

static CLASS_ATTR_WO(create_device);

static int __init pynq_char_init(void)
{
    int ret;
    
    // Alloca device numbers
    ret = alloc_chrdev_region(&base_devnum, 0, MAX_DEVICES, DRIVER_NAME);
    if (ret)
        return ret;
    
    // Crea class
    pynq_char_class = class_create(THIS_MODULE, DRIVER_NAME);
    if (IS_ERR(pynq_char_class)) {
        unregister_chrdev_region(base_devnum, MAX_DEVICES);
        return PTR_ERR(pynq_char_class);
    }
    
    // Aggiungi sysfs per creare device
    ret = class_create_file(pynq_char_class, &class_attr_create_device);
    if (ret) {
        class_destroy(pynq_char_class);
        unregister_chrdev_region(base_devnum, MAX_DEVICES);
        return ret;
    }
    
    pr_info("pynq_char: Module loaded. Use /sys/class/pynq_char/create_device\n");
    
    return 0;
}

static void __exit pynq_char_exit(void)
{
    int i;
    struct buffer_mapping *mapping, *tmp;
    
    class_remove_file(pynq_char_class, &class_attr_create_device);
    
    for (i = 0; i < device_count; i++) {
        struct tenant_device *tenant = tenant_devices[i];
        
        if (tenant) {
            // Cleanup buffer list
            list_for_each_entry_safe(mapping, tmp, &tenant->buffers, list) {
                list_del(&mapping->list);
                kfree(mapping);
            }
            
            device_destroy(pynq_char_class, tenant->devnum);
            cdev_del(&tenant->cdev);
            kfree(tenant);
        }
    }
    
    class_destroy(pynq_char_class);
    unregister_chrdev_region(base_devnum, MAX_DEVICES);
    
    pr_info("pynq_char: Module unloaded\n");
}

module_init(pynq_char_init);
module_exit(pynq_char_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("PYNQ char device mapper with offset");
MODULE_VERSION("2.0");
EOF

# Makefile
cat > Makefile << 'EOF'
obj-m += pynq_char_mapper.o

KDIR := /lib/modules/$(shell uname -r)/build

all:
	$(MAKE) ARCH=arm -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
EOF

# Compila e carica
make clean
make
sudo insmod pynq_char_mapper.ko

# Verifica
ls -la /sys/class/pynq_char/
