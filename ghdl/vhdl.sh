#!/bin/bash

set -e

DIR=../resources/vhdl

FLAGS="--std=08 -fsynopsys -fexplicit -frelaxed"

GENERICS="-gBOO=true -gINT=255 -gLOG='1' -gVEC="11111111" -gCHR='Z' -gSTR="WXYZ" -gSKIP_REA=1"

###############################################################################
# Alternative 1
###############################################################################

# This alternative is better to specify particular options per file

ghdl -a $FLAGS --work=blink_lib $DIR/blink.vhdl
ghdl -a $FLAGS --work=blink_lib $DIR/blink_pkg.vhdl
ghdl -a $FLAGS $DIR/top.vhdl

# --out=raw-vhdl generate a VHDL 93 netlist

ghdl synth $FLAGS --out=raw-vhdl $GENERICS Top ARCH_SEL

# This alternative creates .cf files

rm -fr *.cf

###############################################################################
# Alternative 2
###############################################################################

# This alternative is more concise

# --work=<LIBNAME> applies to the following files
# --out=verilog generate a Verilog netlist

ghdl synth $FLAGS --out=verilog $GENERICS \
  --work=blink_lib $DIR/blink.vhdl $DIR/blink_pkg.vhdl \
  --work=work $DIR/top.vhdl -e Top ARCH_SEL
