#!/bin/sh
~/ghdl-macos-11-mcode/bin/ghdl -a ../utility/bookutility.vhd

~/ghdl-macos-11-mcode/bin/ghdl -a $1.vhd
~/ghdl-macos-11-mcode/bin/ghdl -a $1_tb.vhd

~/ghdl-macos-11-mcode/bin/ghdl -r $1_tb --wave=$1.ghw --vcd=$1.vcd