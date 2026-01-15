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
set projectName   "ps_isolation_lab"
set bdName        "Base_Zynq_MPSoC"
set topModule     "$bdName\_wrapper"       ;# Name of the top HDL module
#
set sourceDir     "./sources"
set tclDir        "$sourceDir/tcl"
#
set impDir        "xapp1320_example"
set  projectDir   "../../../zcu102_${ver}/$impDir"
#


start_gui

#------------------------------------------------------
#                  Project Generation
#------------------------------------------------------
file mkdir $projectDir

create_project -force $projectName $projectDir -part $part

	  set_property board_part $boardName [current_project]

        create_bd_design $bdName
		
			puts "source $tclDir/BuildBD_${ver}.tcl"
			source $tclDir/BuildBD_${ver}.tcl
			regenerate_bd_layout
			save_bd_design
	
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



		



