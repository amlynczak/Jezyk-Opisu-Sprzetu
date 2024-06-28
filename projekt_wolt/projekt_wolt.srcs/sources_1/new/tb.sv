`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2024 10:51:35 PM
// Design Name: 
// Module Name: tb
//////////////////////////////////////////////////////////////////////////////////

module tb();

localparam num = 3;
logic [11:0] mem_in [num] = '{12'h309, 12'h10a, 12'h2ac};
logic [11:0] value; // = 12'h309;
wire [15:0] data_in = {3'b0, value};
logic [11:0] data_out;
logic clk, rst, en, miso;
int i = 16;
int k = 0;

//master SPI for ADC
spi_adc uut (.clk(clk), .rst(rst), .SPI_EN(en), .sdi(miso),
    .data(data_out), .sclk(sclk), .SPI_FIN(fin), .CS(cs));

initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1'b0;
    #2 rst = 1'b1;
    #2 rst = 1'b0;
end

always @(negedge cs, negedge sclk)
    miso = data_in[i--];
    
//initial #5200 $finish();

initial begin
    forever begin
    value = mem_in[k++];
    en = 1'b0;
    repeat(20) @(posedge clk);
    en = 1'b1;
    @(posedge clk) en = 1'b0;
    @(negedge fin);
    i = 16;
    repeat(20) @(posedge clk);
    end
end

initial begin
    repeat(20) @(posedge clk);
    repeat(num) @(negedge fin);
    repeat(200) @(posedge clk);
    $finish();
end

endmodule