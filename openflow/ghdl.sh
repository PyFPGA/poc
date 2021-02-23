#!/bin/bash

set -e

DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

FLAGS="--std=08 -fsynopsys -fexplicit -frelaxed"

function msg () { tput setaf 6; echo "$1"; tput sgr0; }

###############################################################################

msg "* GHDL Flow"

$DOCKER hdlc/ghdl:yosys /bin/bash -c "
ghdl -a $FLAGS --work=blink_lib ../resources/vhdl/blink.vhdl
ghdl -a $FLAGS --work=blink_lib ../resources/vhdl/blink_pkg.vhdl
ghdl -a $FLAGS ../resources/vhdl/top.vhdl
ghdl --synth $FLAGS Top
"

rm -fr *.cf

###############################################################################

msg "* Parameters in GHDL"

$DOCKER hdlc/ghdl:yosys ghdl -a $FLAGS ../resources/vhdl/generics.vhdl
#$DOCKER hdlc/ghdl:yosys ghdl --synth $FLAGS -gBOO=true -gINT=255 -gLOG=\'1\' -gSTR="WXYZ" Params
#$DOCKER hdlc/ghdl:yosys ghdl --synth $FLAGS -gBOO=true -gINT=255 -gLOG=\'1\' -gSTR="WXYZ" -gVEC="11111111" Params
#$DOCKER hdlc/ghdl:yosys ghdl --synth $FLAGS -gBOO=true -gINT=255 -gLOG=\'1\' -gSTR="WXYZ" -gREA=1.1 Params

rm -fr *.cf
