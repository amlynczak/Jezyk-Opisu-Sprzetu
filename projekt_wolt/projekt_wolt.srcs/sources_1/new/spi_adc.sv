`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2024 01:46:48 PM
// Design Name: 
// Module Name: spi_adc
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


module spi_adc(input clk,input rst,input SPI_EN, input sdi,
    output logic [16:0] data, sclk, SPI_FIN, CS
    );
    
    localparam Idle=2'b00, Read=2'b01, Hold=2'b10, Done=2'b11;
    
    reg[1:0] state, next_state;
    reg [15:0] shift_register;		// Shift register to shift out SPI_DATA saved when SPI_EN was set
	reg [4:0] shift_counter;			// Keeps track how many bits were sent
	wire clk_divided;						// Used as SCLK
	reg [4:0] counter;				// Count clocks to be used to divide CLK
	reg temp_sdi;							// Tied to SDO
    wire sh;
    reg tmp;
    
    assign sclk = clk_divided;
    assign CS = (state == Idle && SPI_EN== 1'b0) ? 1'b1 : 1'b0;
    assign SPI_FIN = (state == Done) ? 1'b1 : 1'b0;
    
    always @(posedge clk) 
		if(rst == 1'b1) 					// Synchronous RST
			state <= Idle;
		else 
		    state <= next_state;	
		    
    always@* begin
    next_state = Idle;
    case(state)
        Idle:
            if(SPI_EN)
                next_state = Read;
        Read:
            if(last_bit)
                next_state = Done;
            else
                next_state = Read;
        Done:
            if(~SPI_EN)
                next_state = Idle;
            else
                next_state = Done;
    endcase
    end
    
    assign clk_divided = ~counter[4];
	always @(posedge clk) 
			if(state == Read) 
				counter <= counter + 1'b1;
			else 
				counter <= 5'b0;

    assign sh = tmp & ~clk_divided;
    always @(posedge clk)
        if(rst)
            tmp <= 2'b0;
        else
            tmp <= clk_divided;
            
    assign last_bit = (shift_counter == 5'h10);        	
	always @(posedge clk) begin
			if(state == Idle) begin
					shift_counter <= 5'h0;
			end
			else if(state == Read & sh) begin
							shift_counter <= shift_counter + 1'b1;
			end
	end
	
	always@(posedge clk)
	   if(state == Read & sh) begin
	       shift_register <= {shift_register[14:0], 1'b0};
	       shift_register[0] <= sdi;
	   end
endmodule
