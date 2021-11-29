#!/bin/bash

set -e

FLAGS="--std=08 -fsynopsys -fexplicit -frelaxed"

ghdl -a $FLAGS --work=blink_lib ../resources/vhdl/blink.vhdl
ghdl -a $FLAGS --work=blink_lib ../resources/vhdl/blink_pkg.vhdl
ghdl -a $FLAGS ../resources/vhdl/top.vhdl

GENERICS="-gBOO=true -gINT=255 -gLOG='1' -gVEC="11111111" -gCHR='Z' -gSTR="WXYZ" -gSKIP_REA=1"

yosys -Q -m ghdl -p "
ghdl $FLAGS $GENERICS Top ARCH_SEL;
synth -top Top
"

