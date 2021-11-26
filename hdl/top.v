`define ARCH "EMPTY"

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

localparam FREQ = 50000000;

Blink #(.FREQ (FREQ), .SECS (1))
    dut (.clk_i (clk_i), .led_o (led_o));

endmodule
