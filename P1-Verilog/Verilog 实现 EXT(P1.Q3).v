`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:00:31 10/05/2022 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output [31:0] ext
    );
	 wire [31:0] signExt;
	 assign signExt = $signed(imm);
	 assign ext = (EOp==2'b00)? signExt:
					  (EOp==2'b01)? {16'h0000, imm}:
					  (EOp==2'b10)? {imm, 16'h0000}:
					  (EOp==2'b11)? signExt<<2: ext;

endmodule
