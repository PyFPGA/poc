if { [ catch { open_hw_manager } ] } { open_hw }
connect_hw_server
open_hw_target

puts "* Devices detected in the JTAG chain"
puts [get_hw_devices]

puts "* Programming the FPGA"

set obj [lindex [get_hw_devices [current_hw_device]] 0]
set_property PROGRAM.FILE project.bit $obj
program_hw_devices $obj

puts "* Done"
