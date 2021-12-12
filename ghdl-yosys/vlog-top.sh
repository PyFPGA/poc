#!/bin/bash

set -e

DIR=../resources/mix

yosys -Q -m ghdl -p "
ghdl $DIR/blink.vhdl -e;
read_verilog $DIR/top.v;
synth -top Top
"
