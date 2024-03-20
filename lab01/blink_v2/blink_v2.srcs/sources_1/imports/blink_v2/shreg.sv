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


module shreg(input clk, input rst, input en, sin, output logic [7:0] leds, output status);
always @(posedge clk, posedge rst)
    if(rst)
        leds <= 8'b0;
    else if(en)
        leds <= {leds[6:0], leds[7] | sin};
assign status = {leds == 8'b0};

endmodule
