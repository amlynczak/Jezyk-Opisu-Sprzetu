//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 02:10:59 PM
// Design Name: 
// Module Name: top
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

module top #(parameter div = 1000)(input clk, input rst, output slow, random, outfsm, trg);

localparam n = 8;

clkdiv #(.div(div)) en_gen (.clk(clk), .rst(rst), .slow(slow), .enable(en));
odd fsm(.clk(clk), .rst(rst), .en(en), .X(random), .Z(outfsm));
prbsgen #(.n(n)) rand_gen(.clk(clk), .rst(rst), .en(en), .prbs(random));
trigg #(.n(n))(.clk(clk), .rst(rst), .en(en), .trg(trg));

endmodule
