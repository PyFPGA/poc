#!/usr/bin/make

COMMAND=docker run --rm -it -v $$HOME:$$HOME -w $$PWD ghdl/synth:beta bash

all: vhdl vlog

vlog vhdl:
	$(COMMAND) $@.sh

clean:
	rm -fr *.cf
