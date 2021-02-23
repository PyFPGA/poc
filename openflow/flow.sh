#!/bin/bash

set -e

DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

function msg () { tput setaf 6; echo "$1"; tput sgr0; }

###############################################################################

msg "* Yosys + nextpnr + IceStorm"

cat ../resources/constraints/edu-ciaa-fpga/clk.pcf ../resources/constraints/edu-ciaa-fpga/led.pcf > edu-ciaa-fpga.pcf

$DOCKER hdlc/ghdl:yosys /bin/bash -c "
yosys -Q -p '
read_verilog -defer ../resources/verilog/blink.v;
synth_ice40 -top Blink -json blink.json
'"

$DOCKER hdlc/nextpnr:ice40  /bin/bash -c "
nextpnr-ice40 --json blink.json --hx8k --package tq144:4k --pcf edu-ciaa-fpga.pcf --asc blink.asc
"

rm -f edu-ciaa-fpga.pcf

$DOCKER hdlc/icestorm /bin/bash -c "
icepack blink.asc blink.bit
icetime -d hx8k -mtr blink.rpt blink.asc
"

# $DOCKER --device /dev/bus/usb hdlc/prog iceprog blink.bit

rm -fr *.asc *.bit *.json *.rpt

##################################################################################

msg "* Yosys + nextpnr + Trellis"

$DOCKER hdlc/ghdl:yosys /bin/bash -c "
yosys -Q -p '
read_verilog -defer ../resources/verilog/blink.v;
synth_ecp5 -top Blink -json blink.json
'"

$DOCKER hdlc/nextpnr:ecp5 /bin/bash -c "
nextpnr-ecp5 --json blink.json --25k --package CSFBGA285 --lpf ../resources/constraints/orangecrab/clk.lpf --lpf ../resources/constraints/orangecrab/led.lpf --textcfg blink.config
"

$DOCKER hdlc/prjtrellis /bin/bash -c "
ecppack --svf blink.svf blink.config blink.bit
"

# $DOCKER --device /dev/bus/usb hdlc/prog openocd -f ${TRELLIS}/misc/openocd/ecp5-evn.cfg -c "transport select jtag; init; svf blink.svf; exit"
# tinyprog -p aux.bit

rm -fr *.bit *.config *.json *.svf
