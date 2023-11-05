`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:08:03 10/26/2022 
// Design Name: 
// Module Name:    control 
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
module control(
    input [5:0] Op,
    input [5:0] Func,
    output [2:0] RegDstSel,
    output [2:0] ALUSrcSel,
    output [2:0] toRegSel,
    output RegWrite,
    output MemWrite,
    output [2:0] NPCOp,
    output [3:0] ALUOp,
    output [2:0] EXTOp,
    output [2:0] DMType     //new
    );
    
//定义指令机器码常量 常量名大写
    //Op
    parameter R = 6'b000000;    //R类型指令
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter BEQ = 6'b000100;
    parameter LUI = 6'b001111;
    parameter ORI = 6'b001101;
    parameter JAL = 6'b000011;
    
    //Func
    parameter ADDU = 6'b100000;
    parameter SUBU = 6'b100010;
    parameter JR = 6'b001000;
    
//建立指令与机器码的映射 wire名小写
    wire addu, subu, lw, sw, beq, lui, ori, jal, jr;
    
    assign addu = (Op==R) & (Func==ADDU);   //R类型指令
    assign subu = (Op==R) & (Func==SUBU);   //R类型指令
    assign lw = (Op==LW);
    assign sw = (Op==SW);
    assign beq = (Op==BEQ);
    assign lui = (Op==LUI);
    assign ori = (Op==ORI);
    assign jal = (Op==JAL);
    assign jr = (Op==R) & (Func==JR);       //R类型指令
    
//建立控制信号与指令的映射
    assign RegDstSel =  (lw|lui|ori)? 3'b000:       //rt
                        (addu|subu)? 3'b001:        //rd
                        (jal)? 3'b010:              //31
                        3'b000;
    assign ALUSrcSel =  (addu|subu|beq)? 3'b000:    //RD2
                        (lw|sw|ori)? 3'b001:        //EXT
                        3'b000;
    assign toRegSel =   (addu|subu|ori)? 3'b000:    //ALUtoReg
                        (lw)? 3'b001:               //MemtoReg
                        (lui)? 3'b010:              //EXTtoReg
                        (jal)? 3'b011:              //PC4toReg
                        3'b000;
    assign RegWrite = (addu|subu|lw|lui|ori|jal);
    assign MemWrite = (sw);
    assign NPCOp =  (addu|subu|lw|sw|lui|ori)? 3'b000:  //PC4
                    (beq)? 3'b001:                      //beq            
                    (jal)? 3'b010:                      //jal    
                    (jr)? 3'b011:                       //jr    
                    3'b000;
    assign ALUOp =  (ori)? 4'b0001:                 //或
                    (addu|lw|sw)? 4'b0010:          //加
                    (subu)? 4'b0011:                //减
                    4'b0000;
    assign EXTOp =  (ori)? 3'b000:                  //无符号拓展
                    (lw|sw)? 3'b001:                //有符号拓展
                    (lui)? 3'b010:                  //加载到高位
                    3'b000;
    //new
    assign DMType = (lw|sw)? 3'd0:
                    3'd0;
endmodule
