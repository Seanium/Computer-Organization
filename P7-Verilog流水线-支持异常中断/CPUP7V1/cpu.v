`timescale 1ns / 1ps
`include "const.v"

module cpu(
    input clk,                    // 时钟信号
    input reset,                  // 同步复位信号
    // input interrupt,              // 外部中断信号
    input [5:0] HWInt,
    output [31:0] macroscopic_pc, // 宏观 PC

    output [31:0] i_inst_addr,    // IM 读取地址（取指 PC）
    input  [31:0] i_inst_rdata,   // IM 读取数据

    output [31:0] m_data_addr,    // DM 读写地址
    input  [31:0] m_data_rdata,   // DM 读取数据
    output [31:0] m_data_wdata,   // DM 待写入数据
    output [3 :0] m_data_byteen,  // DM 字节使能信号

    // output [31:0] PrAddr,
    // input [31:0] PrRD,
    // output [31:0] PrWD,
    // output [3:0] PrWE,

    // output [31:0] m_int_addr,     // 中断发生器待写入地址
    // output [3 :0] m_int_byteen,   // 中断发生器字节使能信号

    output [31:0] m_inst_addr,    // M 级 PC

    output w_grf_we,              // GRF 写使能信号
    output [4 :0] w_grf_addr,     // GRF 待写入寄存器编号
    output [31:0] w_grf_wdata,    // GRF 待写入数据

    output [31:0] w_inst_addr,      // W 级 PC
    output [31:0] w_inst            // W级指令 debug用
    );


//wire output
//F_pc
    wire [31:0] F_pc;
    wire F_excAdEL;
//F_im
    wire [31:0] F_instr;
//D_reg
    wire [31:0] D_instr;
    wire [31:0] D_pc;
    wire [4:0] D_old_ExcCode;
    wire D_bd;
//D_cu
    wire [4:0] D_rs;
    wire [4:0] D_rt;
    wire [15:0] D_imm16;
    wire [25:0] D_imm26;
    wire [4:0] D_EXTOp;
    wire [4:0] D_NPCOp;
    wire D_eret;
    wire D_excRI;
    wire D_excSyscall;
    wire F_bd;
//D_grf
    wire [31:0] D_RD1;
    wire [31:0] D_RD2;
//D_ext
    wire [31:0] D_EXT32;
//D_npc
    wire [31:0] npc; 
//E_reg
    wire [31:0] E_instr;
    wire [31:0] E_pc;
    wire [31:0] E_RD1;
    wire [31:0] E_RD2;
    wire [31:0] E_EXT32;
    wire [4:0] E_old_excCode;
    wire E_bd;
//E_cu
    wire [4:0] E_rs;
    wire [4:0] E_rt;
    wire [4:0] E_ALUOp;
    wire [4:0] E_ALUBSrc;
    wire [4:0] E_MDUType;
    wire [4:0] E_GRFWDSrc;
    wire [4:0] E_GRFA3;
    wire E_ALUDMOV;
    wire E_ALUARIOV;
