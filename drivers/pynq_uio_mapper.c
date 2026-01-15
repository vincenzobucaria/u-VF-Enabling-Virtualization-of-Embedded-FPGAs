#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/platform_device.h>
#include <linux/uio_driver.h>
#include <linux/slab.h>
#include <linux/list.h>
#include <linux/device.h>
#include <linux/io.h>
#include <linux/mm.h>
#include <asm/pgtable.h>

#define DRIVER_NAME "pynq_uio"

struct pynq_uio_device {
    struct uio_info *info;
    struct platform_device *pdev;
    char name[64];
    phys_addr_t phys_addr;
    size_t size;
    int minor;
    struct list_head list;
};

static LIST_HEAD(device_list);
static DEFINE_MUTEX(device_list_lock);
static int next_minor = 0;
static struct class *pynq_uio_class;

static int pynq_uio_mmap(struct uio_info *info, struct vm_area_struct *vma)
{
    unsigned long pfn;
    unsigned long vma_size = vma->vm_end - vma->vm_start;
    
    pr_info("pynq_uio: mmap called for %s\n", info->name);
    pr_info("  Physical addr: 0x%llx\n", (unsigned long long)info->mem[0].addr);
    pr_info("  Buffer size: %lu bytes\n", (unsigned long)info->mem[0].size);
    pr_info("  VMA size: %lu bytes\n", vma_size);
    
    // FIX: Permetti mappatura di almeno una pagina
    // Il kernel mappa sempre in multipli di PAGE_SIZE
    unsigned long required_size = PAGE_ALIGN(info->mem[0].size);
    
    if (vma_size > required_size) {
        pr_err("pynq_uio: VMA too large (%lu > %lu)\n", vma_size, required_size);
        return -EINVAL;
    }
    
    pfn = info->mem[0].addr >> PAGE_SHIFT;
    
    // Write-combining per ARM (disabilita cache)
    vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
    
    if (remap_pfn_range(vma, vma->vm_start, pfn, vma_size, vma->vm_page_prot)) {
        pr_err("pynq_uio: remap_pfn_range failed\n");
        return -EAGAIN;
    }
    
    pr_info("pynq_uio: mmap successful\n");
    return 0;
}

static ssize_t create_store(struct class *class, struct class_attribute *attr,
                            const char *buf, size_t count)
{
    struct pynq_uio_device *uio_dev;
    struct uio_info *info;
    struct platform_device *pdev;
    unsigned long long phys_addr;
    unsigned long size;
    char name[64];
    int ret;
    
    if (sscanf(buf, "%llx,%lx,%63s", &phys_addr, &size, name) != 3) {
        pr_err("pynq_uio: Invalid format\n");
        return -EINVAL;
    }
    
    pr_info("pynq_uio: Creating %s @ 0x%llx (%lu bytes)\n", name, phys_addr, size);
    
    uio_dev = kzalloc(sizeof(*uio_dev), GFP_KERNEL);
    if (!uio_dev)
        return -ENOMEM;
    
    info = kzalloc(sizeof(*info), GFP_KERNEL);
    if (!info) {
        kfree(uio_dev);
        return -ENOMEM;
    }
    
    info->name = kstrdup(name, GFP_KERNEL);
    info->version = "1.0";
    info->mem[0].name = "buffer";
    info->mem[0].addr = phys_addr;
    info->mem[0].size = PAGE_ALIGN(size);  // Arrotonda a pagina
    info->mem[0].memtype = UIO_MEM_PHYS;
    info->mmap = pynq_uio_mmap;
    
    pdev = platform_device_alloc(name, next_minor);
    if (!pdev) {
        kfree((void*)info->name);
        kfree(info);
        kfree(uio_dev);
        return -ENOMEM;
    }
    
    ret = platform_device_add(pdev);
    if (ret) {
        platform_device_put(pdev);
        kfree((void*)info->name);
        kfree(info);
        kfree(uio_dev);
        return ret;
    }
    
    ret = uio_register_device(&pdev->dev, info);
    if (ret) {
        platform_device_unregister(pdev);
        kfree((void*)info->name);
        kfree(info);
        kfree(uio_dev);
        return ret;
    }
    
    uio_dev->info = info;
    uio_dev->pdev = pdev;
    uio_dev->phys_addr = phys_addr;
    uio_dev->size = size;
    uio_dev->minor = next_minor;
    strncpy(uio_dev->name, name, sizeof(uio_dev->name) - 1);
    
    mutex_lock(&device_list_lock);
    list_add_tail(&uio_dev->list, &device_list);
    next_minor++;
    mutex_unlock(&device_list_lock);
    
    pr_info("pynq_uio: Created /dev/uio%d\n", uio_dev->minor);
    
    return count;
}

