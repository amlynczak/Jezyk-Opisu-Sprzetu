`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2024 03:31:27 PM
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


module top(input CLK,input RST, output SDIN, SCLK, DC, RES, VBAT, VDD, input sdi, sdi2,
        output sclk, CS);
        
        
logic SPI_EN;
wire [11:0] data1;
wire [11:0] data2;
wire SPI_FIN;
        
spi_adc spi_adc_top (.clk(CLK), .rst(RST), .SPI_EN(SPI_EN), .sdi(sdi), .sdi2(sdi2), .data1(data1), .data2(data2), .sclk(sclk), .SPI_FIN(SPI_FIN), .CS(CS));

oled_top otop (.CLK(CLK), .RST(RST), .data1(data1), .data2(data2), .SDIN(SDIN), .SCLK(SCLK), .DC(DC), .RES(RES), .VBAT(VBAT), .VDD(VDD));

always@(posedge CLK, posedge RST)
if(RST)
    SPI_EN <= 1'b0;
else if(SPI_FIN) begin
    SPI_EN <= 1'b0;
end else if(~SPI_EN)
    SPI_EN <= 1'b1;
 
endmodule
