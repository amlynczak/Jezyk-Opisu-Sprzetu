`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 12:33:51 PM
// Design Name: 
// Module Name: clkdiv
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


module clkdiv #(parameter div = 100)(input clk, rst, output slow);
localparam nb = $clog2(div);
logic [nb-1:0] cnt;

always @(posedge clk, posedge rst)
    if(rst)
        cnt <= {nb{1'b0}};
    else if(cnt == div - 1)
        cnt <= {nb{1'b0}};
    else
        cnt <= cnt + 1'b1;
        
assign slow = (cnt == div -1);
        
endmodule