static ssize_t destroy_store(struct class *class, struct class_attribute *attr,
                             const char *buf, size_t count)
{
    struct pynq_uio_device *uio_dev, *tmp;
    char name[64];
    
    if (sscanf(buf, "%63s", name) != 1)
        return -EINVAL;
    
    mutex_lock(&device_list_lock);
    list_for_each_entry_safe(uio_dev, tmp, &device_list, list) {
        if (strcmp(uio_dev->name, name) == 0) {
            uio_unregister_device(uio_dev->info);
            platform_device_unregister(uio_dev->pdev);
            kfree((void*)uio_dev->info->name);
            kfree(uio_dev->info);
            list_del(&uio_dev->list);
            kfree(uio_dev);
            mutex_unlock(&device_list_lock);
            return count;
        }
    }
    mutex_unlock(&device_list_lock);
    return -ENOENT;
}

static ssize_t list_show(struct class *class, struct class_attribute *attr, char *buf)
{
    struct pynq_uio_device *uio_dev;
    ssize_t len = 0;
    
    mutex_lock(&device_list_lock);
    list_for_each_entry(uio_dev, &device_list, list) {
        len += scnprintf(buf + len, PAGE_SIZE - len,
                        "uio%d: %s @ 0x%llx (%zu bytes)\n",
                        uio_dev->minor, uio_dev->name,
                        (unsigned long long)uio_dev->phys_addr, uio_dev->size);
    }
    mutex_unlock(&device_list_lock);
    return len;
}

static CLASS_ATTR_WO(create);
static CLASS_ATTR_WO(destroy);
static CLASS_ATTR_RO(list);

static int __init pynq_uio_init(void)
{
    int ret;
    pynq_uio_class = class_create(THIS_MODULE, "pynq_uio");
    if (IS_ERR(pynq_uio_class))
        return PTR_ERR(pynq_uio_class);
    
    ret = class_create_file(pynq_uio_class, &class_attr_create);
    if (ret) goto err_create;
    ret = class_create_file(pynq_uio_class, &class_attr_destroy);
    if (ret) goto err_destroy;
    ret = class_create_file(pynq_uio_class, &class_attr_list);
    if (ret) goto err_list;
    
    pr_info("pynq_uio: Module loaded\n");
    return 0;

err_list:
    class_remove_file(pynq_uio_class, &class_attr_destroy);
err_destroy:
    class_remove_file(pynq_uio_class, &class_attr_create);
err_create:
    class_destroy(pynq_uio_class);
    return ret;
}

static void __exit pynq_uio_exit(void)
{
    struct pynq_uio_device *uio_dev, *tmp;
    
    mutex_lock(&device_list_lock);
    list_for_each_entry_safe(uio_dev, tmp, &device_list, list) {
        uio_unregister_device(uio_dev->info);
        platform_device_unregister(uio_dev->pdev);
        kfree((void*)uio_dev->info->name);
        kfree(uio_dev->info);
        list_del(&uio_dev->list);
        kfree(uio_dev);
    }
    mutex_unlock(&device_list_lock);
    
    class_remove_file(pynq_uio_class, &class_attr_list);
    class_remove_file(pynq_uio_class, &class_attr_destroy);
    class_remove_file(pynq_uio_class, &class_attr_create);
    class_destroy(pynq_uio_class);
}

module_init(pynq_uio_init);
module_exit(pynq_uio_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("PYNQ UIO mapper");
MODULE_VERSION("1.2");
