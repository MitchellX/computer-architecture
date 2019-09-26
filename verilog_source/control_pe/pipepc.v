`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    15:46:40 10/25/2012 

// Design Name: 

// Module Name:    pipepc 

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

module pipepc(npc,we,clk,clrn,pc

    );

	 input [31:0] npc;

     //add we

     input we;

     //add we

	 input clk,clrn;

	 output [31:0] pc; 
	 dff32_we program_counter(npc,we,clk,clrn,pc);   

    

endmodule

