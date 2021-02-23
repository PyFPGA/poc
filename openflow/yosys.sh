#!/bin/bash

set -e

DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

function msg () { tput setaf 6; echo "$1"; tput sgr0; }

#################################################################################

msg "* Yosys Flow"

$DOCKER hdlc/ghdl:yosys yosys -Q -p '
verilog_defaults -add -I../resources/verilog/path1;
verilog_defaults -add -I../resources/verilog/path2;
read_verilog -defer ../resources/verilog/paths.v;
synth_xilinx -top Paths -family xc7;
write_edif -pvector bra yosys.edif
'

rm -fr *.edif
