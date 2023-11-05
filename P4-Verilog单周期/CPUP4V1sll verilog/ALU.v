`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:37 10/26/2022 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUOp,
    input [4:0] shamt,
    output [31:0] Result,
    output Zero
    );
    assign Result = (ALUOp==4'b0000)? (A&B):
                    (ALUOp==4'b0001)? (A|B):
                    (ALUOp==4'b0010)? (A+B):
                    (ALUOp==4'b0011)? (A-B):
                    (ALUOp==4'b0100)? (B<<shamt):   //注意这里是B
                    32'h0000_0000;
                    
    assign Zero = (A==B);
endmodule
