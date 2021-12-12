#!/usr/bin/make

COMMAND=docker run --rm -it -v $$HOME:$$HOME -w $$PWD hdlc/ghdl:yosys bash

all: vhdl vhdl-top vlog-top

vhdl vhdl-top vlog-top:
	$(COMMAND) $@.sh

clean:
	rm -fr *.cf
