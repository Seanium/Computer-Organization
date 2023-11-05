`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:20 10/26/2022 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC,
    input [25:0] Imm26,
    input [31:0] RA,
    input Zero,
    input [2:0] NPCOp,
    output [31:0] NPC,
    output [31:0] PC4
    );
    
    assign PC4 = PC+4;
    assign NPC = (NPCOp==3'b000)? (PC+4):
                (NPCOp==3'b001 & Zero==1'b1)? (PC+4+{{14{Imm26[15]}}, Imm26[15:0], 2'b00}):
                (NPCOp==3'b001 & Zero==1'b0)? (PC+4):
                (NPCOp==3'b010)? {PC[31:28], Imm26, 2'b00}:
                (NPCOp==3'b011)? RA:
                PC+4;

endmodule
