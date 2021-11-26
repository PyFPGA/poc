#!/bin/bash

set -e

FLAGS="--std=08 -fsynopsys -fexplicit -frelaxed"

ghdl -a $FLAGS --work=blink_lib ../resources/vhdl/blink.vhdl
ghdl -a $FLAGS --work=blink_lib ../resources/vhdl/blink_pkg.vhdl
ghdl -a $FLAGS ../resources/vhdl/top.vhdl
ghdl --synth $FLAGS -gBOO=true -gINT=255 -gLOG=\'1\' -gSTR="WXYZ" -gVEC="11111111" Top GHDL

## -gREA=1.1 -> unhandled override for generic "rea"


