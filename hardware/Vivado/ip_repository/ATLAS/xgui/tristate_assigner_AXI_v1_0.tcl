# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_HIGHADDR" -parent ${Page_0}

  ipgui::add_param $IPINST -name "N_PINS"
  ipgui::add_param $IPINST -name "N_VPIN_TOTAL"
  ipgui::add_param $IPINST -name "MAP_WIDTH"
  ipgui::add_param $IPINST -name "SYNC_INPUT"

}

proc update_PARAM_VALUE.MAP_WIDTH { PARAM_VALUE.MAP_WIDTH } {
	# Procedure called to update MAP_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAP_WIDTH { PARAM_VALUE.MAP_WIDTH } {
	# Procedure called to validate MAP_WIDTH
	return true
}

proc update_PARAM_VALUE.N_PINS { PARAM_VALUE.N_PINS } {
	# Procedure called to update N_PINS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N_PINS { PARAM_VALUE.N_PINS } {
	# Procedure called to validate N_PINS
	return true
}

proc update_PARAM_VALUE.N_VPIN_TOTAL { PARAM_VALUE.N_VPIN_TOTAL } {
	# Procedure called to update N_VPIN_TOTAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N_VPIN_TOTAL { PARAM_VALUE.N_VPIN_TOTAL } {
	# Procedure called to validate N_VPIN_TOTAL
	return true
}

proc update_PARAM_VALUE.SYNC_INPUT { PARAM_VALUE.SYNC_INPUT } {
	# Procedure called to update SYNC_INPUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SYNC_INPUT { PARAM_VALUE.SYNC_INPUT } {
	# Procedure called to validate SYNC_INPUT
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.N_PINS { MODELPARAM_VALUE.N_PINS PARAM_VALUE.N_PINS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N_PINS}] ${MODELPARAM_VALUE.N_PINS}
}

proc update_MODELPARAM_VALUE.N_VPIN_TOTAL { MODELPARAM_VALUE.N_VPIN_TOTAL PARAM_VALUE.N_VPIN_TOTAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N_VPIN_TOTAL}] ${MODELPARAM_VALUE.N_VPIN_TOTAL}
}

proc update_MODELPARAM_VALUE.MAP_WIDTH { MODELPARAM_VALUE.MAP_WIDTH PARAM_VALUE.MAP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAP_WIDTH}] ${MODELPARAM_VALUE.MAP_WIDTH}
}

proc update_MODELPARAM_VALUE.SYNC_INPUT { MODELPARAM_VALUE.SYNC_INPUT PARAM_VALUE.SYNC_INPUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SYNC_INPUT}] ${MODELPARAM_VALUE.SYNC_INPUT}
}

