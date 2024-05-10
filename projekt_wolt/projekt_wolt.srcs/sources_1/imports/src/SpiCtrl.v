`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineers: Ryan Kim
//				  Josh Sackos
// 
// Create Date:    16:29:53 06/12/2012 
// Module Name:    SpiCtrl 
// Project Name: 	 PmodOLEDCtrl
// Tool versions:  ISE 14.1
// Target Devices: Nexys3
// Description: Spi block that sends SPI data formatted SCLK active low with
//					 SDO changing on the falling edge
//
// Revision: 1.0 - SPI completed
// Revision 0.01 - File Created 
//
//////////////////////////////////////////////////////////////////////////////////
module SpiCtrl(input CLK, RST, SPI_EN, input [7:0] SPI_DATA, 
    output SDO, SCLK, SPI_FIN); //CS, 
    
    localparam Idle=2'b00, Send=2'b01, Hold1=2'b10, Done=2'b11;	
    
	reg [1:0] current_state, next;		// Signal for state machine	
	reg [7:0] shift_register;		// Shift register to shift out SPI_DATA saved when SPI_EN was set
	reg [3:0] shift_counter;			// Keeps track how many bits were sent
	wire clk_divided;						// Used as SCLK
	reg [4:0] counter;				// Count clocks to be used to divide CLK
	reg temp_sdo;							// Tied to SDO
    wire sh;
    reg tmp;
	// ===========================================================================
	// 										Implementation
	// ===========================================================================

	assign SCLK = clk_divided;

	
	//assign CS = (current_state == Idle && SPI_EN == 1'b0) ? 1'b1 : 1'b0;
	assign SPI_FIN = (current_state == Done) ? 1'b1 : 1'b0;

	//  State Machine
	always @(posedge CLK) 
		if(RST == 1'b1) 					// Synchronous RST
			current_state <= Idle;
		else 
		    current_state <= next;	
	always @* begin
	next = Idle;
				case(current_state)
					Idle : 
						if(SPI_EN) 
							next = Send;
					Send : 
						if(last_bit)
							next = Hold1;
						else
						    next = Send;
					Hold1 : 
						next = Done;
					Done : 
						if(~SPI_EN) 
							next = Idle;
						else 
						    next = Done;
				endcase
    end
	
	assign clk_divided = ~counter[4];
	always @(posedge CLK) 
			if(current_state == Send) 
				counter <= counter + 1'b1;
			else 
				counter <= 5'b0;

    assign sh = tmp & ~clk_divided;
    always @(posedge CLK)
        if(RST)
            tmp <= 2'b0;
        else
            tmp <= clk_divided;
            
    assign last_bit = (shift_counter == 4'h8);        	
	always @(posedge CLK) begin
			if(current_state == Idle) begin
					shift_counter <= 4'h0;
			end
			else if(current_state == Send & sh) begin
							shift_counter <= shift_counter + 1'b1;
			end
	end
	
	assign SDO = temp_sdo;
	always @(posedge CLK) 
			if(current_state == Idle & SPI_EN) begin
					shift_register <= SPI_DATA;
					temp_sdo <= 1'b1;
			end
			else if(current_state == Send & sh) begin
							temp_sdo <= shift_register[7];
							shift_register <= {shift_register[6:0],1'b0};
					end
					
endmodule
