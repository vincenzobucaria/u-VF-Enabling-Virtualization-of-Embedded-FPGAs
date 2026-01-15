

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "zupl_xmpu" "NUM_INSTANCES" "DEVICE_ID"  "C_S_AXI_XMPU_BASEADDR" "C_S_AXI_XMPU_HIGHADDR" "C_M_AXI_BASEADDR" "C_M_AXI_HIGHADDR" "C_REGIONS_MAX"
}
