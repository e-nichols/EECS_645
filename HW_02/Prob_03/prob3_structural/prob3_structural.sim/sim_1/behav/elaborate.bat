@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 8d6485fb46d84dbe86ad428233c1da19 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot prob3_structural_tb_behav xil_defaultlib.prob3_structural_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
