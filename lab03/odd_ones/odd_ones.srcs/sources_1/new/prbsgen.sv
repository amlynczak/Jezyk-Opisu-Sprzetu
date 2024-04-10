`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2024 12:19:29 PM
// Design Name: 
// Module Name: prbsgen
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


module prbsgen #(parameter n = 8, [n-1:0]seed = 8'b11001100)(input clk, input rst, input en, output prbs);

logic [n-1:0] shr;
localparam [n:0] tmp = 9'b101110001;
wire d = ^{shr & tmp[n:1]};
always @(posedge clk, posedge rst)
    if(rst)
        shr <= seed;
    else if(en)
        shr <= {shr[n-2:0], d};
        
assign prbs = shr[n-1];

endmodule
