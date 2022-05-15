#!/bin/bash

set -e

for DIR in */ ; do
  if test -f "$DIR/Makefile"; then
    make -C $DIR clean
  fi
done
