#!/usr/bin/make

COMMAND="vivado -mode batch -notrace -quiet -source"

flow params:
	$(COMMAND) $@.tcl

clean:
	rm -fr *.bit *.cache *.hw *.runs *.xpr *.jou *.ip_user_files
	rm -fr *.html *.log *.txt *.xml
