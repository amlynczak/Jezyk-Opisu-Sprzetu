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


module axi_master #(parameter nbadr = 3)(input clk, input rst, 
    output logic [3:0] awaddr, output logic awvld, input awrdy, //AW
    output logic [31:0] wdata, output logic wvald, input wrdy,  //W
    input [1:0] bresp, input bvld, output logic brdy,  //B
    output logic [3:0] araddr, output logic arvld, input arrdy, //AR
    input [31:0] rdata, input rvld, output logic rrdy, //RR
    output logic wr, rd, output logic [7:0] data_in, input [7:0] data_out, output logic [nbadr-1:0] addr
    );
    
typedef enum{ReadStatus, WaitStatus, Read, WaitRead, Command, Write, WaitWrite, WaitResp} states;
states st, nst;
logic rec_trn;
logic cmdm;
logic [5:0] maxd;
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
        Read: nst = WaitRead;
        WaitRead: nst = rvld ? (rdata[7] ? Command : ReadStatus) : WaitRead;
        Command: nst = ReadStatus;
        Write: nst = WaitWrite;
        WaitWrite: nst = awrdy ? WaitResp : WaitWrite;
        WaitResp: nst = bvld ? ReadStatus : WaitResp;
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
    else if((st == WaitStatus || st == WaitRead) && rvld)
        rrdy <= 1'b1;
    else
        rrdy <= 1'b0; 
        
        
always@(posedge clk, posedge rst)
    if(rst) begin
        rec_trn <= 1'b1;
        cmdm <= 1'b1;
        maxd <= 6'b0;
    end
    else if(st == Command) begin
        maxd <= rdata[5:0];
        case(rdata[7:6])
            2'b10: cmdm <= (rdata[5:0] == 6'b0) ? 1'b1 : 1'b0;
            2'b11: rec_trn <= 1'b0;
        endcase;
    end
    else if(st == WaitResp && addr == maxd) begin
        rec_trn <= 1'b1;
        cmdm <= 1'b1;
    end

wire incar = (st == WaitRead) & rec_trn & ~cmdm & rvld & (addr < maxd);
wire incat = (st == Write) & ~rec_trn & cmdm & (addr<maxd);

always@(posedge clk, posedge rst)
    if(rst)
        data_in <= 8'b0;
    else if(incar)
        data_in <= rdata[7:0];
        
always@(posedge clk, posedge rst)
    if(rst)
        wr <= 1'b0;
    else
        wr <= incar;
        
        
//generator adresu     
always@(posedge clk, posedge rst)
    if(rst)
        addr <= {nbadr{1'b0}};
    else if(incar | incat)
        addr <= addr + 1'b1;
    else if((st == WaitResp && addr == maxd) || st == Command)
        addr <= {nbadr{1'b0}};
    
always@(posedge clk, posedge rst)
    if(rst)
        rd <= 1'b0;
    else
        rd <= (st == Write);
    
//AW
always @(posedge clk, posedge rst)
    if(rst)
        awaddr <=4'b0;
    else if(st == Write || st == WaitWrite)
        awaddr <=4'd8;
    else 
        awaddr <=4'b0;
        
always @(posedge clk, posedge rst)
    if(rst)
        awvld <= 1'b0;
    else if(st == Write)
        awvld <= 1'b1;
    else if(awrdy)
        awvld <= 1'b0;
        
//W
always @(posedge clk, posedge rst)
    if(rst)
        wvald <= 1'b0;
    else if(st == Write)
        wvald <= 1'b1;
    else if(wrdy)
        wvald <= 1'b0;
        
assign wdata = (st == WaitWrite) ? {24'b0, data_out} : 32'b0;

//B
always@(posedge clk, posedge rst)
    if(rst)
        brdy <= 1'b0;
    else begin
        if(st==Write)
            brdy <= 1'b1;
        if(bvld)
            brdy <= 1'b0;
    end

endmodule
