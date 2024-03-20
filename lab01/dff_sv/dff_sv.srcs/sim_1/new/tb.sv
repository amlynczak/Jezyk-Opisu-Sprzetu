`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 11:58:04 AM
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

logic clk, rst, d;

dff uut(.clk(clk), .rst(rst), .d(d), .q(qout));

initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1'b0;
    #1 rst = 1'b1;
    #3 rst = 1'b0;
end

initial begin
    d = 1'b0;
    @(negedge rst);
    #1 d = ~d;
    @(negedge clk);
    #3 d = ~d;
    @(negedge clk);
    #1 d = ~d;
    repeat(2) @(negedge clk);
    #6 d  = ~d;
    repeat(3) @(negedge clk);
    #4 d  = ~d;
end

initial begin
    repeat(10) @(posedge clk);
    $finish();
end

endmodule
