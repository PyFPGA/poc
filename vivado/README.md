# Notes about Vivado

> Last update: Vivado 2021.2

* FREQ=125MHz to match the employed clock of the ZYBO.

VHDL:
* Support to specify a REAL generic was added/fixed in the Vivado 2020.2 version
  * https://forums.xilinx.com/t5/Vivado-TCL-Community/How-to-specify-a-REAL-generic-in-Vivado/m-p/1209088#M9581
* Specify an architecture is supported, but not working
  * https://support.xilinx.com/s/question/0D52E00006r9kHiSAI/specify-a-vhdl-architecture-seems-not-working
  * As a workaround, I set SKIP_ARCH
* Values are specified following Verilog notation.
  * In case of character, is needed to specify the ASCII value

Verilog:
* `$finish` is ignored, but fortunatly `$error("some text")` produces the desired result.
