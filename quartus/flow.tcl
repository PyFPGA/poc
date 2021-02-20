package require ::quartus::flow

project_new example -overwrite
set_global_assignment -name NUM_PARALLEL_PROCESSORS ALL

set_global_assignment -name DEVICE 5CSEBA6U23I7

set_global_assignment -name VHDL_FILE ../resources/vhdl/blink.vhdl
source ../resources/constraints/de10nano/clk.tcl
source ../resources/constraints/de10nano/led.tcl
set_global_assignment -name SDC_FILE ../resources/constraints/de10nano/clk.sdc

set_global_assignment -name TOP_LEVEL_ENTITY Blink

execute_module -tool map

execute_module -tool fit
execute_module -tool sta

execute_module -tool asm

project_close
