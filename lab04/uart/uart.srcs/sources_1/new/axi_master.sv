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


module axi_master(input clk, input rst, 
    output [3:0] awaddr, output awvld, input awrdy, //AW
    output [31:0] wdata, output wvald, input wrdy,  //W
    input [1:0] bresp, input bvld, output brdy,  //B
    output logic [4:0] araddr, output logic arvld, input arrdy, //AR
    input [31:0] rdata, input rvld, output logic rrdy//RR
    );
    
typedef enum{ReadStatus, WaitStatus, Read, Write} states;
states st, nst;
logic rec_trn = 1'b1;
wire rfifo_valid = ((st == WaitStatus) && rvld) ? rdata[0] : 1'b0;
wire tfifo_full = ((st == WaitStatus) && rvld) ? rdata[3] : 1'b0;

always @(posedge clk, posedge rst)
    if(rst)
        st <= ReadStatus;
    else
        st <= nst;
        
always @* begin
    nst = ReadStatus;
    case(st)
        ReadStatus: nst = WaitStatus;
        WaitStatus: if(rec_trn)
            nst = rfifo_valid ? (rvld ? Read : WaitStatus ) : ReadStatus; 
        else
            nst = tfifo_full ? ReadStatus : (rvld ? Write : WaitStatus );
        Read: nst = ReadStatus;
        Write: nst = ReadStatus;
    endcase;
end;
    
always @(posedge clk, posedge rst)
    if(rst)
        araddr <=4'b0;
    else if(st == ReadStatus)
        araddr <=4'd8;
    else 
        araddr <=4'b0;
        
always @(posedge clk, posedge rst)
    if(rst)
        arvld <= 1'b0;
    else if(st == ReadStatus || st == Read)
        arvld <= 1'b1;
    else if(arrdy)
        arvld <= 1'b0;
        
always @(posedge clk, posedge rst)
    if(rst)
        rrdy <= 1'b0;
    else if(st == WaitStatus && rvld)
        rrdy <= 1'b1;
    else
        rrdy <= 1'b0; 
        
endmodule
