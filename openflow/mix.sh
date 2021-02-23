#!/bin/bash

set -e

DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

FLAGS="--std=08 -fsynopsys -fexplicit -frelaxed"

function msg () { tput setaf 6; echo "$1"; tput sgr0; }

function synth () {
$DOCKER hdlc/ghdl:yosys /bin/bash -c "
yosys -Q -m ghdl -p '
ghdl $FLAGS $1 -e;
read_verilog $2;
synth_ice40 -top $3 -json blink.json
'" > /dev/null
}

###############################################################################

msg "* Verilog Top"
synth "../resources/mix/blink.vhdl" "../resources/mix/top.v" "Top"

msg "* VHDL Top"
synth "../resources/mix/top.vhdl" "../resources/mix/blink.v" "Top"

###############################################################################

msg "* Verilog Top (alternative)"

$DOCKER hdlc/ghdl:yosys /bin/bash -c "
ghdl -a ../resources/mix/blink.vhdl
yosys -Q -m ghdl -p '
ghdl Blink;
read_verilog ../resources/mix/top.v;
synth_ice40 -top Top -json blink.json
'" > /dev/null

rm -fr *.cf *.edif *.json

msg "* VHDL Top (alternative)"

$DOCKER hdlc/ghdl:yosys /bin/bash -c "
ghdl -a $FLAGS --work=blink_lib ../resources/vhdl/blink.vhdl
ghdl -a $FLAGS --work=blink_lib ../resources/vhdl/blink_pkg.vhdl
ghdl -a $FLAGS ../resources/vhdl/top.vhdl
yosys -Q -m ghdl -p '
ghdl $FLAGS Top;
synth_xilinx -family xc7;
write_edif -pvector bra yosys.edif
'" > /dev/null

rm -fr *.cf *.edif *.json
