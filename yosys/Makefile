#!/usr/bin/make

COMMAND=docker run --rm -it -v $$HOME:$$HOME -w $$PWD hdlc/ghdl:yosys bash

all: vhdl vlog

vlog vhdl:
	$(COMMAND) $@.sh

clean:
	rm -fr *.cf
	make -C icestorm clean
	make -C trellis clean
