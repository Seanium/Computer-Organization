`timescale 1ns / 1ps
`include "const.v"

module CU(
    //指令
    input [31:0] instr,
    //DM写数据地址
    input [31:0] DMA,
    //分割指令
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] imm16,
    output [25:0] imm26,
    //指令类型
    output [4:0] type,
    //信号
    output eret,
    //D
    output [4:0] EXTOp,
    output [4:0] NPCOp,
    output F_bd,
    output D_excRI,
    output D_excSyscall,
    //E
    output [4:0] ALUOp,
    output [4:0] ALUBSrc,
    output [4:0] MDUType,
    output ALUDMOV,
    output ALUARIOV,
    //M
    output [3:0] DMWE,      //4位DM字节写使能
    output [4:0] DMWDType,  //写数据种类 sw/sh/sb
    output [4:0] DEOp,
    output M_CP0WE,
    output [4:0] DMtype,    //读写数据种类 w/h/b
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
    parameter J = 6'b000010;

    parameter SH = 6'b101001;
    parameter SB = 6'b101000;
    parameter LH = 6'b100001;
    parameter LB = 6'b100000;

    parameter BNE = 6'b000101;

    parameter ADDI = 6'b001000;
    parameter ADDIU = 6'b001001;
    parameter ANDI = 6'b001100;
    
    //func
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter ADDU = 6'b100001;
    // parameter SUBU = 6'b100011;
    parameter JR = 6'b001000;

    parameter MFHI = 6'b010000;
    parameter MFLO = 6'b010010;
    parameter MTHI = 6'b010001;
    parameter MTLO = 6'b010011;
    parameter MULT = 6'b011000;
    parameter MULTU = 6'b011001;
    parameter DIV = 6'b011010;
    parameter DIVU = 6'b011011;

    parameter SLT = 6'b101010;
    parameter SLTU = 6'b101011;
    parameter AND = 6'b100100;
    parameter OR = 6'b100101;

    parameter SYSCALL = 6'b001100;

