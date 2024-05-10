`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2024 01:28:57 PM
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
localparam hp = 5, fclk = 100_000_000, brate = 230400, size = 8;
localparam nr_rec = 11;
localparam nr_trn = 9;
localparam ratio = fclk/brate - 1;
logic clk, rst, strr, strt;

top uut(.clk(clk), .rst(rst), .tx(tx), .rx(rx));

simple_receiver #(.fclk(fclk), .baudrate(brate), .nb(size), .deep(nr_rec)) odbiornik
    (.clk(clk), .rst(rst), .str(strr), .rx(tx), .fin(finr));
    
simple_transmitter #(.nb(size), .deep(nr_trn), .ratio(ratio)) nadajnik
    (.clk(clk), .rst(rst), .str(strt), .trn(rx), .fin(fint));

initial begin
    clk = 1'b0;
    forever #hp clk = ~clk;
end;

initial begin
    rst = 1'b0;
    #1 rst = 1'b1;
    repeat(5) @(posedge clk);
    #3 rst = 1'b0;
end;

initial begin
    strr = 1'b0;
    strt = 1'b0;
    @(negedge rst);
    repeat(ratio/8) @(posedge clk);
    strt = 1'b1;
    @(negedge clk);
    strt = 1'b0;
    repeat(nr_trn) @(negedge fint);
end;

initial begin
    //wait(uut.master.st == uut.master.Read);
    wait(uut.addr == 6);
    #2000 $finish();
end;

endmodule
