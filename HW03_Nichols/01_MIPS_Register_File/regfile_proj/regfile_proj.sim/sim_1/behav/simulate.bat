@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim regfile_tb_behav -key {Behavioral:sim_1:Functional:regfile_tb} -tclbatch regfile_tb.tcl -view H:/EECS_645/HW_03/01_MIPS_Register_File/regfile_proj/regfile_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
