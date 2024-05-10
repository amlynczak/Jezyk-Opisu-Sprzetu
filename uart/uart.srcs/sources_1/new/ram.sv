`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2024 02:25:34 PM
// Design Name: 
// Module Name: ram
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


module ram #(parameter depth = 20, nba = $clog2(depth)) (input clk, input [7:0] data_in, output logic [7:0] data_out,
    input [nba-1:0] mem_addr, input rd, input wr
    );
    
logic [7:0] mem [1:depth];

initial $readmemh("tr_init.mem", mem);

always @(posedge clk)
    if(wr)
        mem[mem_addr] <= data_in;
    else if(rd)
        data_out <= mem[mem_addr];
        
endmodule
