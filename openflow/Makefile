#!/usr/bin/make

DOCKER_CMD=docker run --rm -it -v $$HOME:$$HOME -w $$PWD ghdl/synth:beta

COMMAND=bash

flow mix:
	$(COMMAND) $@.sh

clean:
	rm -fr *.cf *.edif
