create_project -force vhdl-project

set_property "part" xc7z010-1-clg400 [current_project]

add_files ../hdl/blink.vhdl
set_property library blink_lib [get_files ../hdl/blink.vhdl]

add_files ../hdl/blink_pkg.vhdl
set_property library blink_lib [get_files ../hdl/blink_pkg.vhdl]

add_files ../hdl/top.vhdl
add_files ../resources/constraints/zybo/clk.xdc
add_files ../resources/constraints/zybo/led.xdc

set_property top Top [current_fileset]
set_property top_arch VIVADO [current_fileset]

# NOTE: support to specify a REAL generic was added into the Vivado 2020.2 version
# https://forums.xilinx.com/t5/Vivado-TCL-Community/How-to-specify-a-REAL-generic-in-Vivado/m-p/1209088#M9581
set_property "generic" "BOO=true INT=255 LOG=1'b1 VEC=8'b11111111 STR=WXYZ REA=1.1" -objects [get_filesets sources_1]

reset_run synth_1
launch_runs synth_1
wait_on_run synth_1

launch_runs impl_1
wait_on_run impl_1

open_run impl_1
write_bitstream -force project

close_project
