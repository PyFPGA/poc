#!/bin/bash

set -e

DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

$DOCKER --device /dev/bus/usb hdlc/prog openocd -f ${TRELLIS}/misc/openocd/ecp5-evn.cfg -c "transport select jtag; init; svf blink.svf; exit"
# tinyprog -p aux.bit
