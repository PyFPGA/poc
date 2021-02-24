#!/bin/bash

set -e

#DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

function msg () { tput setaf 6; echo "$1"; tput sgr0; }

###############################################################################

msg "* xc7"

TOP=Top
VERILOG="../resources/verilog/blink.v ../resources/verilog/top.v"

PROJECT=Top

BITSTREAM_DEVICE=artix7
PARTNAME=xc7a35tcsg324-1
DEVICE=xc7a50t_test

XDC=arty-a7-35t.xdc
cat ../resources/constraints/arty-a7-35t/clk.xdc ../resources/constraints/arty-a7-35t/led.xdc > $XDC

SDC=/dev/null
PCF=/dev/null

#$DOCKER hdlc/symbiflow /bin/bash -c "
symbiflow_synth -t $TOP -v $VERILOG -d $BITSTREAM_DEVICE -p $PARTNAME -x $XDC
symbiflow_pack -e $PROJECT.eblif -d $DEVICE -s $SDC
symbiflow_place -e $PROJECT.eblif -d $DEVICE -p $PCF -n $PROJECT.net -P $PARTNAME -s $SDC
symbiflow_route -e $PROJECT.eblif -d $DEVICE -s $SDC
symbiflow_write_fasm -e $PROJECT.eblif -d $DEVICE
symbiflow_write_bitstream -d $BITSTREAM_DEVICE -f $PROJECT.fasm -p $PARTNAME -b $PROJECT.bit
#"

rm -f $XDC
