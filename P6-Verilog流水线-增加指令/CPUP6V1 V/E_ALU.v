`timescale 1ns / 1ps

module E_ALU(
    input [4:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    output [31:0] AO
    );
    wire slt = ($signed(A) < $signed(B))? 32'd1: 32'd0;
    assign AO = (ALUOp==5'd0)? (A&B):
                (ALUOp==5'd1)? (A|B):
                (ALUOp==5'd2)? (A+B):
                (ALUOp==5'd3)? (A-B):
                (ALUOp==5'd4)? slt:
                (ALUOp==5'd5)? (A<B):
                32'h0000_0000;

endmodule
