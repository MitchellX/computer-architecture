

// Dependencies: 

//

// Revision: 

// Revision 0.01 - File Created

// Additional Comments: 

//

//////////////////////////////////////////////////////////////////////////////////

module pipeidcu(rsrtequ,func,

	             op,wreg,m2reg,wmem,aluc,regrt,aluimm,

					 sext,pcsource,shift,jal,ID_rs1isReg,
                     
                     ID_rs2isReg,isStore,exe_load,BTAKEN

    );

     //new add

	 input BTAKEN;

	 //new add

	 input rsrtequ; 

	 input [5:0] func,op;

	 //load detect

	 input exe_load;

	 //load detect

     //add

     output ID_rs1isReg,ID_rs2isReg,isStore;

     //add

	 output wreg,m2reg,wmem,regrt,aluimm,sext,shift,jal;

	 output [4:0] aluc;

	 output [1:0] pcsource;

	 wire i_add,i_sub,i_mul,i_and,i_or,i_xor,i_sll,i_srl,i_sra,i_jr;            //

	 wire i_addi,i_muli,i_andi,i_ori,i_xori,i_lw,i_sw,i_beq,i_bne,i_lui,i_j,i_jal;

	 

	 and(i_add,~op[5],~op[4],~op[3],~op[2],~op[1],~op[0],~func[2],~func[1],func[0]);

	 and(i_sub,~op[5],~op[4],~op[3],~op[2],~op[1],~op[0],~func[2],func[1],~func[0]);

	 and(i_mul,~op[5],~op[4],~op[3],~op[2],~op[1],~op[0],~func[2],func[1],func[0]);

	

	 

	 and(i_and,~op[5],~op[4],~op[3],~op[2],~op[1],op[0],~func[2],~func[1],func[0]);

	 and(i_or,~op[5],~op[4],~op[3],~op[2],~op[1],op[0],~func[2],func[1],~func[0]);

	

	 and(i_xor,~op[5],~op[4],~op[3],~op[2],~op[1],op[0],func[2],~func[1],~func[0]);

	 

	 and(i_sra,~op[5],~op[4],~op[3],~op[2],op[1],~op[0],~func[2],~func[1],func[0]);

	 and(i_srl,~op[5],~op[4],~op[3],~op[2],op[1],~op[0],~func[2],func[1],~func[0]);

	 and(i_sll,~op[5],~op[4],~op[3],~op[2],op[1],~op[0],~func[2],func[1],func[0]);

	 and(i_jr,~op[5],~op[4],~op[3],~op[2],op[1],~op[0],func[2],~func[1],~func[0]);

	 

	 and(i_addi,~op[5],~op[4],~op[3],op[2],~op[1],op[0]);

	

	 and(i_muli,~op[5],~op[4],~op[3],op[2],op[1],op[0]);

	 

	 

	 and(i_andi,~op[5],~op[4],op[3],~op[2],~op[1],op[0]);

	 and(i_ori,~op[5],~op[4],op[3],~op[2],op[1],~op[0]);



	 and(i_xori,~op[5],~op[4],op[3],op[2],~op[1],~op[0]);

	 

	 and(i_lw,~op[5],~op[4],op[3],op[2],~op[1],op[0]);

	 and(i_sw,~op[5],~op[4],op[3],op[2],op[1],~op[0]);

	 and(i_beq,~op[5],~op[4],op[3],op[2],op[1],op[0]);

	 and(i_bne,~op[5],op[4],~op[3],~op[2],~op[1],~op[0]);

	 and(i_lui,~op[5],op[4],~op[3],~op[2],~op[1],op[0]);

	 and(i_j,~op[5],op[4],~op[3],~op[2],op[1],~op[0]);

	 and(i_jal,~op[5],op[4],~op[3],~op[2],op[1],op[0]);

	

	 wire i_rs=i_add|i_sub|i_mul|i_and|i_or|i_xor|i_jr|i_addi|i_muli|           

	           i_andi|i_ori|i_xori|i_lw|i_sw|i_beq|i_bne;

	 wire i_rt=i_add|i_sub|i_mul|i_and|i_or|i_xor|i_sra|i_srl|i_sll|i_sw|i_beq|i_bne;

	 

    /////////////////////////////////////////////////////////////////////////////////////////////////////

    assign wreg=(i_add|i_sub|i_mul|i_and|i_or|i_xor|i_sll|           //wreg1

	              i_srl|i_sra|i_addi|i_muli|i_andi|i_ori|i_xori|

					  i_lw|i_lui|i_jal) & (~exe_load) & (~BTAKEN);

	 assign regrt=i_addi|i_muli|i_andi|i_ori|i_xori|i_lw|i_lui;    //regrt1rtrd

	 assign jal=i_jal;                                           //1jal

	 assign m2reg=i_lw & (~exe_load) & (~BTAKEN);  //1ALU

	 assign shift=i_sll|i_srl|i_sra;//1ALUa

	 assign aluimm=i_addi|i_muli|i_andi|i_ori|i_xori|i_lw|i_lui|i_sw;//1ALUb

	 assign sext=i_addi|i_muli|i_lw|i_sw|i_beq|i_bne;//1

	 assign aluc[4]=i_sra;//ALU
	 assign aluc[3]=i_sub|i_or|i_ori|i_xor|i_xori| i_srl|i_sra|i_beq|i_bne;//ALU
	 assign aluc[2]=i_sll|i_srl|i_sra|i_lui;//ALU
	 assign aluc[1]=i_and|i_andi|i_or|i_ori|i_xor|i_xori|i_beq|i_bne;//ALU
	 assign aluc[0]=i_mul|i_muli|i_xor|i_xori|i_sll|i_srl|i_sra|i_beq|i_bne;//ALU



	 assign wmem=i_sw & (~exe_load) & (~BTAKEN);//1

	 assign pcsource[1]=i_jr|i_j|i_jal;//00PC+4,011011

	 assign pcsource[0]=i_beq&rsrtequ|i_bne&~rsrtequ|i_j|i_jal;
	 
	 //pcsource 0->normal pcsource->1 bne beq pcsource->3 jump

     //change
     
     assign ID_rs1isReg= i_and | i_andi | i_or | i_ori | i_add | i_addi | i_sub | i_lw | i_sw;

     assign ID_rs2isReg= i_and | i_or | i_add | i_sub;

     assign isStore = i_sw;

    //  change

	

endmodule