//建立指令与机器码的映射 wire名小写
    wire add, addu, sub, lw, sw, beq, lui, ori, jal, j, jr,
        mfhi, mflo, mthi, mtlo, mult, multu, div, divu,
        sh, sb, lh, lb,
        slt, sltu, and_, or_,
        bne,
        addi, addiu, andi, 
        mfc0, mtc0, syscall;
    
    assign add = (op==R) & (func==ADD);
    assign addu = (op==R) & (func==ADDU);
    assign sub = (op==R) & (func==SUB);
    assign lw = (op==LW);
    assign sw = (op==SW);
    assign beq = (op==BEQ);
    assign lui = (op==LUI);
    assign ori = (op==ORI);
    assign jal = (op==JAL);
    assign j = (op==J);
    assign jr = (op==R) & (func==JR);

    assign mfhi = (op==R) & (func==MFHI);
    assign mflo = (op==R) & (func==MFLO);
    assign mthi = (op==R) & (func==MTHI);
    assign mtlo = (op==R) & (func==MTLO);
    assign mult = (op==R) & (func==MULT);
    assign multu = (op==R) & (func==MULTU);
    assign div = (op==R) & (func==DIV);
    assign divu = (op==R) & (func==DIVU);

    assign sh = (op==SH);
    assign sb = (op==SB);
    assign lh = (op==LH);
    assign lb = (op==LB);

    assign slt = (op==R) & (func==SLT);
    assign sltu = (op==R) & (func==SLTU);
    assign and_ = (op==R) & (func==AND);
    assign or_ = (op==R) & (func==OR);

    assign bne = (op==BNE);

    assign addi = (op==ADDI);
    assign addiu = (op==ADDIU);
    assign andi = (op==ANDI);

    assign mfc0 = (instr[31:21]==11'b010000_00000);
    assign mtc0 = (instr[31:21]==11'b010000_00100);
    assign eret = (instr==32'b010000_1000_0000_0000_0000_0000_011000);
    assign syscall = (op==R) & (func==SYSCALL);

//指令分类
    //指令小类
    assign type = (add|addu|sub|slt|sltu|and_|or_)? `calr:
                (ori|addi|addiu|andi)? `cali:
                (lui)? `lui:
                (lw|lh|lb)? `load:
                (sw|sh|sb)? `store:
                (beq|bne)? `branch:
                (jal)? `jal:
                (jr)? `jr:
                (mfhi|mflo)? `mf:
                (mthi|mtlo)? `mt:
                (mult|multu|div|divu)? `md:
                (mfc0)? `mfc0:
                (mtc0)? `mtc0:
                5'd31;  //其他指令type=31
    
    //乘除指令分类
    assign MDUType = (mfhi)? `MDUType_mfhi:
                    (mflo)? `MDUType_mflo:
                    (mthi)? `MDUType_mthi:
                    (mtlo)? `MDUType_mtlo:
                    (mult)? `MDUType_mult:
                    (multu)? `MDUType_multu:
                    (div)? `MDUType_div:
                    (divu)? `MDUType_divu:
                    5'd31;
    //写DM指令分类
    assign DMWDType = (sw)? `DMWDType_sw:
                    (sh)?   `DMWDType_sh:
                    (sb)?   `DMWDType_sb:
                    5'd31;

//建立控制信号与指令的映射
    assign GRFWE = (add|addu|sub|lw|lui|ori|jal|mfhi|mflo|lh|lb|
                    slt|sltu|and_|or_|addi|addiu|andi|mfc0);

    wire [1:0] DMAoffset = DMA[1:0];
    assign DMWE = 
        (sw)? 4'b1111:
        (sh & DMAoffset[1]==1'b0)? 4'b0011:
        (sh & DMAoffset[1]==1'b1)? 4'b1100:
        (sb & DMAoffset==2'b00)? 4'b0001:
        (sb & DMAoffset==2'b01)? 4'b0010:
        (sb & DMAoffset==2'b10)? 4'b0100:
        (sb & DMAoffset==2'b11)? 4'b1000:
        4'b0000;
    

    assign EXTOp =  (ori|andi)? 5'd0:                //无符号拓展
                    (lw|sw|sh|sb|lh|lb|addi|addiu)? 5'd1:              //有符号拓展
                    (lui)? 5'd2:                //加载到高位
                    5'd0;

    assign NPCOp =  (add|addu|sub|lw|sw|lui|ori|
                    mfhi|mflo|mthi|mtlo|mult|multu|div|divu|
                    sh|sb|lh|lb|
                    slt|sltu|and_|or_|addi|addiu|andi|
                    mfc0|mtc0|eret|syscall)? 5'd0:       //pc+4
                    (beq)? 5'd1:                    //beq            
                    (jal|j)? 5'd2:                    //jal    
                    (jr)? 5'd3:                     //jr  
                    (bne)? 5'd4:                    //bne  
                    5'd0;

    assign ALUOp =  (and_|andi)? 5'd0:                  //与
                    (ori|or_)? 5'd1:                    //或
                    (add|addu|lw|sw|sh|sb|lh|lb|addi|addiu)? 5'd2: //加
                    (sub)? 5'd3:                        //减
                    (slt)? 5'd4:                        //有符号小于
                    (sltu)? 5'd5:                       //无符号小于
                    5'd0;
    
    assign ALUBSrc =    (add|addu|sub|slt|sltu|and_|or_)? 5'd0:    //RD2
                        (lw|sw|ori|sh|sb|lh|lb|addi|addiu|andi)? 5'd1:      //EXT32
                        5'd2;

    //DM读数据扩展功能
    assign DEOp =   (lw)? 5'd0:
                    (lh)? 5'd1:
                    (lb)? 5'd2:
                    5'd0;

    //写寄存器地址源
    assign GRFA3Src =
        (lw|lui|ori|lh|lb|addi|addiu|andi|mfc0)? 5'd0:             //rt
        (add|addu|sub|mfhi|mflo|slt|sltu|and_|or_)? 5'd1:    //rd
        (jal)? 5'd2:                                    //31
        5'd0;

    //写寄存器数据源
    assign GRFWDSrc =   
        (add|addu|sub|ori|slt|sltu|and_|or_|addi|addiu|andi)? `GRFWDSrc_AO:  //AO
        (lw|lh|lb)? `GRFWDSrc_RD:       //RD
        (lui)? `GRFWDSrc_EXT32:         //EXT32
        (jal)? `GRFWDSrc_pc8:           //pc+8
        (mfhi|mflo)? `GRFWDSrc_MDUO:    //MDUO
        (mfc0)? `GRFWDSrc_CP0:        //CP0OUT                  
        5'd0;

    //写寄存器地址
    assign GRFA3 =  
        (lw|lui|ori|lh|lb|addi|addiu|andi|mfc0)? rt:          //rt
        (add|addu|sub|mfhi|mflo|slt|sltu|and_|or_)? rd:      //rd
        (jal)? 5'd31:                                   //31
        5'd0;
        
    //P7新增信号
    //D
    assign F_bd = (NPCOp!=5'd0);
    assign D_excRI = !(add|addu|sub|slt|sltu|and_|or_|
                        lw|lh|lb|sw|sh|sb|
                        beq|bne|
                        lui|ori|addi|addiu|andi|
                        jal|j|jr|
                        mfhi|mflo|mthi|mtlo|mult|multu|div|divu|
                        mfc0|mtc0|eret|syscall|
                        ((op==6'd0)&(func==6'd0)));     //加了addiu,addu,j
    assign D_excSyscall = syscall;
    //E
    assign ALUDMOV = lw|lh|lb|sw|sh|sb;
    assign ALUARIOV = add|addi|sub;     //没有addiu,addu
    //M
    assign M_CP0WE = mtc0;
    assign DMtype = (lw|sw)? `DMType_w:
                    (lh|sh)? `DMType_h:
                    (lb|sb)? `DMType_b:
                    5'd31;

endmodule
