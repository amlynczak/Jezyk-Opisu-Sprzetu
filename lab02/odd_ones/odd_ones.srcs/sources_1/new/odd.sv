`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 01:52:04 PM
// Design Name: 
// Module Name: odd
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



module odd(input clk, input rst, input X, output logic Z);
typedef enum{S0, S1, S2, S3, S4, S5} states;
states state, next_state;
//logic syg = X;
//logic syg_red;

always_comb
case(state)
    S0: next_state = X?S1:S4;
    S1: next_state = X?S0:S2;
    S2: next_state = X?S0:S3;
    S3: next_state = X?S5:S3;
    S4: next_state = X?S1:S5;
    S5: next_state = X?S3:S5;
endcase

always @(posedge clk, negedge rst)
    if(~rst)
        state <= S0;
    else
        state <= next_state;

always_comb
case(state)
    S0: Z = 0;
    S1: Z = 0;
    S2: Z = 0;
    S3: Z = 1;
    S4: Z = 0;
    S5: Z = 0;
endcase

/*
logic [1:0] sht;
assign syg_red = sht[0] & ~sht[1];
always @(posedge clk, posedge rst)
    if(rst)
        sht <= 2'b0;
    else
        sht <= {sht[0], syg};
*/      

endmodule
