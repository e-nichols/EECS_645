@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto f47a5b033d0c4ec6a80729d6730b7e96 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot prob2_behavorial_tb_behav xil_defaultlib.prob2_behavorial_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
