#!/usr/bin/make

COMMAND=docker run --rm -it -v $$HOME:$$HOME -w $$PWD hdlc/ghdl:yosys bash

all: vlog

vlog:
	$(COMMAND) $@.sh

clean:
	rm -fr *.cf
	make -C icestorm clean
	make -C trellis clean
