`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:12 10/27/2022 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
    input clk,
    input reset,
    input [2:0] RegDstSel,
    input [2:0] ALUSrcSel,
    input [2:0] toRegSel,
    input RegWrite,
    input MemWrite,
    input [2:0] NPCOp,
    input [3:0] ALUOp,
    input [2:0] EXTOp,
    input [2:0] DMType,     //new
    output [5:0] Op,
    output [5:0] Func
    );
    
//PC
    wire [31:0] PC;
//NPC
    wire [31:0] NPC, PC4;
//IM
    wire [31:0] IM;
    wire [4:0] Rs, Rt, Rd, Shamt;
    wire [15:0] Imm;
    wire [25:0] Imm26;
    assign Op = IM[31:26];
    assign Func = IM[5:0];
    assign Rs = IM[25:21];
    assign Rt = IM[20:16];
    assign Rd = IM[15:11];
    assign Imm = IM[15:0];
    assign Shamt = IM[10:6];
    assign Imm26 = IM[25:0];
//RegDstmux
    wire [4:0] thirtyOne;
    assign thirtyOne = 5'd31;
    wire [4:0] RegDst;
//GRF
    wire [31:0] GRFRD1, GRFRD2;
//EXT
    wire [31:0] EXTO;
//ALUSrcmux
    wire [31:0] ALUSrc;
//ALU
    wire [31:0] ALUResult;
    wire ALUZero;
//DM
    wire [31:0] DMRD;
//toRegMux
    wire [31:0] toReg;
    
PC pc (
    .clk(clk), 
    .reset(reset), 
    .NPC(NPC), 
    .PC(PC)                 //output
    );

NPC npc (
    .PC(PC), 
    .Imm26(Imm26), 
    .RA(GRFRD1), 
    .Zero(ALUZero), 
    .NPCOp(NPCOp), 
    .NPC(NPC),              //output
    .PC4(PC4)               //output
    );

IM im (
    .A(PC), 
    .RD(IM)                 //output
    );

RegDstmux regdstmux (
    .RegDstSel(RegDstSel), 
    .input0(Rt), 
    .input1(Rd), 
    .input2(thirtyOne), 
    .RegDst(RegDst)         //output
    );

GRF grf (
    .clk(clk), 
    .reset(reset), 
    .A1(Rs), 
    .A2(Rt), 
    .A3(RegDst), 
    .WD(toReg), 
    .WE(RegWrite), 
    .pc(PC), 
    .RD1(GRFRD1),           //output
    .RD2(GRFRD2)            //output
    );

EXT ext (
    .I(Imm), 
    .EXTOp(EXTOp), 
    .O(EXTO)                //output
    );
    
ALUSrcmux alusrcmux (
    .ALUSrcSel(ALUSrcSel), 
    .input0(GRFRD2), 
    .input1(EXTO), 
    .ALUSrc(ALUSrc)         //output
    );

ALU alu (
    .A(GRFRD1), 
    .B(ALUSrc), 
    .ALUOp(ALUOp), 
    .Result(ALUResult),     //output
    .Zero(ALUZero)          //output
    );
    
DM dm (
    .clk(clk), 
    .reset(reset), 
    .A(ALUResult), 
    .WE(MemWrite), 
    .WD(GRFRD2), 
    .pc(PC), 
    .DMType(DMType),    //new
    .RD(DMRD)               //output
    );

toRegmux toregmux (
    .toRegSel(toRegSel), 
    .input0(ALUResult), 
    .input1(DMRD), 
    .input2(EXTO), 
    .input3(PC4), 
    .toReg(toReg)           //output
    );

endmodule
