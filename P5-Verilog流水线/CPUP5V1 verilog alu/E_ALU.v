`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:26 11/05/2022 
// Design Name: 
// Module Name:    E_ALU 
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
module E_ALU(
    input [4:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    output [31:0] AO
    );

    function [31:0] new;
        input [31:0] A;
        input [31:0] B;
        begin
            
        end
    endfunction

    assign AO = (ALUOp==5'd0)? (A&B):
                (ALUOp==5'd1)? (A|B):
                (ALUOp==5'd2)? (A+B):
                (ALUOp==5'd3)? (A-B):
                (ALUOp==5'd4)? new(A, B):
                32'h0000_0000;

endmodule
