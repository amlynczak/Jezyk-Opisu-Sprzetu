`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 02:06:09 PM
// Design Name: 
// Module Name: rom
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


module rom #(parameter depth = 10)(input clk, input [$clog2(depth)-1:0] addr, output logic [7:0] data);

logic [7:0] mem [1:depth];
initial $readmemh("sequence.mem", mem);

always @(posedge clk)
    data <= mem[addr];
endmodule
