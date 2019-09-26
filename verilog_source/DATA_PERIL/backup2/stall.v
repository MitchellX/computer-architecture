`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:37 05/27/2018 
// Design Name: 
// Module Name:    stall 
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
module stall(  ID_rs1,ID_rs2,ID_rd,EXE_rd,MEM_rd,EXE_WREG,MEM_WREG,
               ID_rs1isReg,ID_rs2isReg,isStore,EXE_SLD,DEPEN,A_DEPEN,B_DEPEN,
               LOAD_DEPEN
    );
    input EXE_SLD;
    input [4:0] ID_rs1,ID_rs2,ID_rd;
    input [4:0] EXE_rd,MEM_rd;
    input EXE_WREG,MEM_WREG;
    input ID_rs1isReg;
    input isStore;
    input ID_rs2isReg;
    output DEPEN;
    output [1:0] A_DEPEN,B_DEPEN;
    output LOAD_DEPEN;
    // load
    wire EXE_A_LOAD_DEPEN,EXE_B_LOAD_DEPEN;
    // load
    wire EXE_A_DEPEN;
    wire EXE_B_DEPEN;
    wire MEM_A_DEPEN;
    wire MEM_B_DEPEN;
    assign EXE_A_DEPEN=(ID_rs1==EXE_rd)&(EXE_WREG)&(ID_rs1isReg);
    assign MEM_A_DEPEN=(ID_rs1==MEM_rd)&(MEM_WREG)&(ID_rs1isReg);
    assign EXE_B_DEPEN=(ID_rs2==EXE_rd)&(EXE_WREG)&(ID_rs2isReg)|
           (ID_rd==EXE_rd)&(EXE_WREG)&(isStore);
    assign MEM_B_DEPEN=(ID_rs2==MEM_rd)&(MEM_WREG)&(ID_rs2isReg)|
           (ID_rd==MEM_rd)&(MEM_WREG)&(isStore);
    // forwarding
    assign A_DEPEN[0]=EXE_A_DEPEN;
    assign A_DEPEN[1]=MEM_A_DEPEN;
    assign B_DEPEN[0]=EXE_B_DEPEN;
    assign B_DEPEN[1]=MEM_B_DEPEN;

    // load
    assign EXE_A_LOAD_DEPEN=(ID_rs1==EXE_rd)&(EXE_SLD)&(ID_rs1isReg);
    assign EXE_B_LOAD_DEPEN=(ID_rs2==EXE_rd)&(EXE_SLD)&(ID_rs2isReg);
    assign LOAD_DEPEN=EXE_A_LOAD_DEPEN | EXE_B_LOAD_DEPEN;
    assign DEPEN=MEM_A_DEPEN+MEM_B_DEPEN+EXE_A_DEPEN+EXE_B_DEPEN;
endmodule
