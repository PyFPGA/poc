project new example.xise

project set family  spartan6
project set device  xc6slx9
project set package csg324
project set speed   -2

xfile add ../resources/vhdl/blink.vhdl
xfile add ../resources/constraints/s6micro/clk.ucf
xfile add ../resources/constraints/s6micro/led.ucf
xfile add ../resources/constraints/s6micro/clk.xcf

project set top Blink

process run "Synthesize" -force rerun

process run "Translate" -force rerun
process run "Map" -force rerun
process run "Place & Route" -force rerun

process run "Generate Programming File" -force rerun

project close
