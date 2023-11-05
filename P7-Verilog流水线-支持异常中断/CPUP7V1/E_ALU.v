`timescale 1ns / 1ps

module E_ALU(
    input [4:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    input ALUDMOV,
    input ALUARIOV,
    output [31:0] AO,
    output excOvDM,
    output excOv
    );
    wire slt = ($signed(A) < $signed(B))? 32'd1: 32'd0;
    assign AO = (ALUOp==5'd0)? (A&B):
                (ALUOp==5'd1)? (A|B):
                (ALUOp==5'd2)? (A+B):
                (ALUOp==5'd3)? (A-B):
                (ALUOp==5'd4)? slt:
                (ALUOp==5'd5)? (A<B):
                32'h0000_0000;
    //溢出判断
    wire [32:0] Aext = {A[31], A};
    wire [32:0] Bext = {B[31], B};
    wire [32:0] addext = Aext + Bext;
    wire [32:0] subext = Aext - Bext;
    wire addov = (addext[32] != addext[31]);
    wire subov = (subext[32] != subext[31]);

    assign excOv = 
        ALUARIOV && ((ALUOp==5'd2 && addov) || (ALUOp==5'd3 && subov));
    assign excOvDM =
        ALUDMOV && ((ALUOp==5'd2 && addov) || (ALUOp==5'd3 && subov));

endmodule
