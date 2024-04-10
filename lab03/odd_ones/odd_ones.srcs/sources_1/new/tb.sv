`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 02:22:08 PM
// Design Name: 
// Module Name: tb
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


module tb();
logic clk, rst, X, Z;

odd main2(.clk(clk), .rst(rst), .X(X), .Z(Z));
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end 
initial begin
    rst = 1'b1;
    #1 rst = 1'b0;
    #2 rst = 1'b1;
end

always @(posedge clk)
    X = {$random %2};
    
initial #2000 $finish();
endmodule
