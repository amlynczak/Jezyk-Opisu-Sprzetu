`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2024 02:32:28 PM
// Design Name: 
// Module Name: axi_master
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


module axi_master(
    input clk,
    input rst,
    output [3:0] awaddr,
    output awvld,
    input awrdy,
    output [31:0] wdata,
    output wvald,
    input wrdy,
    input [1:0] bresp,
    input bvld,
    output brdy,
    output [4:0] araddr,
    output arvld,
    input arrdy,
    input [31:0] rdata,
    input rvld,
    output rrdy,
    input [1:0] rresp
    );
endmodule
