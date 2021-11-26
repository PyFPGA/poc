`include "header1.vh"
`include "header2.vh"

`define FREQ `DEFAULT_FREQ
`define SECS `DEFAULT_SECS

module Top #(
  parameter BOO = 0,
  parameter INT = 0,
  parameter LOG = 1'b0,
  parameter VEC = 8'd0,
  parameter STR = "ABCD",
  parameter REA = 0.0
)(
  input  wire clk_i,
  output wire led_o
);

`ifdef VIVADO

  generate if (BOO==1 & INT==255 & LOG==1'b1 & VEC==8'b11111111 & STR=="WXYZ" & REA==1.1)
    Blink #(.FREQ (`FREQ), .SECS (`SECS))
    dut (.clk_i (clk_i), .led_o (led_o));
  endgenerate

`else

  assign led_o = 1'b1;

`endif

endmodule
