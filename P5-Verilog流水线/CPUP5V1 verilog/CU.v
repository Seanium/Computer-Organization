`timescale 1ns / 1ps
`include "const.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:30 11/05/2022 
// Design Name: 
// Module Name:    CU 
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
module CU(
    //指令
    input [31:0] instr,
    //分割指令
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] imm16,
    output [25:0] imm26,
    //指令类型
    output [4:0] type,
    //信号
    //D
    output [4:0] EXTOp,
    output [4:0] NPCOp,
    //E
    output [4:0] ALUOp,
    output [4:0] ALUBSrc,
    //M
    output DMWE,
    //W
    output GRFWE,
    output [4:0] GRFA3Src,
    output [4:0] GRFWDSrc,
    output [4:0] GRFA3
    );

//分割指令
    wire [5:0] op, func;
    assign op = instr[31:26];
    assign func = instr[5:0];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign imm16 = instr[15:0];
    assign imm26 = instr[25:0];
//定义指令机器码常量 常量名大写
    //op
    parameter R = 6'b000000;    //R类型指令
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter BEQ = 6'b000100;
    parameter LUI = 6'b001111;
    parameter ORI = 6'b001101;
    parameter JAL = 6'b000011;
    
    //func
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    // parameter ADDU = 6'b100001; //调试用
    // parameter SUBU = 6'b100011; //调试用
    parameter JR = 6'b001000;

    
//建立指令与机器码的映射 wire名小写
    wire add, sub, lw, sw, beq, lui, ori, jal, jr;
    
    // assign add = (op==R) & (func==ADD|func==ADDU);   //调试用 //R类型指令
    // assign sub = (op==R) & (func==SUB|func==SUBU);   //调试用 //R类型指令

    assign add = (op==R) & (func==ADD);   //R类型指令
    assign sub = (op==R) & (func==SUB);   //R类型指令
    assign lw = (op==LW);
    assign sw = (op==SW);
    assign beq = (op==BEQ);
    assign lui = (op==LUI);
    assign ori = (op==ORI);
    assign jal = (op==JAL);
    assign jr = (op==R) & (func==JR);       //R类型指令
//指令分类
    assign type = (add|sub)? `calr:
                (ori)? `cali:
                (lui)? `lui:
                (lw)? `load:
                (sw)? `store:
                (beq)? `beq:
                (jal)? `jal:
                (jr)? `jr:
                5'd31;  //其他指令type=31
                
//建立控制信号与指令的映射
    assign GRFWE = (add|sub|lw|lui|ori|jal);
    assign DMWE = (sw);
    
    assign EXTOp =  (ori)? 5'd0:                //无符号拓展
                    (lw|sw)? 5'd1:              //有符号拓展
                    (lui)? 5'd2:                //加载到高位
                    5'd0;
    assign NPCOp =  (add|sub|lw|sw|lui|ori)? 5'd0:      //pc+4
                    (beq)? 5'd1:                        //beq            
                    (jal)? 5'd2:                        //jal    
                    (jr)? 5'd3:                         //jr    
                    5'd0;
    assign ALUOp =  (ori)? 5'd1:                //或
                    (add|lw|sw)? 5'd2:          //加
                    (sub)? 5'd3:                //减
                    5'd0;
                    
    assign ALUBSrc =    (add|sub)? 5'd0:    //RD2
                        (lw|sw|ori)? 5'd1:      //EXT32
                        5'd2;
    //写寄存器地址源
    assign GRFA3Src =   (lw|lui|ori)? 5'd0:     //rt
                        (add|sub)? 5'd1:        //rd
                        (jal)? 5'd2:            //31
                        5'd0;
    //写寄存器数据源
    assign GRFWDSrc =   (add|sub|ori)? `GRFWDSrc_AO:    //AO
                        (lw)? `GRFWDSrc_RD:             //RD
                        (lui)? `GRFWDSrc_EXT32:         //EXT32
                        (jal)? `GRFWDSrc_pc8:           //pc+8
                        5'd0;
    //写寄存器地址
    assign GRFA3 =  (lw|lui|ori)? rt:   //rt
                    (add|sub)? rd:      //rd
                    (jal)? 5'd31:       //31
                    5'd0;
endmodule

