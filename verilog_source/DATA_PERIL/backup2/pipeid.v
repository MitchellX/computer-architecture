`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    17:26:59 10/25/2012 

// Design Name: 

// Module Name:    pipeid 

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

module pipeid(dpc4,inst,wrn,

              wdi,wwreg,clk,clrn,bpc,jpc,pcsource,

				  wreg,m2reg,wmem,aluc,aluimm,a,b,imm,rn,

				  shift,jal,rsrtequ,id_rs1_isreg,id_rs2_isreg,isstore,rs,
				  
				  rt,rd, exe_load

    );

	 input [31:0] dpc4,inst,wdi;

	 input [4:0] wrn;

	 input wwreg;

	 input clk,clrn;

	 input rsrtequ;

	 //load 

	 input exe_load;

	//  load
	 
	 //add 

	 output id_rs1_isreg,id_rs2_isreg,isstore;

	 output [4:0]rs,rt,rd;

	 //add 

	 output [31:0] bpc,jpc,a,b,imm;

	 output [4:0] rn;

	 output [4:0] aluc;

	 output [1:0] pcsource;

	 output wreg,m2reg,wmem,aluimm,shift,jal;

	 wire [5:0] op,func;

	 wire [4:0] rs,rt,rd;

	 wire [31:0] qa,qb,br_offset;

	 wire [15:0] ext16;

	 wire regrt,sext,e;

	 assign func=inst[25:20];  

	 assign op=inst[31:26];

	 assign rs=inst[9:5];

	 assign rt=inst[4:0];

	 assign rd=inst[14:10];

	 assign jpc={dpc4[31:28],inst[25:0],2'b00};//jump,jal

	
	 // 3

	 pipeidcu cu(rsrtequ,func,                          //

	             op,wreg,m2reg,wmem,aluc,regrt,aluimm,

					 sext,pcsource,shift,jal,id_rs1_isreg,id_rs2_isreg,
					 
					 isstore,exe_load);

    regfile rf (rs,rt,wdi,wrn,wwreg,~clk,clrn,qa,qb);//323200

	 mux2x5 des_reg_no (rd,rt,regrt,rn); //rd,rt

	 assign a=qa;

	 assign b=qb;

	 assign e=sext&inst[25];//0

	 assign ext16={16{e}};//

	 assign imm={ext16,inst[25:10]};//

	 assign br_offset={imm[29:0],2'b00};

	 cla32 br_addr (dpc4,br_offset,1'b0,bpc);//beq,bne

	

endmodule

