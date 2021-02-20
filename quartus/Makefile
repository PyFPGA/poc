#!/usr/bin/make

COMMAND=quartus_sh --script

flow params:
	$(COMMAND) $@.tcl

clean:
	rm -fr *.rpt *.done *.summary *.jdi *.pin *.qpf *.qsf *.sld *.sof db incremental_db
	rm -fr *.html *.log *.txt *.xml
