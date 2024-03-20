`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 02:06:09 PM
// Design Name: 
// Module Name: address
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


module address #(parameter depth = 10) (input clk, input rst, input en, output logic [$clog2(depth)-1:0] addr);

localparam nb = $clog2(depth);
always @(posedge clk, posedge rst)
    if(rst)
        addr <= {{(nb-1){1'b0}}, 1'b1};
    else if(en)
        if(addr == depth)
            addr <= {{(nb-1){1'b0}}, 1'b1};
        else
            addr <= addr + 1'b1;

endmodule
