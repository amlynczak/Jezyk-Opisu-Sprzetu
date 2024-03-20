`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 12:33:51 PM
// Design Name: 
// Module Name: shreg
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


module shreg(input clk, input rst, input en, output logic [7:0] leds);
always @(posedge clk, posedge rst)
    if(rst)
        leds <= {7'b0, 1'b1};
    else if(en)
        leds <= {leds[6:0], leds[7]};
endmodule
