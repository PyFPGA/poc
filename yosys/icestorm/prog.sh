#!/bin/bash

set -e

DOCKER="docker run --rm -v $HOME:$HOME -w $PWD"

$DOCKER --device /dev/bus/usb hdlc/prog iceprog blink.bit
