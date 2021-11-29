#!/bin/bash

set -e

DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

cat ../../resources/constraints/icestick/clk.pcf ../../resources/constraints/icestick/led.pcf > icestick.pcf

$DOCKER hdlc/ghdl:yosys /bin/bash -c "
yosys -Q -p '
read_verilog -defer ../../resources/vlog/blink.v;
synth_ice40 -top Blink -json blink.json
'"

$DOCKER hdlc/nextpnr:ice40  /bin/bash -c "
nextpnr-ice40 --json blink.json --hx8k --package tq144:4k --pcf icestick.pcf --asc blink.asc
"

$DOCKER hdlc/icestorm /bin/bash -c "
icepack blink.asc blink.bit
icetime -d hx8k -mtr blink.rpt blink.asc
"
