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


module top #(parameter div = 50_000_000)(input clk, input rst, output [7:0] leds);


shreg shift_reg (.clk(clk), .rst(rst), .en(enable), .leds(leds));
clkdiv #(.div(div)) gen_enable(.clk(clk), .rst(rst), .slow(enable));

endmodule
