#!/bin/bash

set -e

DIR=../resources/vhdl

FLAGS="--std=08 -fsynopsys -fexplicit -frelaxed"

GENERICS="-gBOO=true -gINT=255 -gLOG='1' -gVEC="11111111" -gCHR='Z' -gSTR="WXYZ" -gSKIP_REA=1"

ghdl -a $FLAGS --work=blink_lib $DIR/blink.vhdl
ghdl -a $FLAGS --work=blink_lib $DIR/blink_pkg.vhdl
ghdl -a $FLAGS $DIR/top.vhdl

yosys -Q -m ghdl -p "
ghdl $FLAGS $GENERICS Top ARCH_SEL;
synth -top Top
"
