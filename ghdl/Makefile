#!/usr/bin/make

COMMAND=docker run --rm -it -v $$HOME:$$HOME -w $$PWD hdlc/ghdl:yosys bash

vhdl:
	$(COMMAND) $@.sh

clean:
	rm -fr *.cf
