`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2024 01:46:48 PM
// Design Name: 
// Module Name: spi_adc
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////

module spi_adc(input clk,input rst,input SPI_EN, input sdi, sdi2,
    output logic [11:0] data1, output logic [11:0] data2,  output sclk, SPI_FIN, CS);
    
    //localparam Idle=2'b00, Read=2'b01, Hold=2'b10, Done=2'b11;
    typedef enum {Idle, Read, Hold, Done} states;
    states state, next_state;
    
    reg [15:0] shift_register;		// Shift register to shift out SPI_DATA saved when SPI_EN was set
    reg [15:0] shift_register2;
	reg [4:0] shift_counter;			// Keeps track how many bits were sent
	wire clk_divided;						// Used as SCLK
	reg [4:0] counter;				// Count clocks to be used to divide CLK
	reg temp_sdi;							// Tied to SDO
    wire sh;
    reg tmp;
    
    logic [15:0] hold_cnt;
    
    assign sclk = clk_divided;
    assign CS = ((state == Idle && SPI_EN== 1'b0) || state == Hold || state == Done) ? 1'b1 : 1'b0;
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
            if(last_bit) begin
                
                //hold_cnt = 16'b0;
                next_state = Hold;
            end
            else
                next_state = Read;
        Hold:
            if(hold_cnt < 16'b1000) begin 
                next_state = Hold;
            end
            else
                next_state = Done;
        Done:
            if(~SPI_EN)
                next_state = Idle;
            else
                next_state = Done;
    endcase
    end
    always @(posedge clk, posedge rst) 
		if(rst) begin
		  data1 <= 12'b0;
		  data2 <= 12'b0;
	   end else if (last_bit & (state == Read)) begin
		  data1 <= shift_register[11:0];
          data2 <= shift_register2[11:0]; 
       end     
		
		    
    always @(posedge clk, posedge rst) 
		if(rst == 1'b1 | state != Hold) 
		  hold_cnt <= 16'b0;
		else if(state == Hold)
		  hold_cnt <= hold_cnt + 1'd1;
		
    assign clk_divided = ~counter[4];
	always @(posedge clk) 
			if(state == Read) 
				counter <= counter + 1'b1;
			else 
				counter <= 5'b0;

    assign sh = tmp & ~clk_divided;
    always @(posedge clk, posedge rst)
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
	
	always@(posedge clk, posedge rst)
	   if(rst) begin
	       shift_register <= 16'b0;
	   end
	   else if(state == Read & sh) begin
	       shift_register <= {shift_register[14:0], sdi};
	   end
	   else if(state == Hold) begin
	       shift_register <= 16'b0;
	   end
	   
	always@(posedge clk, posedge rst)
	   if(rst) begin
	       shift_register2 <= 16'b0;
	   end
	   else if(state == Read & sh) begin
	       shift_register2 <= {shift_register2[14:0], sdi2};
	   end
	   else if(state == Hold) begin
	       shift_register2 <= 16'b0;
	   end
	       
endmodule