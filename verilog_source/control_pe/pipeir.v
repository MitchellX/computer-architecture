`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    17:22:14 10/25/2012 

// Design Name: 

// Module Name:    pipeir 

// Project Name: 

// Target Devices: 

// Tool versions: 

// Description: 

//

// Dependencies: 

//

// Revision: 

// Revision 0.01 - File Created

// Additional Comments: 

//

//////////////////////////////////////////////////////////////////////////////////

module pipeir(pc4,ins,clk,clrn,dpc4,inst,we

    );

     //add we

     input we;

     //add we
	 input [31:0] pc4,ins;

	 input clk,clrn;

	 output [31:0] dpc4,inst;

     dff32_we pc_plus4 (pc4,we,clk,clrn,dpc4);

	 dff32_we instruction (ins,we,clk,clrn,inst);

endmodule

