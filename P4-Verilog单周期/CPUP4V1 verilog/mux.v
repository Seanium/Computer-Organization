`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:45:18 10/26/2022 
// Design Name: 
// Module Name:    mux 
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
module RegDstmux(
    input [2:0] RegDstSel,
    input [4:0] input0,
    input [4:0] input1,
    input [4:0] input2,
    output [4:0] RegDst
    );
    assign RegDst = (RegDstSel==3'b000)? input0:
                    (RegDstSel==3'b001)? input1:
                    (RegDstSel==3'b010)? input2:
                    5'b00000;


endmodule

module ALUSrcmux(
    input [2:0] ALUSrcSel,
    input [31:0] input0,
    input [31:0] input1,
    output [31:0] ALUSrc
    );
    assign ALUSrc = (ALUSrcSel==3'b000)? input0:
                    (ALUSrcSel==3'b001)? input1:
                    32'h0000_0000;

endmodule

module toRegmux(
    input [2:0] toRegSel,
    input [31:0] input0,
    input [31:0] input1,
    input [31:0] input2,
    input [31:0] input3,
    output [31:0] toReg
    );
    assign toReg = (toRegSel==3'b000)? input0:
                    (toRegSel==3'b001)? input1:
                    (toRegSel==3'b010)? input2:
                    (toRegSel==3'b011)? input3:
                    32'h0000_0000;

endmodule