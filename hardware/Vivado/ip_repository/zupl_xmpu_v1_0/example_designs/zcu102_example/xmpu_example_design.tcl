#
# Usage: "vivado -mode batch -source design.tcl" in a Vivado TCL shell
#      : run from same directly that contains "sources" directory
#

#get the base script directory
set script_dir [file dirname [info script]]
cd $script_dir

# How many cpus are available for use
  set_param general.maxThreads 8

#--------------------------------------------
#          Script / Workspace Setup
#--------------------------------------------
   #
set part          "xczu9eg-ffvb1156-2-e"
set version_return [version -short]
regex {(\d{4}).(\d{1})} $version_return match vivado_major vivado_minor
set ver           $match         ;# Version of Vivado
if {$ver >= 2021.1} {
	set boardName     "xilinx.com:zcu102:part0:3.4"
} else {
	set boardName     "xilinx.com:zcu102:part0:3.3"
}

set projectName   "pl_isolation_lab"
set bdName        "Base_Zynq_MPSoC"
set topModule     "$bdName\_wrapper"       ;# Name of the top HDL module
#
set sourceDir     "./sources"
set tclDir        "$sourceDir/tcl"
#
set impDir        "xmpu_example"
set  projectDir   "../../../zcu102_${ver}/$impDir"
#
set use_vhdl	1

start_gui

#------------------------------------------------------
#                  Project Generation
#------------------------------------------------------
if {[file exists $projectDir]} {
	file delete -force $projectDir
}
file mkdir $projectDir

create_project -force $projectName $projectDir -part $part

	set_property board_part $boardName [current_project]
	if {$use_vhdl == 1} {
		set_property target_language VHDL [current_project]
	}
        create_bd_design $bdName
		
			#instantiate_example_design -template xilinx.com:design:Base_Zynq_MPSoC:1.0 -design $bdName
			#update_compile_order -fileset sources_1
			
			set_property  ip_repo_paths  ../../ [current_project]
			update_ip_catalog
			
			puts "source $tclDir/xmpu_bd_${ver}.tcl"
			source $tclDir/xmpu_bd_${ver}.tcl
			regenerate_bd_layout
			
			if {$ver == 2020.1} {
			
				exclude_bd_addr_seg [get_bd_addr_segs zupl_xmpu_0/M_AXI_IN/M_AXI_IN] -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data]

			}

			save_bd_design
			
			make_wrapper -files [get_files $projectDir/$projectName\.srcs/sources_1/bd/Base_Zynq_MPSoC/Base_Zynq_MPSoC.bd] -top
			if {$use_vhdl == 1} {
				add_files -norecurse $projectDir/$projectName\.srcs/sources_1/bd/Base_Zynq_MPSoC/hdl/Base_Zynq_MPSoC_wrapper.vhd
			} else {
				add_files -norecurse $projectDir/$projectName\.srcs/sources_1/bd/Base_Zynq_MPSoC/hdl/Base_Zynq_MPSoC_wrapper.v
			}
			update_compile_order -fileset sources_1
	
			set_property synth_checkpoint_mode Singular [get_files  $projectDir/$projectName\.srcs/sources_1/bd/$bdName/$bdName\.bd]
			generate_target all [get_files  $projectDir/$projectName\.srcs/sources_1/bd/$bdName/$bdName.bd]
			export_ip_user_files -of_objects [get_files $projectDir/$projectName\.srcs/sources_1/bd/$bdName/$bdName\.bd] -no_script -sync -force -quiet
			
			create_ip_run [get_files -of_objects [get_fileset sources_1] $projectDir/$projectName\.srcs/sources_1/bd/$bdName/$bdName\.bd]
			launch_runs -jobs 6 $bdName\_synth_1
			wait_on_run $bdName\_synth_1
		
			export_simulation -of_objects [get_files $projectDir/$projectName\.srcs/sources_1/bd/$bdName/$bdName\.bd]     \
							  -directory $projectDir/$projectName\.ip_user_files/sim_scripts                              \
							  -ip_user_files_dir $projectDir/$projectName\.ip_user_files                                  \
							  -ipstatic_source_dir $projectDir/$projectName\.ip_user_files/ipstatic\
							  -lib_map_path [list {modelsim= $projectDir/$projectName\.cache/compile_simlib/modelsim}     \
												  {questa=   $projectDir/$projectName\.cache/compile_simlib/questa}       \
												  {riviera=  $projectDir/$projectName\.cache/compile_simlib/riviera}      \
												  {activehdl=$projectDir/$projectName\.cache/compile_simlib/activehdl}]   \
							  -use_ip_compiled_libs -force -quiet

		#timeStamp Finished IPI
		set systemTime [clock seconds]
		puts "[clock format $systemTime -format %H:%M:%S]: Finished IPI"


     # Implement the design through bitstream generation
		set_property STEPS.WRITE_BITSTREAM.ARGS.RAW_BITFILE true   [get_runs impl_1]
		set_property STEPS.WRITE_BITSTREAM.ARGS.MASK_FILE true     [get_runs impl_1]
		set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true      [get_runs impl_1]
		set_property STEPS.WRITE_BITSTREAM.ARGS.READBACK_FILE true [get_runs impl_1]

		launch_runs impl_1 -to_step write_bitstream -jobs 4
			wait_on_run impl_1
			#open_run impl_1
		#timeStamp Finished IMPLEMENTATION_THROUGH_BITSTREAM
		set systemTime [clock seconds]
		puts "[clock format $systemTime -format %H:%M:%S]: Finished IMPLEMENTATION_THROUGH_BITSTREAM"

		
     # Export the hardware for SDK
	 if {$ver <= 2019.1} {
		file mkdir $projectDir/$projectName.sdk
		file copy -force $projectDir/$projectName\.runs/impl_1/$bdName\_wrapper.sysdef $projectDir/$projectName\.sdk/$bdName\_wrapper.hdf
	 } else {
		file mkdir $projectDir/$projectName.vitis/$bdName\_wrapper_hw_platform
		write_hw_platform -fixed -force  -include_bit -file $projectDir/$projectName\.vitis/$bdName\_wrapper_hw_platform/$bdName\_wrapper.xsa
	 }
		#timeStamp Finished EXPORT_HARDWARE
		set systemTime [clock seconds]
		puts "[clock format $systemTime -format %H:%M:%S]: Finished EXPORT_HARDWARE"



