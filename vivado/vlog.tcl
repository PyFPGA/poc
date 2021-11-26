create_project -force vlog-project

set_property "part" xc7z010-1-clg400 [current_project]

add_files ../hdl/blink.v

add_files ../hdl/top.v
add_files ../resources/constraints/zybo/clk.xdc
add_files ../resources/constraints/zybo/led.xdc

set_property top Top [current_fileset]

set_property "generic" "BOO=1 INT=255 LOG=1'b1 VEC=8'b11111111 STR=WXYZ REA=1.1" -objects [get_filesets sources_1]

reset_run synth_1
launch_runs synth_1
wait_on_run synth_1

launch_runs impl_1
wait_on_run impl_1

open_run impl_1
write_bitstream -force project

close_project
