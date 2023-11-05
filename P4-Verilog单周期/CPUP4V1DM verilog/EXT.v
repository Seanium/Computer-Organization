`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:49 10/26/2022 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] I,
    input [2:0] EXTOp,
    output [31:0] O
    );
    wire [31:0] signExt;
    assign signExt = {{16{I[15]}}, I};
    assign O = (EXTOp==3'b000)? {16'h0000, I}:
                (EXTOp==3'b001)? signExt:
                (EXTOp==3'b010)? {I, 16'h0000}:
                {16'h0000, I};  //其他情况 默认无符号扩展

endmodule
