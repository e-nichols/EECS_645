@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim prob3_structural_tb_behav -key {Behavioral:sim_1:Functional:prob3_structural_tb} -tclbatch prob3_structural_tb.tcl -view H:/EECS_645/HW_2/Prob_03/prob3_structural/prob3_structural_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
