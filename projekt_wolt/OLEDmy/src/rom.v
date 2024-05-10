`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2019 09:23:57 AM
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


module rom(input clk, en, input [10:0] addr, output reg [7:0] dataout);

reg [7:0] mem [1023:0];

initial $readmemh("pixel_SSD1306.mem", mem);

always @(posedge clk)
    if(en) dataout <= mem[addr];
    
endmodule
