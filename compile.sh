#!/bin/sh
~/ghdl-macos-11-mcode/bin/ghdl -a utility/bookutility.vhd

~/ghdl-macos-11-mcode/bin/ghdl -a $1/$1.vhd
~/ghdl-macos-11-mcode/bin/ghdl -a $1/$1_tb.vhd

~/ghdl-macos-11-mcode/bin/ghdl -r $1_tb --vcd=tests/$1.vcd