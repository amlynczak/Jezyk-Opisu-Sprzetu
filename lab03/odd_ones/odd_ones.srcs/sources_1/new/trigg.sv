`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2024 12:19:29 PM
// Design Name: 
// Module Name: trigg
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


module trigg #(parameter n = 8)(input clk, input rst, input en, output trg);

logic [n-1:0] cnt;
localparam m = 2**n - 1;

always @(posedge clk, posedge rst)
    if(rst)
        cnt <= {n{1'b0}};
    else if(en)
        if(cnt == m-1)
            cnt <= {n{1'b0}};
        else
            cnt <= cnt + 1'b1;
            
assign trg = (cnt == m-1);

endmodule
