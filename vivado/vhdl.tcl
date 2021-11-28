create_project -force vhdl-project

set_property "part" xc7z010-1-clg400 [current_project]

add_files ../resources/vhdl/blink.vhdl
set_property library blink_lib [get_files ../resources/vhdl/blink.vhdl]

add_files ../resources/vhdl/blink_pkg.vhdl
set_property library blink_lib [get_files ../resources/vhdl/blink_pkg.vhdl]

add_files ../resources/vhdl/top.vhdl
add_files ../resources/constraints/zybo/clk.xdc
add_files ../resources/constraints/zybo/led.xdc

set_property top Top [current_fileset]
set_property top_arch ARCH_SEL [current_fileset]

set GENERICS "FREQ=125000000 BOO=true INT=255 LOG=1'b1 VEC=8'b11111111 CHR=8'd90 STR=WXYZ REA=1.1 SKIP_ARCH=1"
set_property "generic" $GENERICS -objects [get_filesets sources_1]

set_property STEPS.SYNTH_DESIGN.ARGS.ASSERT true [get_runs synth_1]

reset_run synth_1
launch_runs synth_1
wait_on_run synth_1

launch_runs impl_1
wait_on_run impl_1

open_run impl_1
write_bitstream -force project

close_project
