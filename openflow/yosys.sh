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

###############################################################################

msg "* Parameters in Yosys"

$DOCKER hdlc/ghdl:yosys yosys -Q -p "
read_verilog -defer ../resources/verilog/parameters.v;
chparam -set BOO 1 -set INT 255 -set LOG 1 -set VEC 8'b11111111 -set STR \"WXYZ\" -set REA \"1.1\" Params
"
