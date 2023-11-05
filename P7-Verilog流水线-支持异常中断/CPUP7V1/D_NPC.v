`timescale 1ns / 1ps

module D_NPC(
    input [4:0] NPCOp,
    input [31:0] F_pc,
    input [31:0] D_pc,
    input [25:0] imm26,
    input [31:0] RD1,
    input [31:0] RD2,
    input req,
    input eret,
    input [31:0] EPC,
    output [31:0] npc
    );
    
    assign npc =
        req?
            32'h0000_4180:
        eret?
            EPC + 4:
        (NPCOp==5'd0)? 
            (F_pc+4):    //pc+4
        (NPCOp==5'd1 && RD1==RD2)? 
            (D_pc+4+{{14{imm26[15]}}, imm26[15:0], 2'b00}): //beq满足条件时
        (NPCOp==5'd2)? 
            {D_pc[31:28], imm26, 2'b00}:                    //jal
        (NPCOp==5'd3)? 
            RD1:         //jr
        (NPCOp==5'd4 && RD1!=RD2)?
            (D_pc+4+{{14{imm26[15]}}, imm26[15:0], 2'b00}): //bne满足条件时
        F_pc+4;                     //其他情况 默认pc+4

endmodule
