`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer:

//

// Create Date:    15:14:23 04/19/13

// Design Name:    

// Module Name:    pipelinedcpu

// Project Name:   

// Target Device:  

// Tool versions:  

// Description:

//

// Dependencies:

// 

// Revision:

// Revision 0.01 - File Created

// Additional Comments:

// 

////////////////////////////////////////////////////////////////////////////////

module pipelinedcpu(clock,resetn,pc,inst,ealu,malu,walu,DEPEN,A_DEPEN,B_DEPEN,actuall_a,actuall_b,exe_load

    );
	

	 input clock,resetn;
	
     //add output

     output DEPEN;

     //add output

	 //just for test

	 output [31:0] actuall_a,actuall_b;

	 //just for test
	 
	 

	  //add output2

	  wire [1:0] adepen,bdepen;
	  
	  output [1:0] A_DEPEN,B_DEPEN;
	  
	  //add output2

	 output [31:0] pc,inst,ealu,malu,walu;

	 // use to multi select rs1

	 wire [31:0] exe_a,exe_b;

	 // use to multi select rs1

	 wire [31:0] bpc,jpc,npc,pc4,ins,dpc4,inst,da,db,dimm,ea,eb,eimm;

	 wire [31:0] epc4,mb,mmo,wmo,wdi;

	 wire [4:0] drn,ern0,ern,mrn,wrn;

	 wire [4:0] daluc,ealuc;

	 wire [1:0] pcsource;

	 wire dwreg,dm2reg,dwmem,daluimm,dshift,djal;

	 wire ewreg,em2reg,ewmem,ealuimm,eshift,ejal;

	 wire mwreg,mm2reg,mwmem;

	 wire wwreg,wm2reg;

     //add wire

     wire [4:0]rs,rt,rd;

     wire id_rs1isreg,id_rs2isreg,is_store;

     //add wire


	 // load detect

	 output exe_load;

	 // load detect

	 // get not exe_load

	 wire not_exe_load;

	 // get not exe_load
	 wire z;
	 	


     stall st(rs,rt,rd,ern0,mrn,ewreg,mwreg,
     
            id_rs1isreg,id_rs2isreg,is_store,em2reg,DEPEN,A_DEPEN,B_DEPEN,
			
			exe_load);

	 pipepc prog_cnt (npc,not_exe_load,clock,resetn,pc);//PC

	 pipeif if_stage (pcsource,pc,bpc,da,jpc,npc,pc4,ins);//IF

	 pipeir inst_reg (pc4,ins,clock,resetn,dpc4,inst,not_exe_load);//IFIDIR

	 pipeid id_stage (dpc4,inst,                        //ID

	                  wrn,wdi,wwreg,clock,resetn,

							bpc,jpc,pcsource,dwreg,dm2reg,dwmem,

							daluc,daluimm,da,db,dimm,drn,dshift,djal,z,

                            id_rs1isreg,id_rs2isreg,is_store,rs,rt,rd,
									 
									 exe_load
                            );

	 pipedereg de_reg (dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,//IDEXE

	                   drn,dshift,djal,dpc4,clock,resetn,

							 ewreg,em2reg,ewmem,ealuc,ealuimm,ea,eb,eimm,

							 ern0,eshift,ejal,epc4,A_DEPEN,B_DEPEN,adepen,bdepen);
				
	 mux4x32 rs1_select(ea,malu,walu,walu,adepen,exe_a);

	 mux4x32 rs2_select(eb,malu,walu,walu,bdepen,exe_b);

	 pipeexe exe_stage (ealuc,ealuimm,exe_a,exe_b,eimm,eshift,ern0,epc4,//EXE

	                    ejal,ern,ealu,z);

	 pipeemreg em_reg (ewreg,em2reg,ewmem,ealu,eb,ern,clock,resetn,//EXEMEM

	                   mwreg,mm2reg,mwmem,malu,mb,mrn);

	 IP_RAM mem_stage(mwmem,malu,mb,clock,mmo);//MEM

	 pipemwreg mw_reg (mwreg,mm2reg,mmo,malu,mrn,clock,resetn,//MEMWB

	                   wwreg,wm2reg,wmo,walu,wrn);

	 mux2x32 wb_stage (walu,wmo,wm2reg,wdi);//WBALU

	// add
	 assign actuall_a=exe_a;
	 assign actuall_b=exe_b;
	 assign not_exe_load=~exe_load;
	// add

endmodule