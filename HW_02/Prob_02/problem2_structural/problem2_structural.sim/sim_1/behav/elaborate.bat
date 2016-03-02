@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 845dd1503597450da0c5e13488e588da -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot prob2_structural_tb_behav xil_defaultlib.prob2_structural_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
