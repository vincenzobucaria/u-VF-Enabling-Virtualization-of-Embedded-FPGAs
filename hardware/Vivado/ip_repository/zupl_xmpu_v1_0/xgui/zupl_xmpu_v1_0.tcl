
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/zupl_xmpu_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Registers [ipgui::add_page $IPINST -name "Registers"]
  ipgui::add_param $IPINST -name "C_CTRL_REG_VAL" -parent ${Registers}
  ipgui::add_param $IPINST -name "C_POISON_REG_VAL" -parent ${Registers}
  ipgui::add_param $IPINST -name "C_IMR_REG_VAL" -parent ${Registers}
  ipgui::add_param $IPINST -name "C_LOCK_REG_VAL" -parent ${Registers}
  ipgui::add_param $IPINST -name "C_BYPASS_REG_VAL" -parent ${Registers}

  #Adding Page
  set Regions [ipgui::add_page $IPINST -name "Regions"]
  ipgui::add_param $IPINST -name "C_REGIONS_MAX" -parent ${Regions}
  #Adding Group
  set REGION_0 [ipgui::add_group $IPINST -name "REGION 0" -parent ${Regions} -display_name {Region 0}]
  set_property tooltip {Region 0} ${REGION_0}
  ipgui::add_param $IPINST -name "C_R00_START_REG_VAL" -parent ${REGION_0}
  ipgui::add_param $IPINST -name "C_R00_END_REG_VAL" -parent ${REGION_0}
  ipgui::add_param $IPINST -name "C_R00_MASTERS_REG_VAL" -parent ${REGION_0}
  ipgui::add_param $IPINST -name "C_R00_CONFIG_REG_VAL" -parent ${REGION_0}

  #Adding Group
  set Region_1 [ipgui::add_group $IPINST -name "Region 1" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R01_START_REG_VAL" -parent ${Region_1}
  ipgui::add_param $IPINST -name "C_R01_END_REG_VAL" -parent ${Region_1}
  ipgui::add_param $IPINST -name "C_R01_MASTERS_REG_VAL" -parent ${Region_1}
  ipgui::add_param $IPINST -name "C_R01_CONFIG_REG_VAL" -parent ${Region_1}

  #Adding Group
  set Region_2 [ipgui::add_group $IPINST -name "Region 2" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R02_START_REG_VAL" -parent ${Region_2}
  ipgui::add_param $IPINST -name "C_R02_END_REG_VAL" -parent ${Region_2}
  ipgui::add_param $IPINST -name "C_R02_MASTERS_REG_VAL" -parent ${Region_2}
  ipgui::add_param $IPINST -name "C_R02_CONFIG_REG_VAL" -parent ${Region_2}

  #Adding Group
  set Region_3 [ipgui::add_group $IPINST -name "Region 3" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R03_START_REG_VAL" -parent ${Region_3}
  ipgui::add_param $IPINST -name "C_R03_END_REG_VAL" -parent ${Region_3}
  ipgui::add_param $IPINST -name "C_R03_MASTERS_REG_VAL" -parent ${Region_3}
  ipgui::add_param $IPINST -name "C_R03_CONFIG_REG_VAL" -parent ${Region_3}

  #Adding Group
  set Region_4 [ipgui::add_group $IPINST -name "Region 4" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R04_START_REG_VAL" -parent ${Region_4}
  ipgui::add_param $IPINST -name "C_R04_END_REG_VAL" -parent ${Region_4}
  ipgui::add_param $IPINST -name "C_R04_MASTERS_REG_VAL" -parent ${Region_4}
  ipgui::add_param $IPINST -name "C_R04_CONFIG_REG_VAL" -parent ${Region_4}

  #Adding Group
  set Region_5 [ipgui::add_group $IPINST -name "Region 5" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R05_START_REG_VAL" -parent ${Region_5}
  ipgui::add_param $IPINST -name "C_R05_END_REG_VAL" -parent ${Region_5}
  ipgui::add_param $IPINST -name "C_R05_MASTERS_REG_VAL" -parent ${Region_5}
  ipgui::add_param $IPINST -name "C_R05_CONFIG_REG_VAL" -parent ${Region_5}

  #Adding Group
  set Region_6 [ipgui::add_group $IPINST -name "Region 6" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R06_START_REG_VAL" -parent ${Region_6}
  ipgui::add_param $IPINST -name "C_R06_END_REG_VAL" -parent ${Region_6}
  ipgui::add_param $IPINST -name "C_R06_MASTERS_REG_VAL" -parent ${Region_6}
  ipgui::add_param $IPINST -name "C_R06_CONFIG_REG_VAL" -parent ${Region_6}

  #Adding Group
  set Region_7 [ipgui::add_group $IPINST -name "Region 7" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R07_START_REG_VAL" -parent ${Region_7}
  ipgui::add_param $IPINST -name "C_R07_END_REG_VAL" -parent ${Region_7}
  ipgui::add_param $IPINST -name "C_R07_MASTERS_REG_VAL" -parent ${Region_7}
  ipgui::add_param $IPINST -name "C_R07_CONFIG_REG_VAL" -parent ${Region_7}

  #Adding Group
  set Region_8 [ipgui::add_group $IPINST -name "Region 8" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R08_START_REG_VAL" -parent ${Region_8}
  ipgui::add_param $IPINST -name "C_R08_END_REG_VAL" -parent ${Region_8}
  ipgui::add_param $IPINST -name "C_R08_MASTERS_REG_VAL" -parent ${Region_8}
  ipgui::add_param $IPINST -name "C_R08_CONFIG_REG_VAL" -parent ${Region_8}

  #Adding Group
  set Region_9 [ipgui::add_group $IPINST -name "Region 9" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R09_START_REG_VAL" -parent ${Region_9}
  ipgui::add_param $IPINST -name "C_R09_END_REG_VAL" -parent ${Region_9}
  ipgui::add_param $IPINST -name "C_R09_MASTERS_REG_VAL" -parent ${Region_9}
  ipgui::add_param $IPINST -name "C_R09_CONFIG_REG_VAL" -parent ${Region_9}

  #Adding Group
  set Region_10 [ipgui::add_group $IPINST -name "Region 10" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R10_START_REG_VAL" -parent ${Region_10}
  ipgui::add_param $IPINST -name "C_R10_END_REG_VAL" -parent ${Region_10}
  ipgui::add_param $IPINST -name "C_R10_MASTERS_REG_VAL" -parent ${Region_10}
  ipgui::add_param $IPINST -name "C_R10_CONFIG_REG_VAL" -parent ${Region_10}

  #Adding Group
  set Region_11 [ipgui::add_group $IPINST -name "Region 11" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R11_START_REG_VAL" -parent ${Region_11}
  ipgui::add_param $IPINST -name "C_R11_END_REG_VAL" -parent ${Region_11}
  ipgui::add_param $IPINST -name "C_R11_MASTERS_REG_VAL" -parent ${Region_11}
  ipgui::add_param $IPINST -name "C_R11_CONFIG_REG_VAL" -parent ${Region_11}

  #Adding Group
  set Region_12 [ipgui::add_group $IPINST -name "Region 12" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R12_START_REG_VAL" -parent ${Region_12}
  ipgui::add_param $IPINST -name "C_R12_END_REG_VAL" -parent ${Region_12}
  ipgui::add_param $IPINST -name "C_R12_MASTERS_REG_VAL" -parent ${Region_12}
  ipgui::add_param $IPINST -name "C_R12_CONFIG_REG_VAL" -parent ${Region_12}

  #Adding Group
  set Region_13 [ipgui::add_group $IPINST -name "Region 13" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R13_START_REG_VAL" -parent ${Region_13}
  ipgui::add_param $IPINST -name "C_R13_END_REG_VAL" -parent ${Region_13}
  ipgui::add_param $IPINST -name "C_R13_MASTERS_REG_VAL" -parent ${Region_13}
  ipgui::add_param $IPINST -name "C_R13_CONFIG_REG_VAL" -parent ${Region_13}

  #Adding Group
  set Region_14 [ipgui::add_group $IPINST -name "Region 14" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R14_START_REG_VAL" -parent ${Region_14}
  ipgui::add_param $IPINST -name "C_R14_END_REG_VAL" -parent ${Region_14}
  ipgui::add_param $IPINST -name "C_R14_MASTERS_REG_VAL" -parent ${Region_14}
  ipgui::add_param $IPINST -name "C_R14_CONFIG_REG_VAL" -parent ${Region_14}

  #Adding Group
  set Region_15 [ipgui::add_group $IPINST -name "Region 15" -parent ${Regions}]
  ipgui::add_param $IPINST -name "C_R15_START_REG_VAL" -parent ${Region_15}
  ipgui::add_param $IPINST -name "C_R15_END_REG_VAL" -parent ${Region_15}
  ipgui::add_param $IPINST -name "C_R15_MASTERS_REG_VAL" -parent ${Region_15}
  ipgui::add_param $IPINST -name "C_R15_CONFIG_REG_VAL" -parent ${Region_15}


  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {AXI Settings}]
  set_property tooltip {AXI Settings} ${Page_0}
  #Adding Group
  set S_AXI_XMPU_Config [ipgui::add_group $IPINST -name "S_AXI_XMPU_Config" -parent ${Page_0} -display_name {S_AXI_XMPU_Config}]
  ipgui::add_param $IPINST -name "C_S_AXI_XMPU_HIGHADDR" -parent ${S_AXI_XMPU_Config}
  ipgui::add_param $IPINST -name "C_S_AXI_XMPU_BASEADDR" -parent ${S_AXI_XMPU_Config}
  set C_S_AXI_XMPU_BUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_XMPU_BUSER_WIDTH" -parent ${S_AXI_XMPU_Config}]
  set_property tooltip {Width of optional user defined signal in write response channel} ${C_S_AXI_XMPU_BUSER_WIDTH}
  set C_S_AXI_XMPU_RUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_XMPU_RUSER_WIDTH" -parent ${S_AXI_XMPU_Config}]
  set_property tooltip {Width of optional user defined signal in read data channel} ${C_S_AXI_XMPU_RUSER_WIDTH}
  set C_S_AXI_XMPU_WUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_XMPU_WUSER_WIDTH" -parent ${S_AXI_XMPU_Config}]
  set_property tooltip {Width of optional user defined signal in write data channel} ${C_S_AXI_XMPU_WUSER_WIDTH}
  set C_S_AXI_XMPU_ARUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_XMPU_ARUSER_WIDTH" -parent ${S_AXI_XMPU_Config}]
  set_property tooltip {Width of optional user defined signal in read address channel} ${C_S_AXI_XMPU_ARUSER_WIDTH}
  set C_S_AXI_XMPU_AWUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_XMPU_AWUSER_WIDTH" -parent ${S_AXI_XMPU_Config}]
  set_property tooltip {Width of optional user defined signal in write address channel} ${C_S_AXI_XMPU_AWUSER_WIDTH}
  set C_S_AXI_XMPU_ADDR_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_XMPU_ADDR_WIDTH" -parent ${S_AXI_XMPU_Config}]
  set_property tooltip {Width of S_AXI address bus} ${C_S_AXI_XMPU_ADDR_WIDTH}
  set C_S_AXI_XMPU_DATA_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_XMPU_DATA_WIDTH" -parent ${S_AXI_XMPU_Config} -widget comboBox]
  set_property tooltip {Width of S_AXI data bus} ${C_S_AXI_XMPU_DATA_WIDTH}
  set C_S_AXI_XMPU_ID_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_XMPU_ID_WIDTH" -parent ${S_AXI_XMPU_Config}]
  set_property tooltip {Width of ID for for write address, write data, read address and read data} ${C_S_AXI_XMPU_ID_WIDTH}

  #Adding Group
  set S_AXI [ipgui::add_group $IPINST -name "S_AXI" -parent ${Page_0} -display_name {S_AXI}]
  set_property tooltip {S_AXI} ${S_AXI}
  ipgui::add_param $IPINST -name "C_S_AXI_ID_WIDTH" -parent ${S_AXI}
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${S_AXI}
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${S_AXI}
  ipgui::add_param $IPINST -name "C_S_AXI_AWUSER_WIDTH" -parent ${S_AXI}
  ipgui::add_param $IPINST -name "C_S_AXI_ARUSER_WIDTH" -parent ${S_AXI}

  #Adding Group
  set M_AXI [ipgui::add_group $IPINST -name "M_AXI" -parent ${Page_0} -display_name {M_AXI}]
  set_property tooltip {M_AXI} ${M_AXI}
  ipgui::add_param $IPINST -name "C_M_AXI_HIGHADDR" -parent ${M_AXI}
  ipgui::add_param $IPINST -name "C_M_AXI_BASEADDR" -parent ${M_AXI}


  ipgui::add_param $IPINST -name "c_test_ports"

}

proc update_PARAM_VALUE.C_POISON_REG_VAL { PARAM_VALUE.C_POISON_REG_VAL PARAM_VALUE.C_M_AXI_BASEADDR } {
	# Procedure called to update C_POISON_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_POISON_REG_VAL ${PARAM_VALUE.C_POISON_REG_VAL}
	set C_M_AXI_BASEADDR ${PARAM_VALUE.C_M_AXI_BASEADDR}
	set values(C_M_AXI_BASEADDR) [get_property value $C_M_AXI_BASEADDR]
	if { [gen_USERPARAMETER_C_POISON_REG_VAL_ENABLEMENT $values(C_M_AXI_BASEADDR)] } {
		set_property enabled true $C_POISON_REG_VAL
	} else {
		set_property enabled false $C_POISON_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_POISON_REG_VAL { PARAM_VALUE.C_POISON_REG_VAL } {
	# Procedure called to validate C_POISON_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R01_CONFIG_REG_VAL { PARAM_VALUE.C_R01_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R01_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R01_CONFIG_REG_VAL ${PARAM_VALUE.C_R01_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R01_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R01_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R01_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R01_CONFIG_REG_VAL { PARAM_VALUE.C_R01_CONFIG_REG_VAL } {
	# Procedure called to validate C_R01_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R01_END_REG_VAL { PARAM_VALUE.C_R01_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R01_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R01_END_REG_VAL ${PARAM_VALUE.C_R01_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R01_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R01_END_REG_VAL
	} else {
		set_property enabled false $C_R01_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R01_END_REG_VAL { PARAM_VALUE.C_R01_END_REG_VAL } {
	# Procedure called to validate C_R01_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R01_MASTERS_REG_VAL { PARAM_VALUE.C_R01_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R01_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R01_MASTERS_REG_VAL ${PARAM_VALUE.C_R01_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R01_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R01_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R01_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R01_MASTERS_REG_VAL { PARAM_VALUE.C_R01_MASTERS_REG_VAL } {
	# Procedure called to validate C_R01_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R01_START_REG_VAL { PARAM_VALUE.C_R01_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R01_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R01_START_REG_VAL ${PARAM_VALUE.C_R01_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R01_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R01_START_REG_VAL
	} else {
		set_property enabled false $C_R01_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R01_START_REG_VAL { PARAM_VALUE.C_R01_START_REG_VAL } {
	# Procedure called to validate C_R01_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R02_CONFIG_REG_VAL { PARAM_VALUE.C_R02_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R02_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R02_CONFIG_REG_VAL ${PARAM_VALUE.C_R02_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R02_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R02_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R02_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R02_CONFIG_REG_VAL { PARAM_VALUE.C_R02_CONFIG_REG_VAL } {
	# Procedure called to validate C_R02_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R02_END_REG_VAL { PARAM_VALUE.C_R02_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R02_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R02_END_REG_VAL ${PARAM_VALUE.C_R02_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R02_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R02_END_REG_VAL
	} else {
		set_property enabled false $C_R02_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R02_END_REG_VAL { PARAM_VALUE.C_R02_END_REG_VAL } {
	# Procedure called to validate C_R02_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R02_MASTERS_REG_VAL { PARAM_VALUE.C_R02_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R02_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R02_MASTERS_REG_VAL ${PARAM_VALUE.C_R02_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R02_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R02_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R02_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R02_MASTERS_REG_VAL { PARAM_VALUE.C_R02_MASTERS_REG_VAL } {
	# Procedure called to validate C_R02_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R02_START_REG_VAL { PARAM_VALUE.C_R02_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R02_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R02_START_REG_VAL ${PARAM_VALUE.C_R02_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R02_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R02_START_REG_VAL
	} else {
		set_property enabled false $C_R02_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R02_START_REG_VAL { PARAM_VALUE.C_R02_START_REG_VAL } {
	# Procedure called to validate C_R02_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R03_CONFIG_REG_VAL { PARAM_VALUE.C_R03_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R03_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R03_CONFIG_REG_VAL ${PARAM_VALUE.C_R03_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R03_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R03_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R03_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R03_CONFIG_REG_VAL { PARAM_VALUE.C_R03_CONFIG_REG_VAL } {
	# Procedure called to validate C_R03_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R03_END_REG_VAL { PARAM_VALUE.C_R03_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R03_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R03_END_REG_VAL ${PARAM_VALUE.C_R03_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R03_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R03_END_REG_VAL
	} else {
		set_property enabled false $C_R03_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R03_END_REG_VAL { PARAM_VALUE.C_R03_END_REG_VAL } {
	# Procedure called to validate C_R03_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R03_MASTERS_REG_VAL { PARAM_VALUE.C_R03_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R03_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R03_MASTERS_REG_VAL ${PARAM_VALUE.C_R03_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R03_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R03_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R03_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R03_MASTERS_REG_VAL { PARAM_VALUE.C_R03_MASTERS_REG_VAL } {
	# Procedure called to validate C_R03_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R03_START_REG_VAL { PARAM_VALUE.C_R03_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R03_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R03_START_REG_VAL ${PARAM_VALUE.C_R03_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R03_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R03_START_REG_VAL
	} else {
		set_property enabled false $C_R03_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R03_START_REG_VAL { PARAM_VALUE.C_R03_START_REG_VAL } {
	# Procedure called to validate C_R03_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R04_CONFIG_REG_VAL { PARAM_VALUE.C_R04_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R04_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R04_CONFIG_REG_VAL ${PARAM_VALUE.C_R04_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R04_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R04_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R04_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R04_CONFIG_REG_VAL { PARAM_VALUE.C_R04_CONFIG_REG_VAL } {
	# Procedure called to validate C_R04_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R04_END_REG_VAL { PARAM_VALUE.C_R04_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R04_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R04_END_REG_VAL ${PARAM_VALUE.C_R04_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R04_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R04_END_REG_VAL
	} else {
		set_property enabled false $C_R04_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R04_END_REG_VAL { PARAM_VALUE.C_R04_END_REG_VAL } {
	# Procedure called to validate C_R04_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R04_MASTERS_REG_VAL { PARAM_VALUE.C_R04_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R04_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R04_MASTERS_REG_VAL ${PARAM_VALUE.C_R04_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R04_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R04_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R04_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R04_MASTERS_REG_VAL { PARAM_VALUE.C_R04_MASTERS_REG_VAL } {
	# Procedure called to validate C_R04_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R04_START_REG_VAL { PARAM_VALUE.C_R04_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R04_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R04_START_REG_VAL ${PARAM_VALUE.C_R04_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R04_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R04_START_REG_VAL
	} else {
		set_property enabled false $C_R04_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R04_START_REG_VAL { PARAM_VALUE.C_R04_START_REG_VAL } {
	# Procedure called to validate C_R04_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R05_CONFIG_REG_VAL { PARAM_VALUE.C_R05_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R05_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R05_CONFIG_REG_VAL ${PARAM_VALUE.C_R05_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R05_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R05_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R05_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R05_CONFIG_REG_VAL { PARAM_VALUE.C_R05_CONFIG_REG_VAL } {
	# Procedure called to validate C_R05_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R05_END_REG_VAL { PARAM_VALUE.C_R05_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R05_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R05_END_REG_VAL ${PARAM_VALUE.C_R05_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R05_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R05_END_REG_VAL
	} else {
		set_property enabled false $C_R05_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R05_END_REG_VAL { PARAM_VALUE.C_R05_END_REG_VAL } {
	# Procedure called to validate C_R05_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R05_MASTERS_REG_VAL { PARAM_VALUE.C_R05_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R05_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R05_MASTERS_REG_VAL ${PARAM_VALUE.C_R05_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R05_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R05_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R05_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R05_MASTERS_REG_VAL { PARAM_VALUE.C_R05_MASTERS_REG_VAL } {
	# Procedure called to validate C_R05_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R05_START_REG_VAL { PARAM_VALUE.C_R05_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R05_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R05_START_REG_VAL ${PARAM_VALUE.C_R05_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R05_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R05_START_REG_VAL
	} else {
		set_property enabled false $C_R05_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R05_START_REG_VAL { PARAM_VALUE.C_R05_START_REG_VAL } {
	# Procedure called to validate C_R05_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R06_CONFIG_REG_VAL { PARAM_VALUE.C_R06_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R06_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R06_CONFIG_REG_VAL ${PARAM_VALUE.C_R06_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R06_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R06_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R06_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R06_CONFIG_REG_VAL { PARAM_VALUE.C_R06_CONFIG_REG_VAL } {
	# Procedure called to validate C_R06_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R06_END_REG_VAL { PARAM_VALUE.C_R06_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R06_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R06_END_REG_VAL ${PARAM_VALUE.C_R06_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R06_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R06_END_REG_VAL
	} else {
		set_property enabled false $C_R06_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R06_END_REG_VAL { PARAM_VALUE.C_R06_END_REG_VAL } {
	# Procedure called to validate C_R06_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R06_MASTERS_REG_VAL { PARAM_VALUE.C_R06_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R06_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R06_MASTERS_REG_VAL ${PARAM_VALUE.C_R06_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R06_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R06_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R06_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R06_MASTERS_REG_VAL { PARAM_VALUE.C_R06_MASTERS_REG_VAL } {
	# Procedure called to validate C_R06_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R06_START_REG_VAL { PARAM_VALUE.C_R06_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R06_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R06_START_REG_VAL ${PARAM_VALUE.C_R06_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R06_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R06_START_REG_VAL
	} else {
		set_property enabled false $C_R06_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R06_START_REG_VAL { PARAM_VALUE.C_R06_START_REG_VAL } {
	# Procedure called to validate C_R06_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R07_CONFIG_REG_VAL { PARAM_VALUE.C_R07_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R07_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R07_CONFIG_REG_VAL ${PARAM_VALUE.C_R07_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R07_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R07_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R07_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R07_CONFIG_REG_VAL { PARAM_VALUE.C_R07_CONFIG_REG_VAL } {
	# Procedure called to validate C_R07_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R07_END_REG_VAL { PARAM_VALUE.C_R07_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R07_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R07_END_REG_VAL ${PARAM_VALUE.C_R07_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R07_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R07_END_REG_VAL
	} else {
		set_property enabled false $C_R07_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R07_END_REG_VAL { PARAM_VALUE.C_R07_END_REG_VAL } {
	# Procedure called to validate C_R07_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R07_MASTERS_REG_VAL { PARAM_VALUE.C_R07_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R07_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R07_MASTERS_REG_VAL ${PARAM_VALUE.C_R07_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R07_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R07_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R07_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R07_MASTERS_REG_VAL { PARAM_VALUE.C_R07_MASTERS_REG_VAL } {
	# Procedure called to validate C_R07_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R07_START_REG_VAL { PARAM_VALUE.C_R07_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R07_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R07_START_REG_VAL ${PARAM_VALUE.C_R07_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R07_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R07_START_REG_VAL
	} else {
		set_property enabled false $C_R07_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R07_START_REG_VAL { PARAM_VALUE.C_R07_START_REG_VAL } {
	# Procedure called to validate C_R07_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R08_CONFIG_REG_VAL { PARAM_VALUE.C_R08_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R08_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R08_CONFIG_REG_VAL ${PARAM_VALUE.C_R08_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R08_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R08_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R08_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R08_CONFIG_REG_VAL { PARAM_VALUE.C_R08_CONFIG_REG_VAL } {
	# Procedure called to validate C_R08_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R08_END_REG_VAL { PARAM_VALUE.C_R08_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R08_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R08_END_REG_VAL ${PARAM_VALUE.C_R08_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R08_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R08_END_REG_VAL
	} else {
		set_property enabled false $C_R08_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R08_END_REG_VAL { PARAM_VALUE.C_R08_END_REG_VAL } {
	# Procedure called to validate C_R08_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R08_MASTERS_REG_VAL { PARAM_VALUE.C_R08_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R08_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R08_MASTERS_REG_VAL ${PARAM_VALUE.C_R08_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R08_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R08_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R08_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R08_MASTERS_REG_VAL { PARAM_VALUE.C_R08_MASTERS_REG_VAL } {
	# Procedure called to validate C_R08_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R08_START_REG_VAL { PARAM_VALUE.C_R08_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R08_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R08_START_REG_VAL ${PARAM_VALUE.C_R08_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R08_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R08_START_REG_VAL
	} else {
		set_property enabled false $C_R08_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R08_START_REG_VAL { PARAM_VALUE.C_R08_START_REG_VAL } {
	# Procedure called to validate C_R08_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R09_CONFIG_REG_VAL { PARAM_VALUE.C_R09_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R09_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R09_CONFIG_REG_VAL ${PARAM_VALUE.C_R09_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R09_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R09_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R09_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R09_CONFIG_REG_VAL { PARAM_VALUE.C_R09_CONFIG_REG_VAL } {
	# Procedure called to validate C_R09_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R09_END_REG_VAL { PARAM_VALUE.C_R09_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R09_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R09_END_REG_VAL ${PARAM_VALUE.C_R09_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R09_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R09_END_REG_VAL
	} else {
		set_property enabled false $C_R09_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R09_END_REG_VAL { PARAM_VALUE.C_R09_END_REG_VAL } {
	# Procedure called to validate C_R09_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R09_MASTERS_REG_VAL { PARAM_VALUE.C_R09_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R09_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R09_MASTERS_REG_VAL ${PARAM_VALUE.C_R09_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R09_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R09_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R09_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R09_MASTERS_REG_VAL { PARAM_VALUE.C_R09_MASTERS_REG_VAL } {
	# Procedure called to validate C_R09_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R09_START_REG_VAL { PARAM_VALUE.C_R09_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R09_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R09_START_REG_VAL ${PARAM_VALUE.C_R09_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R09_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R09_START_REG_VAL
	} else {
		set_property enabled false $C_R09_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R09_START_REG_VAL { PARAM_VALUE.C_R09_START_REG_VAL } {
	# Procedure called to validate C_R09_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R10_CONFIG_REG_VAL { PARAM_VALUE.C_R10_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R10_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R10_CONFIG_REG_VAL ${PARAM_VALUE.C_R10_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R10_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R10_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R10_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R10_CONFIG_REG_VAL { PARAM_VALUE.C_R10_CONFIG_REG_VAL } {
	# Procedure called to validate C_R10_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R10_END_REG_VAL { PARAM_VALUE.C_R10_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R10_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R10_END_REG_VAL ${PARAM_VALUE.C_R10_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R10_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R10_END_REG_VAL
	} else {
		set_property enabled false $C_R10_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R10_END_REG_VAL { PARAM_VALUE.C_R10_END_REG_VAL } {
	# Procedure called to validate C_R10_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R10_MASTERS_REG_VAL { PARAM_VALUE.C_R10_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R10_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R10_MASTERS_REG_VAL ${PARAM_VALUE.C_R10_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R10_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R10_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R10_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R10_MASTERS_REG_VAL { PARAM_VALUE.C_R10_MASTERS_REG_VAL } {
	# Procedure called to validate C_R10_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R10_START_REG_VAL { PARAM_VALUE.C_R10_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R10_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R10_START_REG_VAL ${PARAM_VALUE.C_R10_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R10_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R10_START_REG_VAL
	} else {
		set_property enabled false $C_R10_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R10_START_REG_VAL { PARAM_VALUE.C_R10_START_REG_VAL } {
	# Procedure called to validate C_R10_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R11_CONFIG_REG_VAL { PARAM_VALUE.C_R11_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R11_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R11_CONFIG_REG_VAL ${PARAM_VALUE.C_R11_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R11_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R11_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R11_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R11_CONFIG_REG_VAL { PARAM_VALUE.C_R11_CONFIG_REG_VAL } {
	# Procedure called to validate C_R11_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R11_END_REG_VAL { PARAM_VALUE.C_R11_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R11_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R11_END_REG_VAL ${PARAM_VALUE.C_R11_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R11_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R11_END_REG_VAL
	} else {
		set_property enabled false $C_R11_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R11_END_REG_VAL { PARAM_VALUE.C_R11_END_REG_VAL } {
	# Procedure called to validate C_R11_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R11_MASTERS_REG_VAL { PARAM_VALUE.C_R11_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R11_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R11_MASTERS_REG_VAL ${PARAM_VALUE.C_R11_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R11_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R11_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R11_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R11_MASTERS_REG_VAL { PARAM_VALUE.C_R11_MASTERS_REG_VAL } {
	# Procedure called to validate C_R11_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R11_START_REG_VAL { PARAM_VALUE.C_R11_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R11_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R11_START_REG_VAL ${PARAM_VALUE.C_R11_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R11_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R11_START_REG_VAL
	} else {
		set_property enabled false $C_R11_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R11_START_REG_VAL { PARAM_VALUE.C_R11_START_REG_VAL } {
	# Procedure called to validate C_R11_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R12_CONFIG_REG_VAL { PARAM_VALUE.C_R12_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R12_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R12_CONFIG_REG_VAL ${PARAM_VALUE.C_R12_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R12_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R12_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R12_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R12_CONFIG_REG_VAL { PARAM_VALUE.C_R12_CONFIG_REG_VAL } {
	# Procedure called to validate C_R12_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R12_END_REG_VAL { PARAM_VALUE.C_R12_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R12_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R12_END_REG_VAL ${PARAM_VALUE.C_R12_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R12_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R12_END_REG_VAL
	} else {
		set_property enabled false $C_R12_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R12_END_REG_VAL { PARAM_VALUE.C_R12_END_REG_VAL } {
	# Procedure called to validate C_R12_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R12_MASTERS_REG_VAL { PARAM_VALUE.C_R12_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R12_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R12_MASTERS_REG_VAL ${PARAM_VALUE.C_R12_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R12_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R12_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R12_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R12_MASTERS_REG_VAL { PARAM_VALUE.C_R12_MASTERS_REG_VAL } {
	# Procedure called to validate C_R12_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R12_START_REG_VAL { PARAM_VALUE.C_R12_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R12_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R12_START_REG_VAL ${PARAM_VALUE.C_R12_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R12_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R12_START_REG_VAL
	} else {
		set_property enabled false $C_R12_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R12_START_REG_VAL { PARAM_VALUE.C_R12_START_REG_VAL } {
	# Procedure called to validate C_R12_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R13_CONFIG_REG_VAL { PARAM_VALUE.C_R13_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R13_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R13_CONFIG_REG_VAL ${PARAM_VALUE.C_R13_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R13_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R13_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R13_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R13_CONFIG_REG_VAL { PARAM_VALUE.C_R13_CONFIG_REG_VAL } {
	# Procedure called to validate C_R13_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R13_END_REG_VAL { PARAM_VALUE.C_R13_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R13_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R13_END_REG_VAL ${PARAM_VALUE.C_R13_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R13_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R13_END_REG_VAL
	} else {
		set_property enabled false $C_R13_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R13_END_REG_VAL { PARAM_VALUE.C_R13_END_REG_VAL } {
	# Procedure called to validate C_R13_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R13_MASTERS_REG_VAL { PARAM_VALUE.C_R13_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R13_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R13_MASTERS_REG_VAL ${PARAM_VALUE.C_R13_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R13_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R13_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R13_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R13_MASTERS_REG_VAL { PARAM_VALUE.C_R13_MASTERS_REG_VAL } {
	# Procedure called to validate C_R13_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R13_START_REG_VAL { PARAM_VALUE.C_R13_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R13_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R13_START_REG_VAL ${PARAM_VALUE.C_R13_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R13_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R13_START_REG_VAL
	} else {
		set_property enabled false $C_R13_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R13_START_REG_VAL { PARAM_VALUE.C_R13_START_REG_VAL } {
	# Procedure called to validate C_R13_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R14_CONFIG_REG_VAL { PARAM_VALUE.C_R14_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R14_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R14_CONFIG_REG_VAL ${PARAM_VALUE.C_R14_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R14_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R14_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R14_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R14_CONFIG_REG_VAL { PARAM_VALUE.C_R14_CONFIG_REG_VAL } {
	# Procedure called to validate C_R14_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R14_END_REG_VAL { PARAM_VALUE.C_R14_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R14_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R14_END_REG_VAL ${PARAM_VALUE.C_R14_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R14_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R14_END_REG_VAL
	} else {
		set_property enabled false $C_R14_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R14_END_REG_VAL { PARAM_VALUE.C_R14_END_REG_VAL } {
	# Procedure called to validate C_R14_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R14_MASTERS_REG_VAL { PARAM_VALUE.C_R14_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R14_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R14_MASTERS_REG_VAL ${PARAM_VALUE.C_R14_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R14_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R14_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R14_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R14_MASTERS_REG_VAL { PARAM_VALUE.C_R14_MASTERS_REG_VAL } {
	# Procedure called to validate C_R14_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R14_START_REG_VAL { PARAM_VALUE.C_R14_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R14_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R14_START_REG_VAL ${PARAM_VALUE.C_R14_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R14_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R14_START_REG_VAL
	} else {
		set_property enabled false $C_R14_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R14_START_REG_VAL { PARAM_VALUE.C_R14_START_REG_VAL } {
	# Procedure called to validate C_R14_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R15_CONFIG_REG_VAL { PARAM_VALUE.C_R15_CONFIG_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R15_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R15_CONFIG_REG_VAL ${PARAM_VALUE.C_R15_CONFIG_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R15_CONFIG_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R15_CONFIG_REG_VAL
	} else {
		set_property enabled false $C_R15_CONFIG_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R15_CONFIG_REG_VAL { PARAM_VALUE.C_R15_CONFIG_REG_VAL } {
	# Procedure called to validate C_R15_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R15_END_REG_VAL { PARAM_VALUE.C_R15_END_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R15_END_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R15_END_REG_VAL ${PARAM_VALUE.C_R15_END_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R15_END_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R15_END_REG_VAL
	} else {
		set_property enabled false $C_R15_END_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R15_END_REG_VAL { PARAM_VALUE.C_R15_END_REG_VAL } {
	# Procedure called to validate C_R15_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R15_MASTERS_REG_VAL { PARAM_VALUE.C_R15_MASTERS_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R15_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R15_MASTERS_REG_VAL ${PARAM_VALUE.C_R15_MASTERS_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R15_MASTERS_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R15_MASTERS_REG_VAL
	} else {
		set_property enabled false $C_R15_MASTERS_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R15_MASTERS_REG_VAL { PARAM_VALUE.C_R15_MASTERS_REG_VAL } {
	# Procedure called to validate C_R15_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R15_START_REG_VAL { PARAM_VALUE.C_R15_START_REG_VAL PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_R15_START_REG_VAL when any of the dependent parameters in the arguments change
	
	set C_R15_START_REG_VAL ${PARAM_VALUE.C_R15_START_REG_VAL}
	set C_REGIONS_MAX ${PARAM_VALUE.C_REGIONS_MAX}
	set values(C_REGIONS_MAX) [get_property value $C_REGIONS_MAX]
	if { [gen_USERPARAMETER_C_R15_START_REG_VAL_ENABLEMENT $values(C_REGIONS_MAX)] } {
		set_property enabled true $C_R15_START_REG_VAL
	} else {
		set_property enabled false $C_R15_START_REG_VAL
	}
}

proc validate_PARAM_VALUE.C_R15_START_REG_VAL { PARAM_VALUE.C_R15_START_REG_VAL } {
	# Procedure called to validate C_R15_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_BYPASS_REG_INIT { PARAM_VALUE.C_BYPASS_REG_INIT } {
	# Procedure called to update C_BYPASS_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_BYPASS_REG_INIT { PARAM_VALUE.C_BYPASS_REG_INIT } {
	# Procedure called to validate C_BYPASS_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_BYPASS_REG_VAL { PARAM_VALUE.C_BYPASS_REG_VAL } {
	# Procedure called to update C_BYPASS_REG_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_BYPASS_REG_VAL { PARAM_VALUE.C_BYPASS_REG_VAL } {
	# Procedure called to validate C_BYPASS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_CTRL_REG_INIT { PARAM_VALUE.C_CTRL_REG_INIT } {
	# Procedure called to update C_CTRL_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CTRL_REG_INIT { PARAM_VALUE.C_CTRL_REG_INIT } {
	# Procedure called to validate C_CTRL_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_CTRL_REG_VAL { PARAM_VALUE.C_CTRL_REG_VAL } {
	# Procedure called to update C_CTRL_REG_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_CTRL_REG_VAL { PARAM_VALUE.C_CTRL_REG_VAL } {
	# Procedure called to validate C_CTRL_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_IMR_REG_INIT { PARAM_VALUE.C_IMR_REG_INIT } {
	# Procedure called to update C_IMR_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IMR_REG_INIT { PARAM_VALUE.C_IMR_REG_INIT } {
	# Procedure called to validate C_IMR_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_IMR_REG_VAL { PARAM_VALUE.C_IMR_REG_VAL } {
	# Procedure called to update C_IMR_REG_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IMR_REG_VAL { PARAM_VALUE.C_IMR_REG_VAL } {
	# Procedure called to validate C_IMR_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_IRQ_ACTIVE_STATE { PARAM_VALUE.C_IRQ_ACTIVE_STATE } {
	# Procedure called to update C_IRQ_ACTIVE_STATE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IRQ_ACTIVE_STATE { PARAM_VALUE.C_IRQ_ACTIVE_STATE } {
	# Procedure called to validate C_IRQ_ACTIVE_STATE
	return true
}

proc update_PARAM_VALUE.C_IRQ_SENSITIVITY { PARAM_VALUE.C_IRQ_SENSITIVITY } {
	# Procedure called to update C_IRQ_SENSITIVITY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IRQ_SENSITIVITY { PARAM_VALUE.C_IRQ_SENSITIVITY } {
	# Procedure called to validate C_IRQ_SENSITIVITY
	return true
}

proc update_PARAM_VALUE.C_LOCK_REG_INIT { PARAM_VALUE.C_LOCK_REG_INIT } {
	# Procedure called to update C_LOCK_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LOCK_REG_INIT { PARAM_VALUE.C_LOCK_REG_INIT } {
	# Procedure called to validate C_LOCK_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_LOCK_REG_VAL { PARAM_VALUE.C_LOCK_REG_VAL } {
	# Procedure called to update C_LOCK_REG_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_LOCK_REG_VAL { PARAM_VALUE.C_LOCK_REG_VAL } {
	# Procedure called to validate C_LOCK_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_POISON_REG_INIT { PARAM_VALUE.C_POISON_REG_INIT } {
	# Procedure called to update C_POISON_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_POISON_REG_INIT { PARAM_VALUE.C_POISON_REG_INIT } {
	# Procedure called to validate C_POISON_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_R00_CONFIG_REG_VAL { PARAM_VALUE.C_R00_CONFIG_REG_VAL } {
	# Procedure called to update C_R00_CONFIG_REG_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_R00_CONFIG_REG_VAL { PARAM_VALUE.C_R00_CONFIG_REG_VAL } {
	# Procedure called to validate C_R00_CONFIG_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R00_END_REG_VAL { PARAM_VALUE.C_R00_END_REG_VAL } {
	# Procedure called to update C_R00_END_REG_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_R00_END_REG_VAL { PARAM_VALUE.C_R00_END_REG_VAL } {
	# Procedure called to validate C_R00_END_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R00_MASTERS_REG_VAL { PARAM_VALUE.C_R00_MASTERS_REG_VAL } {
	# Procedure called to update C_R00_MASTERS_REG_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_R00_MASTERS_REG_VAL { PARAM_VALUE.C_R00_MASTERS_REG_VAL } {
	# Procedure called to validate C_R00_MASTERS_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_R00_START_REG_VAL { PARAM_VALUE.C_R00_START_REG_VAL } {
	# Procedure called to update C_R00_START_REG_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_R00_START_REG_VAL { PARAM_VALUE.C_R00_START_REG_VAL } {
	# Procedure called to validate C_R00_START_REG_VAL
	return true
}

proc update_PARAM_VALUE.C_REGIONS_MAX { PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to update C_REGIONS_MAX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_REGIONS_MAX { PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to validate C_REGIONS_MAX
	return true
}

proc update_PARAM_VALUE.C_R_CONFIG_REG_INIT { PARAM_VALUE.C_R_CONFIG_REG_INIT } {
	# Procedure called to update C_R_CONFIG_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_R_CONFIG_REG_INIT { PARAM_VALUE.C_R_CONFIG_REG_INIT } {
	# Procedure called to validate C_R_CONFIG_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_R_END_REG_INIT { PARAM_VALUE.C_R_END_REG_INIT } {
	# Procedure called to update C_R_END_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_R_END_REG_INIT { PARAM_VALUE.C_R_END_REG_INIT } {
	# Procedure called to validate C_R_END_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_R_MASTERS_REG_INIT { PARAM_VALUE.C_R_MASTERS_REG_INIT } {
	# Procedure called to update C_R_MASTERS_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_R_MASTERS_REG_INIT { PARAM_VALUE.C_R_MASTERS_REG_INIT } {
	# Procedure called to validate C_R_MASTERS_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_R_START_REG_INIT { PARAM_VALUE.C_R_START_REG_INIT } {
	# Procedure called to update C_R_START_REG_INIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_R_START_REG_INIT { PARAM_VALUE.C_R_START_REG_INIT } {
	# Procedure called to validate C_R_START_REG_INIT
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ARUSER_WIDTH { PARAM_VALUE.C_S_AXI_ARUSER_WIDTH } {
	# Procedure called to update C_S_AXI_ARUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ARUSER_WIDTH { PARAM_VALUE.C_S_AXI_ARUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_ARUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_AWUSER_WIDTH { PARAM_VALUE.C_S_AXI_AWUSER_WIDTH } {
	# Procedure called to update C_S_AXI_AWUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_AWUSER_WIDTH { PARAM_VALUE.C_S_AXI_AWUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_AWUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_BASEADDR { PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to update C_S_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_BASEADDR { PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to validate C_S_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_BUSER_WIDTH { PARAM_VALUE.C_S_AXI_BUSER_WIDTH } {
	# Procedure called to update C_S_AXI_BUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_BUSER_WIDTH { PARAM_VALUE.C_S_AXI_BUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_BUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_HIGHADDR { PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to update C_S_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_HIGHADDR { PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to validate C_S_AXI_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ID_WIDTH { PARAM_VALUE.C_S_AXI_ID_WIDTH } {
	# Procedure called to update C_S_AXI_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ID_WIDTH { PARAM_VALUE.C_S_AXI_ID_WIDTH } {
	# Procedure called to validate C_S_AXI_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_RUSER_WIDTH { PARAM_VALUE.C_S_AXI_RUSER_WIDTH } {
	# Procedure called to update C_S_AXI_RUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_RUSER_WIDTH { PARAM_VALUE.C_S_AXI_RUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_RUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_WUSER_WIDTH { PARAM_VALUE.C_S_AXI_WUSER_WIDTH } {
	# Procedure called to update C_S_AXI_WUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_WUSER_WIDTH { PARAM_VALUE.C_S_AXI_WUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_WUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.c_test_ports { PARAM_VALUE.c_test_ports } {
	# Procedure called to update c_test_ports when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.c_test_ports { PARAM_VALUE.c_test_ports } {
	# Procedure called to validate c_test_ports
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH } {
	# Procedure called to update C_S_AXI_XMPU_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH } {
	# Procedure called to validate C_S_AXI_XMPU_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_XMPU_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_XMPU_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_XMPU_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_XMPU_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH } {
	# Procedure called to update C_S_AXI_XMPU_AWUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_XMPU_AWUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH } {
	# Procedure called to update C_S_AXI_XMPU_ARUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_XMPU_ARUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH } {
	# Procedure called to update C_S_AXI_XMPU_WUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_XMPU_WUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH } {
	# Procedure called to update C_S_AXI_XMPU_RUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_XMPU_RUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH } {
	# Procedure called to update C_S_AXI_XMPU_BUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH { PARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_XMPU_BUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_BASEADDR { PARAM_VALUE.C_S_AXI_XMPU_BASEADDR } {
	# Procedure called to update C_S_AXI_XMPU_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_BASEADDR { PARAM_VALUE.C_S_AXI_XMPU_BASEADDR } {
	# Procedure called to validate C_S_AXI_XMPU_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_XMPU_HIGHADDR { PARAM_VALUE.C_S_AXI_XMPU_HIGHADDR } {
	# Procedure called to update C_S_AXI_XMPU_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_XMPU_HIGHADDR { PARAM_VALUE.C_S_AXI_XMPU_HIGHADDR } {
	# Procedure called to validate C_S_AXI_XMPU_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_M_AXI_BASEADDR { PARAM_VALUE.C_M_AXI_BASEADDR } {
	# Procedure called to update C_M_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_BASEADDR { PARAM_VALUE.C_M_AXI_BASEADDR } {
	# Procedure called to validate C_M_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_M_AXI_HIGHADDR { PARAM_VALUE.C_M_AXI_HIGHADDR } {
	# Procedure called to update C_M_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_HIGHADDR { PARAM_VALUE.C_M_AXI_HIGHADDR } {
	# Procedure called to validate C_M_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH { MODELPARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH PARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_XMPU_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH PARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_XMPU_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH PARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_XMPU_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH PARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_XMPU_AWUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH PARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_XMPU_ARUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH PARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_XMPU_WUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH PARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_XMPU_RUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH PARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_XMPU_BUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_IRQ_SENSITIVITY { MODELPARAM_VALUE.C_IRQ_SENSITIVITY PARAM_VALUE.C_IRQ_SENSITIVITY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IRQ_SENSITIVITY}] ${MODELPARAM_VALUE.C_IRQ_SENSITIVITY}
}

proc update_MODELPARAM_VALUE.C_IRQ_ACTIVE_STATE { MODELPARAM_VALUE.C_IRQ_ACTIVE_STATE PARAM_VALUE.C_IRQ_ACTIVE_STATE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IRQ_ACTIVE_STATE}] ${MODELPARAM_VALUE.C_IRQ_ACTIVE_STATE}
}

proc update_MODELPARAM_VALUE.C_CTRL_REG_VAL { MODELPARAM_VALUE.C_CTRL_REG_VAL PARAM_VALUE.C_CTRL_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_CTRL_REG_VAL}] ${MODELPARAM_VALUE.C_CTRL_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_POISON_REG_VAL { MODELPARAM_VALUE.C_POISON_REG_VAL PARAM_VALUE.C_POISON_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_POISON_REG_VAL}] ${MODELPARAM_VALUE.C_POISON_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_IMR_REG_VAL { MODELPARAM_VALUE.C_IMR_REG_VAL PARAM_VALUE.C_IMR_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IMR_REG_VAL}] ${MODELPARAM_VALUE.C_IMR_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_LOCK_REG_VAL { MODELPARAM_VALUE.C_LOCK_REG_VAL PARAM_VALUE.C_LOCK_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_LOCK_REG_VAL}] ${MODELPARAM_VALUE.C_LOCK_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_BYPASS_REG_VAL { MODELPARAM_VALUE.C_BYPASS_REG_VAL PARAM_VALUE.C_BYPASS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_BYPASS_REG_VAL}] ${MODELPARAM_VALUE.C_BYPASS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R00_START_REG_VAL { MODELPARAM_VALUE.C_R00_START_REG_VAL PARAM_VALUE.C_R00_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R00_START_REG_VAL}] ${MODELPARAM_VALUE.C_R00_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R00_END_REG_VAL { MODELPARAM_VALUE.C_R00_END_REG_VAL PARAM_VALUE.C_R00_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R00_END_REG_VAL}] ${MODELPARAM_VALUE.C_R00_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R00_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R00_MASTERS_REG_VAL PARAM_VALUE.C_R00_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R00_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R00_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R00_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R00_CONFIG_REG_VAL PARAM_VALUE.C_R00_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R00_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R00_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R01_START_REG_VAL { MODELPARAM_VALUE.C_R01_START_REG_VAL PARAM_VALUE.C_R01_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R01_START_REG_VAL}] ${MODELPARAM_VALUE.C_R01_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R01_END_REG_VAL { MODELPARAM_VALUE.C_R01_END_REG_VAL PARAM_VALUE.C_R01_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R01_END_REG_VAL}] ${MODELPARAM_VALUE.C_R01_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R01_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R01_MASTERS_REG_VAL PARAM_VALUE.C_R01_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R01_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R01_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R01_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R01_CONFIG_REG_VAL PARAM_VALUE.C_R01_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R01_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R01_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R02_START_REG_VAL { MODELPARAM_VALUE.C_R02_START_REG_VAL PARAM_VALUE.C_R02_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R02_START_REG_VAL}] ${MODELPARAM_VALUE.C_R02_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R02_END_REG_VAL { MODELPARAM_VALUE.C_R02_END_REG_VAL PARAM_VALUE.C_R02_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R02_END_REG_VAL}] ${MODELPARAM_VALUE.C_R02_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R02_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R02_MASTERS_REG_VAL PARAM_VALUE.C_R02_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R02_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R02_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R02_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R02_CONFIG_REG_VAL PARAM_VALUE.C_R02_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R02_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R02_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R03_START_REG_VAL { MODELPARAM_VALUE.C_R03_START_REG_VAL PARAM_VALUE.C_R03_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R03_START_REG_VAL}] ${MODELPARAM_VALUE.C_R03_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R03_END_REG_VAL { MODELPARAM_VALUE.C_R03_END_REG_VAL PARAM_VALUE.C_R03_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R03_END_REG_VAL}] ${MODELPARAM_VALUE.C_R03_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R03_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R03_MASTERS_REG_VAL PARAM_VALUE.C_R03_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R03_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R03_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R03_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R03_CONFIG_REG_VAL PARAM_VALUE.C_R03_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R03_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R03_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R04_START_REG_VAL { MODELPARAM_VALUE.C_R04_START_REG_VAL PARAM_VALUE.C_R04_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R04_START_REG_VAL}] ${MODELPARAM_VALUE.C_R04_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R04_END_REG_VAL { MODELPARAM_VALUE.C_R04_END_REG_VAL PARAM_VALUE.C_R04_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R04_END_REG_VAL}] ${MODELPARAM_VALUE.C_R04_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R04_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R04_MASTERS_REG_VAL PARAM_VALUE.C_R04_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R04_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R04_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R04_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R04_CONFIG_REG_VAL PARAM_VALUE.C_R04_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R04_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R04_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R05_START_REG_VAL { MODELPARAM_VALUE.C_R05_START_REG_VAL PARAM_VALUE.C_R05_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R05_START_REG_VAL}] ${MODELPARAM_VALUE.C_R05_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R05_END_REG_VAL { MODELPARAM_VALUE.C_R05_END_REG_VAL PARAM_VALUE.C_R05_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R05_END_REG_VAL}] ${MODELPARAM_VALUE.C_R05_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R05_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R05_MASTERS_REG_VAL PARAM_VALUE.C_R05_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R05_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R05_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R05_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R05_CONFIG_REG_VAL PARAM_VALUE.C_R05_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R05_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R05_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R06_START_REG_VAL { MODELPARAM_VALUE.C_R06_START_REG_VAL PARAM_VALUE.C_R06_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R06_START_REG_VAL}] ${MODELPARAM_VALUE.C_R06_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R06_END_REG_VAL { MODELPARAM_VALUE.C_R06_END_REG_VAL PARAM_VALUE.C_R06_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R06_END_REG_VAL}] ${MODELPARAM_VALUE.C_R06_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R06_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R06_MASTERS_REG_VAL PARAM_VALUE.C_R06_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R06_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R06_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R06_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R06_CONFIG_REG_VAL PARAM_VALUE.C_R06_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R06_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R06_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R07_START_REG_VAL { MODELPARAM_VALUE.C_R07_START_REG_VAL PARAM_VALUE.C_R07_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R07_START_REG_VAL}] ${MODELPARAM_VALUE.C_R07_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R07_END_REG_VAL { MODELPARAM_VALUE.C_R07_END_REG_VAL PARAM_VALUE.C_R07_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R07_END_REG_VAL}] ${MODELPARAM_VALUE.C_R07_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R07_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R07_MASTERS_REG_VAL PARAM_VALUE.C_R07_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R07_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R07_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R07_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R07_CONFIG_REG_VAL PARAM_VALUE.C_R07_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R07_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R07_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R08_START_REG_VAL { MODELPARAM_VALUE.C_R08_START_REG_VAL PARAM_VALUE.C_R08_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R08_START_REG_VAL}] ${MODELPARAM_VALUE.C_R08_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R08_END_REG_VAL { MODELPARAM_VALUE.C_R08_END_REG_VAL PARAM_VALUE.C_R08_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R08_END_REG_VAL}] ${MODELPARAM_VALUE.C_R08_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R08_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R08_MASTERS_REG_VAL PARAM_VALUE.C_R08_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R08_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R08_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R08_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R08_CONFIG_REG_VAL PARAM_VALUE.C_R08_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R08_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R08_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R09_START_REG_VAL { MODELPARAM_VALUE.C_R09_START_REG_VAL PARAM_VALUE.C_R09_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R09_START_REG_VAL}] ${MODELPARAM_VALUE.C_R09_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R09_END_REG_VAL { MODELPARAM_VALUE.C_R09_END_REG_VAL PARAM_VALUE.C_R09_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R09_END_REG_VAL}] ${MODELPARAM_VALUE.C_R09_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R09_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R09_MASTERS_REG_VAL PARAM_VALUE.C_R09_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R09_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R09_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R09_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R09_CONFIG_REG_VAL PARAM_VALUE.C_R09_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R09_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R09_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R10_START_REG_VAL { MODELPARAM_VALUE.C_R10_START_REG_VAL PARAM_VALUE.C_R10_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R10_START_REG_VAL}] ${MODELPARAM_VALUE.C_R10_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R10_END_REG_VAL { MODELPARAM_VALUE.C_R10_END_REG_VAL PARAM_VALUE.C_R10_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R10_END_REG_VAL}] ${MODELPARAM_VALUE.C_R10_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R10_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R10_MASTERS_REG_VAL PARAM_VALUE.C_R10_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R10_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R10_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R10_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R10_CONFIG_REG_VAL PARAM_VALUE.C_R10_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R10_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R10_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R11_START_REG_VAL { MODELPARAM_VALUE.C_R11_START_REG_VAL PARAM_VALUE.C_R11_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R11_START_REG_VAL}] ${MODELPARAM_VALUE.C_R11_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R11_END_REG_VAL { MODELPARAM_VALUE.C_R11_END_REG_VAL PARAM_VALUE.C_R11_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R11_END_REG_VAL}] ${MODELPARAM_VALUE.C_R11_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R11_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R11_MASTERS_REG_VAL PARAM_VALUE.C_R11_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R11_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R11_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R11_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R11_CONFIG_REG_VAL PARAM_VALUE.C_R11_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R11_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R11_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R12_START_REG_VAL { MODELPARAM_VALUE.C_R12_START_REG_VAL PARAM_VALUE.C_R12_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R12_START_REG_VAL}] ${MODELPARAM_VALUE.C_R12_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R12_END_REG_VAL { MODELPARAM_VALUE.C_R12_END_REG_VAL PARAM_VALUE.C_R12_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R12_END_REG_VAL}] ${MODELPARAM_VALUE.C_R12_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R12_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R12_MASTERS_REG_VAL PARAM_VALUE.C_R12_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R12_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R12_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R12_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R12_CONFIG_REG_VAL PARAM_VALUE.C_R12_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R12_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R12_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R13_START_REG_VAL { MODELPARAM_VALUE.C_R13_START_REG_VAL PARAM_VALUE.C_R13_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R13_START_REG_VAL}] ${MODELPARAM_VALUE.C_R13_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R13_END_REG_VAL { MODELPARAM_VALUE.C_R13_END_REG_VAL PARAM_VALUE.C_R13_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R13_END_REG_VAL}] ${MODELPARAM_VALUE.C_R13_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R13_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R13_MASTERS_REG_VAL PARAM_VALUE.C_R13_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R13_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R13_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R13_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R13_CONFIG_REG_VAL PARAM_VALUE.C_R13_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R13_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R13_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R14_START_REG_VAL { MODELPARAM_VALUE.C_R14_START_REG_VAL PARAM_VALUE.C_R14_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R14_START_REG_VAL}] ${MODELPARAM_VALUE.C_R14_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R14_END_REG_VAL { MODELPARAM_VALUE.C_R14_END_REG_VAL PARAM_VALUE.C_R14_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R14_END_REG_VAL}] ${MODELPARAM_VALUE.C_R14_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R14_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R14_MASTERS_REG_VAL PARAM_VALUE.C_R14_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R14_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R14_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R14_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R14_CONFIG_REG_VAL PARAM_VALUE.C_R14_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R14_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R14_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R15_START_REG_VAL { MODELPARAM_VALUE.C_R15_START_REG_VAL PARAM_VALUE.C_R15_START_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R15_START_REG_VAL}] ${MODELPARAM_VALUE.C_R15_START_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R15_END_REG_VAL { MODELPARAM_VALUE.C_R15_END_REG_VAL PARAM_VALUE.C_R15_END_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R15_END_REG_VAL}] ${MODELPARAM_VALUE.C_R15_END_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R15_MASTERS_REG_VAL { MODELPARAM_VALUE.C_R15_MASTERS_REG_VAL PARAM_VALUE.C_R15_MASTERS_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R15_MASTERS_REG_VAL}] ${MODELPARAM_VALUE.C_R15_MASTERS_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_R15_CONFIG_REG_VAL { MODELPARAM_VALUE.C_R15_CONFIG_REG_VAL PARAM_VALUE.C_R15_CONFIG_REG_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_R15_CONFIG_REG_VAL}] ${MODELPARAM_VALUE.C_R15_CONFIG_REG_VAL}
}

proc update_MODELPARAM_VALUE.C_REGIONS_MAX { MODELPARAM_VALUE.C_REGIONS_MAX PARAM_VALUE.C_REGIONS_MAX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_REGIONS_MAX}] ${MODELPARAM_VALUE.C_REGIONS_MAX}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ID_WIDTH { MODELPARAM_VALUE.C_S_AXI_ID_WIDTH PARAM_VALUE.C_S_AXI_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ID_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_AWUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_AWUSER_WIDTH PARAM_VALUE.C_S_AXI_AWUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_AWUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_AWUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ARUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_ARUSER_WIDTH PARAM_VALUE.C_S_AXI_ARUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ARUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ARUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_WUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_WUSER_WIDTH PARAM_VALUE.C_S_AXI_WUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_WUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_WUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_RUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_RUSER_WIDTH PARAM_VALUE.C_S_AXI_RUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_RUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_RUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_BUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_BUSER_WIDTH PARAM_VALUE.C_S_AXI_BUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_BUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_BUSER_WIDTH}
}

