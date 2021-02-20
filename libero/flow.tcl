new_project -name example -location libero -hdl {VHDL} -family {SmartFusion2}

set_device -family SmartFusion2 -die M2S010 -package tq144 -speed -1

create_links -hdl_source ../resources/vhdl/blink.vhdl
create_links -sdc ../resources/constraints/maker-board/clk.sdc
create_links -io_pdc ../resources/constraints/maker-board/clk.pdc
create_links -io_pdc ../resources/constraints/maker-board/led.pdc
build_design_hierarchy

set_root Blink

organize_tool_files -tool {SYNTHESIZE} \
  -file ../resources/constraints/maker-board/clk.sdc \
  -module Blink -input_type {constraint}

organize_tool_files -tool {PLACEROUTE} \
  -file ../resources/constraints/maker-board/clk.sdc \
  -file ../resources/constraints/maker-board/clk.pdc \
  -file ../resources/constraints/maker-board/led.pdc \
  -module Blink -input_type {constraint}

organize_tool_files -tool {VERIFYTIMING} \
  -file ../resources/constraints/maker-board/clk.sdc \
  -module Blink -input_type {constraint}

run_tool -name {SYNTHESIZE}

run_tool -name {PLACEROUTE}
run_tool -name {VERIFYTIMING}

run_tool -name {GENERATEPROGRAMMINGFILE}

close_project
