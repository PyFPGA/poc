new_project -name example -location libero -hdl {VHDL} -family {SmartFusion2}

set_device -family SmartFusion2 -die M2S010 -package tq144 -speed -1

create_links -hdl_source ../resources/verilog/path1/header1.vh
create_links -hdl_source ../resources/verilog/path2/header2.vh

create_links -hdl_source ../resources/verilog/blink.v

build_design_hierarchy

set_root Blink

# The Tcl for synplify is generated under "libero/synthesis", so an extra "../../" is needed
configure_tool -name {SYNTHESIZE} \
  -params {SYNPLIFY_OPTIONS:set_option -include_path "../resources/verilog/path1;../resources/verilog/path2"}

run_tool -name {SYNTHESIZE}

close_project
