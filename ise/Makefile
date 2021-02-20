#!/usr/bin/make

COMMAND=xtclsh

flow params:
	$(COMMAND) $@.tcl

version:
	echo "puts \$$tcl_version" | xtclsh

clean:
	rm -fr \
	*.bgn *.bit *.bld *.cmd_log *.drc *.lso *.ncd *.ngc *.ngd *.ngr      \
	*.pad *.par *.pcf *.prj *.ptwx *.stx *.syr *.twr *.twx *.unroutes    \
	*.ut *.xpi *.xst *.xwbt *.map *.mrp *.ngm *.xrpt *.csv *.gise *.xise \
	_ngo _xmsgs xlnx_auto_0_xdb xst .Xil
	rm -fr *.html *.log *.txt *.xml
