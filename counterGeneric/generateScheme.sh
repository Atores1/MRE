#!/bin/sh
ghdl -a --std=08 $1.vhdl
#yosys -m ghdl -p "ghdl --std=08 ${TOP}; prep -top ${TOP}; write_json -compat-int svg.json"
yosys -m ghdl -p "ghdl $1.vhdl -e $1; write_json -compat-int svg.json"
netlistsvg svg.json -o $1.svg