# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a50ticsg325-1L

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir H:/EECS_645/HW_2/Prob_01/problem1_behavorial/problem1_behavorial.cache/wt [current_project]
set_property parent.project_path H:/EECS_645/HW_2/Prob_01/problem1_behavorial/problem1_behavorial.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib H:/EECS_645/HW_2/Prob_01/problem1_behavorial/problem1_behavorial.srcs/sources_1/new/prob1_behavorial.vhd
synth_design -top prob01_behav -part xc7a50ticsg325-1L
write_checkpoint -noxdef prob01_behav.dcp
catch { report_utilization -file prob01_behav_utilization_synth.rpt -pb prob01_behav_utilization_synth.pb }
