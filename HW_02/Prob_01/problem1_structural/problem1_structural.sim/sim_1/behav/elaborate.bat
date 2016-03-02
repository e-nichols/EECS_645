@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 112d6416fd3445cbac822aa5732eeb21 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot prob1_struct_tb_behav xil_defaultlib.prob1_struct_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
