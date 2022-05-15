#!/bin/bash

set -e

yosys -Q -p '
verilog_defaults -add -I../resources/vlog/path1;
verilog_defaults -add -I../resources/vlog/path2;
verilog_defines -DARCH_SEL=1;
read_verilog -defer ../resources/vlog/blink.v;
read_verilog -defer ../resources/vlog/top.v;
chparam -set BOO 1 -set INT 255 -set LOG 1 -set VEC 255 -set CHR "Z" -set STR "WXYZ" -set SKIP_REA 1 Top;
synth -top Top
'
