@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim DM_tb_behav -key {Behavioral:sim_1:Functional:DM_tb} -tclbatch DM_tb.tcl -view H:/EECS_645/HW_03/02_MIPS_Data_Memory/DM_proj/DM_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
