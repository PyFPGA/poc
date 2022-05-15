#!/bin/bash

set -e

DIR=../resources/mix

yosys -Q -m ghdl -p "
ghdl $DIR/top.vhdl -e;
read_verilog $DIR/blink.v;
synth -top Top
"
