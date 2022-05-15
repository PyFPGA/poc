#!/bin/bash

set -e

DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

$DOCKER hdlc/ghdl:yosys /bin/bash -c "
yosys -Q -p '
read_verilog -defer ../../resources/vlog/blink.v;
synth_ecp5 -top Blink -json blink.json
'"

$DOCKER hdlc/nextpnr:ecp5 /bin/bash -c "
nextpnr-ecp5 --json blink.json --25k --package CSFBGA285 --lpf ../../resources/constraints/orangecrab/clk.lpf --lpf ../../resources/constraints/orangecrab/led.lpf --textcfg blink.config
"

$DOCKER hdlc/prjtrellis /bin/bash -c "
ecppack --svf blink.svf blink.config blink.bit
"
