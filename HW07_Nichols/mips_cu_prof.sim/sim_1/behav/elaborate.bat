@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 22c6fd3a469a4a63b5d5a02b2dbb91c4 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot main_control_unit_tb_behav xil_defaultlib.main_control_unit_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
