`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineers: Ryan Kim
//				  Josh Sackos
// 
// Create Date:    14:00:51 06/12/2012
// Module Name:    PmodOLEDCtrl 
// Project Name: 	 PmodOLED Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: 	 Top level controller that controls the PmodOLED blocks
//
// Revision: 1.1
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////
module oled_top #(parameter modn=100_000, dvbat=100) (input CLK, RST, [11:0] data1, [11:0] data2,
		output SDIN, SCLK, DC, RES, VBAT, VDD);       //CS, 

localparam Idle=2'b00, OledInitialize=2'b01, OledExample=2'b10, Done=2'b11;
	reg [1:0] current_state, next_state;

	wire init_en;
	wire init_done;
	wire init_cs;
	wire init_sdo;
	wire init_sclk;
	wire init_dc;
	
	wire example_en;
	wire example_cs;
	wire example_sdo;
	wire example_sclk;
	wire example_dc;
	wire example_done;
	// ===========================================================================
	// 										Implementation
	// ===========================================================================
	OledInit #(.modn(modn), .delvbat(dvbat)) Init (
			.clk(CLK),
			.rst(RST),
			.en(init_en),
			//.CS(init_cs),
			.sdo(init_sdo),
			.sclk(init_sclk),
			.dc(init_dc),
			.res(RES),
			.vbat(VBAT),
			.vdd(VDD),
			.fin(init_done)
	);

	fsm_oper Operation (
			.clk(CLK),
			.rst(RST),
			.en(example_en),
			.data1(data1),
			.data2(data2),
			//.CS(example_cs),
			.sdo(example_sdo),
			.sclk(example_sclk),
			.dc(example_dc),
			.fin(example_done)
	);


	//MUXes to indicate which outputs are routed out depending on which block is enabled
	//assign CS = (current_state == OledInitialize) ? init_cs : example_cs;
	assign SDIN = (current_state == OledInitialize) ? init_sdo : example_sdo;
	assign SCLK = (current_state == OledInitialize) ? init_sclk : example_sclk;
	assign DC = (current_state == OledInitialize) ? init_dc : example_dc;
	//END output MUXes

	
	//MUXes that enable blocks when in the proper states
	assign init_en = (current_state == OledInitialize) ? 1'b1 : 1'b0;
	assign example_en = (current_state == OledExample) ? 1'b1 : 1'b0;
	//END enable MUXes

	
	//  State Machine
	always @(posedge CLK) 
		if(RST) 
			current_state <= Idle;
		else 
			current_state <= next_state;
			
    always @* begin
    next_state = Idle;
					case(current_state)
						Idle : begin
							next_state = OledInitialize;
						end
  					   // Go through the initialization sequence
						OledInitialize : 
								if(init_done)
									next_state = OledExample;
								else
								    next_state = OledInitialize;
						// Do example and Do nothing when finished
						OledExample : 
								if(example_done) 
									next_state = Done;
								else
								    next_state = OledExample;
						// Do Nothing
						Done : begin
							next_state = Done;
						end
						
						default : next_state = Idle;
					endcase
	end

endmodule