//E_alu
    wire [31:0] E_ALUB =            //ALUB的数据mux
        (E_ALUBSrc==5'd0)? FE_RD2:
        (E_ALUBSrc==5'd1)? E_EXT32:
        32'b0;
    wire [31:0] E_AO;
    wire E_excOvDM;
    wire E_excOv;
//E_mdu
    wire [31:0] E_MDUO;
    wire E_MDUstart;
    wire E_MDUbusy;
    
//M DM异常检测
    wire errAlign;
    wire errRange;
    wire errTimer;
    wire errCount;
    wire M_excAdEL;
    wire M_excAdES;
//M_reg
    wire [31:0] M_instr;
    wire [31:0] M_pc;
    wire [31:0] M_RD2;
    wire [31:0] M_EXT32;
    wire [31:0] M_AO;
    wire [31:0] M_MDUO;
    wire M_excOvDM;
    wire [4:0] M_old_excCode;
    wire M_bd;
//M_cu
    wire [4:0] M_rs;
    wire [4:0] M_rt;
    wire [4:0] M_rd;
    wire [3:0] M_DMWE;
    wire [4:0] M_DMWDType;
    wire [4:0] M_DEOp;
    wire [4:0] M_GRFWDSrc;
    wire [4:0] M_GRFA3;
    wire M_eret;
    wire [4:0] M_DMType;
    wire [4:0] M_type;
    wire M_CP0WE;
//M_de
    wire [31:0] M_RD;
//M_cp0
    wire [31:0] M_CP0Out;
    wire [31:0] EPC;
    wire req;
//W_reg
    wire [31:0] W_instr;
    wire [31:0] W_pc;
    wire [31:0] W_EXT32;
    wire [31:0] W_AO;
    wire [31:0] W_MDUO;
    wire [31:0] W_RD;
    wire [31:0] W_CP0OUT;
//W_cu
    wire W_GRFWE;
    wire [4:0] W_GRFA3Src;
    wire [4:0] W_GRFWDSrc;
    wire [4:0] W_GRFA3;

//外置im
    assign i_inst_addr = F_pc;
    assign F_instr = (F_excAdEL)? 32'd0: i_inst_rdata;
//外置dm
    assign m_data_addr = M_AO;
    assign m_data_wdata = 
        (M_DMWDType==`DMWDType_sw)? (FM_RD2):
        (M_DMWDType==`DMWDType_sh)? ({2{FM_RD2[15:0]}}):
        (M_DMWDType==`DMWDType_sb)? ({4{FM_RD2[7:0]}}):
        32'd0;
    assign m_data_byteen = req? 4'b0: M_DMWE;
    assign m_inst_addr = M_pc;
//grf评测信号
    assign w_grf_we = W_GRFWE;
    assign w_grf_addr = W_GRFA3;
    assign w_grf_wdata = W_GRFWD;
    assign w_inst_addr = W_pc;
//宏观pc
    assign macroscopic_pc = M_pc;
//w级指令 debug用
    assign w_inst = W_instr;
//暂停单元
    wire stall;
    //控制信号
    //IFU中PC写使能信号
    wire F_PCWE = !stall;           //冻结PC

    //流水寄存器写使能信号
    wire D_REGWE = !stall;          //冻结D_REG
    wire E_REGWE = 1'b1;
    wire M_REGWE = 1'b1;
    wire W_REGWE = 1'b1;

    //流水寄存器清除信号
    wire D_REGreset = reset;
    wire E_REGreset = reset | stall;    //清空E_REG 注意或reset
    wire M_REGreset = reset;
    wire W_REGreset = reset;

SU su (
    .D_instr(D_instr), 
    .E_instr(E_instr), 
    .M_instr(M_instr), 
    .E_MDUstart(E_MDUstart),
    .E_MDUbusy(E_MDUbusy),
    //output
    .stall(stall)
    );

//转发发送mux
//从流水线寄存器供给转发数据
    wire [31:0] E_GRFWD = 
        (E_GRFWDSrc==`GRFWDSrc_EXT32)? E_EXT32:
        (E_GRFWDSrc==`GRFWDSrc_pc8)? E_pc+8:   //延迟槽
        31'd0;

    wire [31:0] M_GRFWD =
        (M_GRFWDSrc==`GRFWDSrc_AO)? M_AO:
        (M_GRFWDSrc==`GRFWDSrc_EXT32)? M_EXT32:
        (M_GRFWDSrc==`GRFWDSrc_pc8)? M_pc+8:  //延迟槽   
        (M_GRFWDSrc==`GRFWDSrc_MDUO)? M_MDUO:
        31'd0;

    wire [31:0] W_GRFWD =       //既是转发发送mux 也是数据mux
        (W_GRFWDSrc==`GRFWDSrc_AO)? W_AO:
        (W_GRFWDSrc==`GRFWDSrc_RD)? W_RD:
        (W_GRFWDSrc==`GRFWDSrc_EXT32)? W_EXT32:
        (W_GRFWDSrc==`GRFWDSrc_pc8)? W_pc+8:    //延迟槽
        (W_GRFWDSrc==`GRFWDSrc_MDUO)? W_MDUO:
        (W_GRFWDSrc==`GRFWDSrc_CP0)? W_CP0OUT:
        31'd0;

//转发接收mux
//按照就近原则选择转发数据
    wire [31:0] FD_RD1 = 
        (D_rs==5'b0)? 32'b0:
        (D_rs==E_GRFA3)? E_GRFWD:   //D<-E
        (D_rs==M_GRFA3)? M_GRFWD:   //D<-M
                                    //D<-W空缺，因为用了内部转发
        D_RD1;                      //D<-D
        
    wire [31:0] FD_RD2 = 
        (D_rt==5'b0)? 32'b0:
        (D_rt==E_GRFA3)? E_GRFWD:   //D<-E
        (D_rt==M_GRFA3)? M_GRFWD:   //D<-M
                                    //D<-W空缺，因为用了内部转发
        D_RD2;                      //D<-D
        
    wire [31:0] FE_RD1 = 
        (E_rs==5'b0)? 32'b0:        
        (E_rs==M_GRFA3)? M_GRFWD:   //E<-M
        (E_rs==W_GRFA3)? W_GRFWD:   //E<-W
        E_RD1;                      //E<-E

    wire [31:0] FE_RD2 = 
        (E_rt==5'b0)? 32'b0:        
        (E_rt==M_GRFA3)? M_GRFWD:   //E<-M
        (E_rt==W_GRFA3)? W_GRFWD:   //E<-W
        E_RD2;                      //E<-E

    wire [31:0] FM_RD2 = 
        (M_rt==5'b0)? 32'b0:
        (M_rt==W_GRFA3)? W_GRFWD:   //M<-W
        M_RD2;                      //M<-M


//异常流水mux
    wire [4:0] F_excCode = 
        F_excAdEL? `EXC_ADEL: `EXC_NONE;

    wire [4:0] D_excCode = 
        D_old_ExcCode? D_old_ExcCode:
        D_excSyscall? `EXC_SYSCALL:
        D_excRI? `EXC_RI: 
        `EXC_NONE;

    wire [4:0] E_excCode = 
        E_old_excCode? E_old_excCode:
        E_excOv? `EXC_OV:
        `EXC_NONE;

    wire [4:0] M_excCode =
        M_old_excCode? M_old_excCode:
        M_excAdEL? `EXC_ADEL:
        M_excAdES? `EXC_ADES:
        `EXC_NONE;
    

//F

F_PC F_pc_ (    //后缀下划线防止重名
    .clk(clk), 
    .reset(reset), 
    .PCWE(F_PCWE), 
    .npc(npc), 
    .D_eret(D_eret),
    .EPC(EPC),
    .req(req),
    //output
    .pc(F_pc),
    .excAdEL(F_excAdEL)
    );

//D

D_REG D_reg (
    .clk(clk), 
    .reset(D_REGreset), 
    .WE(D_REGWE), 
    .instr_in(F_instr), 
    .pc_in(F_pc), 
    .excCode_in(F_excCode),
    .bd_in(F_bd),
    .req(req),
    //output
    .instr_out(D_instr), 
    .pc_out(D_pc),
    .excCode_out(D_old_ExcCode),
    .bd_out(D_bd)
    );


CU D_cu (
    .instr(D_instr), 
    //output
    .rs(D_rs), 
    .rt(D_rt), 
    .imm16(D_imm16), 
    .imm26(D_imm26), 
    .EXTOp(D_EXTOp), 
    .NPCOp(D_NPCOp),
    .eret(D_eret),
    .D_excRI(D_excRI),
    .D_excSyscall(D_excSyscall),
    .F_bd(F_bd)
    );


D_GRF D_grf (
    .clk(clk), 
    .reset(reset), 
    .WE(W_GRFWE), 
    .A1(D_rs), 
    .A2(D_rt), 
    .A3(W_GRFA3),   //这里的数据mux集成在了CU内部 
    .WD(W_GRFWD),   //这里的数据mux其实就是上面转发提供mux
    //output
    .RD1(D_RD1), 
    .RD2(D_RD2)
    );


D_EXT D_ext (
    .imm16(D_imm16), 
    .EXTOp(D_EXTOp), 
    //output
    .EXT32(D_EXT32)
    );


D_NPC D_npc (
    .NPCOp(D_NPCOp), 
    .F_pc(F_pc), 
    .D_pc(D_pc), 
    .imm26(D_imm26), 
    .RD1(FD_RD1), 
    .RD2(FD_RD2), 
    .req(req),
    .eret(D_eret),
    .EPC(EPC),
    //output
    .npc(npc)
    );

//E

E_REG E_reg (
    .clk(clk), 
    .reset(E_REGreset),     //注意这里是或
    .WE(E_REGWE), 
    .instr_in(D_instr), 
    .pc_in(D_pc), 
    .RD1_in(FD_RD1), 
    .RD2_in(FD_RD2), 
    .EXT32_in(D_EXT32), 
    .excCode_in(D_excCode),
    .bd_in(D_bd),
    .req(req),
    .stall(stall),
    //output
    .instr_out(E_instr), 
    .pc_out(E_pc), 
    .RD1_out(E_RD1), 
    .RD2_out(E_RD2), 
    .EXT32_out(E_EXT32),
    .excCode_out(E_old_excCode),
    .bd_out(E_bd)
    );


CU E_cu (
    .instr(E_instr), 
    //output
    .rs(E_rs), 
    .rt(E_rt), 
    .ALUOp(E_ALUOp), 
    .ALUBSrc(E_ALUBSrc), 
    .MDUType(E_MDUType),    //乘除指令类型
    .GRFWDSrc(E_GRFWDSrc), 
    .GRFA3(E_GRFA3),
    .ALUDMOV(E_ALUDMOV),
    .ALUARIOV(E_ALUARIOV)
    );


E_ALU E_alu (
    .ALUOp(E_ALUOp), 
    .A(FE_RD1), 
    .B(E_ALUB), 
    .ALUDMOV(E_ALUDMOV),
    .ALUARIOV(E_ALUARIOV),
    //output
    .AO(E_AO),
    .excOvDM(E_excOvDM),
    .excOv(E_excOv)
    );

E_MDU E_mdu (
    .clk(clk),
    .reset(reset),
    .MDUType(E_MDUType),
    .A(FE_RD1),
    .B(FE_RD2),
    .req(req),
    //output
    .MDUO(E_MDUO),
    .start(E_MDUstart),
    .busy(E_MDUbusy)
    );

//M

    //DM异常检测

    // 按w/h存取地址未对齐
    assign errAlign = 
        (M_DMType==`DMType_w && (|m_data_addr[1:0])) ||
        (M_DMType==`DMType_h && (m_data_addr[0]));

    // 存取超出DM/Timer0/Timer1/中断发生器的范围
    assign errRange = 
        !((m_data_addr>=32'h0000_0000 && m_data_addr<=32'h0000_2fff)||
        (m_data_addr>=32'h0000_7f00 && m_data_addr<=32'h0000_7f0b)||
        (m_data_addr>=32'h0000_7f10 && m_data_addr<=32'h0000_7f1b)||
        (m_data_addr>=32'h0000_7f20 && m_data_addr<=32'h0000_7f23));

    // 按h/b存取Timer的3个寄存器
    assign errTimer = 
        (M_DMType==`DMType_h || M_DMType==`DMType_b) && 
        ((m_data_addr>=32'h0000_7f00 && m_data_addr<=32'h0000_7f0b)||
        (m_data_addr>=32'h0000_7f10 && m_data_addr<=32'h0000_7f1b));

    // 存Timer的Count寄存器
    assign errCount = 
        (m_data_addr>=32'h0000_7f08 && m_data_addr<=32'h0000_7f0b)||
        (m_data_addr>=32'h0000_7f18 && m_data_addr<=32'h0000_7f1b);

    assign M_excAdEL = 
        (M_type==`load) && (errAlign|errRange|errTimer|M_excOvDM);
    assign M_excAdES = 
        (M_type==`store) && (errAlign|errRange|errTimer|errCount|M_excOvDM);

M_REG M_reg (
    .clk(clk), 
    .reset(M_REGreset), 
    .WE(M_REGWE), 
    .instr_in(E_instr), 
    .pc_in(E_pc), 
    .RD2_in(FE_RD2), 
    .EXT32_in(E_EXT32), 
    .AO_in(E_AO),
    .MDUO_in(E_MDUO),
    .excOvDM_in(E_excOvDM),
    .excCode_in(E_excCode),
    .bd_in(E_bd),
    .req(req),
    //output 
    .instr_out(M_instr), 
    .pc_out(M_pc), 
    .RD2_out(M_RD2), 
    .EXT32_out(M_EXT32), 
    .AO_out(M_AO),
    .MDUO_out(M_MDUO),
    .excOvDM_out(M_excOvDM),
    .excCode_out(M_old_excCode),
    .bd_out(M_bd)
    );


CU M_cu (
    .instr(M_instr), 
    .DMA(M_AO),
    //output
    .rs(M_rs), 
    .rt(M_rt), 
    .rd(M_rd),
    .DMWE(M_DMWE), 
    .DMWDType(M_DMWDType),
    .DEOp(M_DEOp),
    .GRFWDSrc(M_GRFWDSrc), 
    .GRFA3(M_GRFA3),
    .eret(M_eret),
    .DMtype(M_DMType),
    .type(M_type),
    .M_CP0WE(M_CP0WE)
    );

M_DE M_de(
    .DEI(m_data_rdata),
    .DEOp(M_DEOp),
    .Aoffset(M_AO[1:0]),
    //output
    .DEO(M_RD)
    );

M_CP0 M_cp0(
    .clk(clk),
    .reset(reset),
    .en(M_CP0WE),
    .CP0Add(M_rd),
    .CP0In(FM_RD2),
    .VPC(M_pc),
    .BDIn(M_bd),
    .ExcCodeIn(M_excCode),
    .HWInt(HWInt),
    .EXLClr(M_eret),
    //output
    .CP0Out(M_CP0Out),
    .EPCOut(EPC),
    .Req(req)
    );

//W

W_REG W_reg (
    .clk(clk), 
    .reset(W_REGreset), 
    .WE(W_REGWE), 
    .instr_in(M_instr), 
    .pc_in(M_pc), 
    .EXT32_in(M_EXT32), 
    .AO_in(M_AO), 
    .MDUO_in(M_MDUO),
    .RD_in(M_RD), 
    .req(req),
    .CP0OUT_in(M_CP0Out),
    //output
    .instr_out(W_instr), 
    .pc_out(W_pc), 
    .EXT32_out(W_EXT32), 
    .AO_out(W_AO), 
    .MDUO_out(W_MDUO),
    .RD_out(W_RD),
    .CP0OUT_out(W_CP0OUT)
    );


CU W_cu (
    .instr(W_instr), 
    //output
    .GRFWE(W_GRFWE), 
    .GRFA3Src(W_GRFA3Src), 
    .GRFWDSrc(W_GRFWDSrc), 
    .GRFA3(W_GRFA3)
    );

endmodule
