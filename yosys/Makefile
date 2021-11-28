#!/usr/bin/make

DOCKER_CMD=docker run --rm -it -v $$HOME:$$HOME -w $$PWD ghdl/synth:beta

COMMAND=bash

vlog vhdl:
	$(DOCKER_CMD) $(COMMAND) $@.sh

clean:
	rm -fr *.cf
