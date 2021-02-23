#!/usr/bin/make

DOCKER_CMD=docker run --rm -it -v $$HOME:$$HOME -w $$PWD ghdl/synth:beta

COMMAND=bash

flow ghdl mix params yosys:
	$(COMMAND) $@.sh

clean:
	rm -fr *.cf *.edif
