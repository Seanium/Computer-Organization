`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:59 10/26/2022 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
    
    wire [5:0] Op, Func;
    wire [2:0] RegDstSel, ALUSrcSel, toRegSel;
    wire RegWrite, MemWrite;
    wire [2:0] NPCOp, EXTOp;
    wire [3:0] ALUOp;
    
control ctrl (
    .Op(Op), 
    .Func(Func), 
    .RegDstSel(RegDstSel), 
    .ALUSrcSel(ALUSrcSel), 
    .toRegSel(toRegSel), 
    .RegWrite(RegWrite), 
    .MemWrite(MemWrite), 
    .NPCOp(NPCOp), 
    .ALUOp(ALUOp), 
    .EXTOp(EXTOp)
    );
    
datapath path (
    .clk(clk),
    .reset(reset),
    .RegDstSel(RegDstSel), 
    .ALUSrcSel(ALUSrcSel), 
    .toRegSel(toRegSel), 
    .RegWrite(RegWrite), 
    .MemWrite(MemWrite), 
    .NPCOp(NPCOp), 
    .ALUOp(ALUOp), 
    .EXTOp(EXTOp), 
    .Op(Op), 
    .Func(Func)
    );

endmodule
