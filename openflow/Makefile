#!/usr/bin/make

DOCKER_CMD=docker run --rm -it -v $$HOME:$$HOME -w $$PWD ghdl/synth:beta

COMMAND=bash

flow mix params:
	$(COMMAND) $@.sh

clean:
	rm -fr *.cf *.edif
