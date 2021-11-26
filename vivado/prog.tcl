if { [ catch { open_hw_manager } ] } { open_hw }
connect_hw_server
open_hw_target
set obj [lindex [get_hw_devices [current_hw_device]] 0]
set_property PROGRAM.FILE project.bit $obj
program_hw_devices $obj
