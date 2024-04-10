`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2024 12:19:29 PM
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


module clkdiv #(parameter div=1000)(input clk, input rst, output slow, output enable);

localparam n = $clog2(div);
logic[n-1:0] cnt;

always @(posedge clk, posedge rst)
    if(rst)
        cnt <= {n{1'b0}};
    else if(cnt == div-1)
        cnt <= {n{1'b0}};
    else
        cnt <= cnt+1;
        
assign slow = (cnt < div>>1);
assign enable = (cnt== div-1);
endmodule
