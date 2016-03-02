@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim prob1_struct_tb_behav -key {Behavioral:sim_1:Functional:prob1_struct_tb} -tclbatch prob1_struct_tb.tcl -view H:/EECS_645/HW_2/Prob_01/problem1_structural/prob1_struct_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
