`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 12:09:51 PM
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


module top(
    input clk,
    input rst,
    input bt_add,
    input bt_sub,
    input el_add,
    input el_sub,
    output [7:0] leds
    );
    
    cnt counter(.clk(clk), .rst(rst), .bt_add(bt_add), .bt_sub(bt_sub), .el_add(el_add), .el_sub(el_sub), .leds(leds));
    
endmodule
