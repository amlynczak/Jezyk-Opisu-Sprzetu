`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 12:33:51 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top #(parameter div = 50_000_000)(input clk, input rst, start, output [7:0] leds);


shreg shift_reg (.clk(clk), .rst(rst), .en(enable), .sin(sin), .leds(leds), .status(status));
clkdiv #(.div(div)) gen_enable(.clk(clk), .rst(rst), .slow(enable));
automat fsm(.clk(clk), .rst(rst), .start(start), .status(status), .en(enable), .for_serial_in(sin));

endmodule
