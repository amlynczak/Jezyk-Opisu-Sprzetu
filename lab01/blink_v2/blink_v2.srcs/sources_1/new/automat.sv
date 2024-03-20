`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 01:28:23 PM
// Design Name: 
// Module Name: automat
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


module automat(input clk, input rst, input start, input status, input en, output for_serial_in);

typedef enum {idle, pulse} states;
states st, nst;

always @(posedge clk, posedge rst)
    if(rst)
        st <= idle;
    else if(en)
        st <= nst;

always @* begin
    nst = idle;
    case(st)
        idle: nst = (start & status) ? pulse : idle;
        pulse: nst = idle;
    endcase
end

assign for_serial_in = (st==pulse);

endmodule
