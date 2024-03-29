`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:13:23 10/29/2012
// Design Name:   pipelinedcpu
// Module Name:   D:/ORG_FPGA2012/PipelinedCpu/pipelinedcpu_tb.v
// Project Name:  PipelinedCpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipelinedcpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pipelinedcpu_tb;

	// Inputs
	reg clock;
	reg resetn;

	// Outputs 
	wire [31:0] pc;
	wire [31:0] inst;
	wire [31:0] ealu;
	wire [31:0] malu;
	wire [31:0] walu;
	wire DEPEN;
	wire [1:0] A_DEPEN;
	wire [1:0] B_DEPEN;
	wire exe_load;
	wire BTAKEN;
	wire NEXT_B_TAKEN;
	wire [1:0] pcsource;

	// Instantiate the Unit Under Test (UUT)
	pipelinedcpu uut (
		.clock(clock),  
		.resetn(resetn), 
		.pc(pc), 
		.inst(inst), 
		.ealu(ealu), 
		.malu(malu), 
		.walu(walu),
		.DEPEN(DEPEN),
		.A_DEPEN(A_DEPEN),
		.B_DEPEN(B_DEPEN),
		.exe_load(exe_load),
		.BTAKEN(BTAKEN),
		.NEXT_B_TAKEN(NEXT_B_TAKEN),
		.pcsource(pcsource)
	);

	initial begin
		// Initialize Inputs
		clock = 1;
		resetn = 0;

		// Wait 100 ns for global reset to finish
		#100;
		resetn = 1;
        
		// Add stimulus here

	end
	always #50 clock=~clock;
      
endmodule

