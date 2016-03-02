@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 1d17545a3bea468f86187d4d558d5927 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot prob1_behavorial_tb_behav xil_defaultlib.prob1_behavorial_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
