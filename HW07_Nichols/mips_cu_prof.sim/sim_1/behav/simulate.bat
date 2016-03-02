@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim main_control_unit_tb_behav -key {Behavioral:sim_1:Functional:main_control_unit_tb} -tclbatch main_control_unit_tb.tcl -view H:/EECS_645/HW07_Nichols/main_control_unit_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
