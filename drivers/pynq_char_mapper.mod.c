#include <linux/build-salt.h>
#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(.gnu.linkonce.this_module) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used __section(__versions) = {
	{ 0x136a4a24, "module_layout" },
	{ 0xaa0ef526, "device_destroy" },
	{ 0x207c6fa5, "class_remove_file_ns" },
	{ 0x4533e9f2, "class_destroy" },
	{ 0xf354fb1, "class_create_file_ns" },
	{ 0x6091b333, "unregister_chrdev_region" },
	{ 0xc914c6e6, "__class_create" },
	{ 0xe3ec2f2b, "alloc_chrdev_region" },
	{ 0x47763fff, "kmalloc_caches" },
	{ 0x9445c4ea, "cdev_del" },
	{ 0xeaf8e496, "device_create_with_groups" },
	{ 0x7b99d526, "cdev_add" },
	{ 0xe63cbb45, "cdev_init" },
	{ 0xe346f67a, "__mutex_init" },
	{ 0x328a05f1, "strncpy" },
	{ 0x56e379d9, "kmem_cache_alloc" },
	{ 0xbcab6ee6, "sscanf" },
	{ 0x9a7aae83, "remap_pfn_range" },
	{ 0xdecd0b29, "__stack_chk_fail" },
	{ 0x37a0cba, "kfree" },
	{ 0x668b595, "_kstrtoul" },
	{ 0x8f678b07, "__stack_chk_guard" },
	{ 0x314b20c8, "scnprintf" },
	{ 0x67ea780, "mutex_unlock" },
	{ 0xc271c3be, "mutex_lock" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xc5850110, "printk" },
};

MODULE_INFO(depends, "");


MODULE_INFO(srcversion, "13CCF28BE7CCD89A7160EBF");
