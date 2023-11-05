`timescale 1ns / 1ps
`include "const.v"

module mips(
    input clk,                    // 时钟信号
    input reset,                  // 同步复位信号
    input interrupt,              // 外部中断信号
    output [31:0] macroscopic_pc, // 宏观 PC

    output [31:0] i_inst_addr,    // IM 读取地址（取指 PC）
    input  [31:0] i_inst_rdata,   // IM 读取数据

    output [31:0] m_data_addr,    // DM 读写地址
    input  [31:0] m_data_rdata,   // DM 读取数据
    output [31:0] m_data_wdata,   // DM 待写入数据
    output [3 :0] m_data_byteen,  // DM 字节使能信号

    output [31:0] m_int_addr,     // 中断发生器待写入地址
    output [3 :0] m_int_byteen,   // 中断发生器字节使能信号

    output [31:0] m_inst_addr,    // M 级 PC

    output w_grf_we,              // GRF 写使能信号
    output [4 :0] w_grf_addr,     // GRF 待写入寄存器编号
    output [31:0] w_grf_wdata,    // GRF 待写入数据

    output [31:0] w_inst_addr     // W 级 PC
);

    //cpu
    wire [31:0] PrAddr;
    wire [31:0] PrWD;
    wire [3:0] PrWE;
    //tc
    wire IRQ0;
    wire IRQ1;
    wire [31:0] TC0RD;
    wire [31:0] TC1RD;
    wire [5:0] HWInt = {3'b0, interrupt, IRQ1, IRQ0};
    //bridge
    wire [31:0] PrRD;
    wire [31:0] DevAddr;
    wire [31:0] DevWD;
    wire [3:0] DMWE;
    wire TC0WE;
    wire TC1WE;
    wire [3:0] IRWE;

    //外置DM
    assign m_data_addr = DevAddr;
    assign m_data_wdata = DevWD;
    assign m_data_byteen = DMWE;
    //响应外部中断
    assign m_int_addr = DevAddr;
    assign m_int_byteen = IRWE;

    //输出某个地址的指令 debug用
    wire [31:0] w_inst_addr_cpu;
    wire [31:0] w_inst;
    //切换下面两行
    // assign w_inst_addr = (w_inst_addr==32'h0000_3000)? w_inst: w_inst_addr_cpu; //debug用
    assign w_inst_addr = w_inst_addr_cpu;

cpu cpu(
    .clk(clk),
    .reset(reset),
    .HWInt(HWInt),
    .macroscopic_pc(macroscopic_pc),  //output

    .i_inst_addr(i_inst_addr),     //output
    .i_inst_rdata(i_inst_rdata),

    .m_data_addr(PrAddr),     //output
    .m_data_rdata(PrRD),
    .m_data_wdata(PrWD),    //output
    .m_data_byteen(PrWE),   //output

    // .m_int_addr(m_int_addr),      //output
    // .m_int_byteen(m_int_byteen),    //output

    .m_inst_addr(m_inst_addr),     //output

    .w_grf_we(w_grf_we),        //output
    .w_grf_addr(w_grf_addr),      //output
    .w_grf_wdata(w_grf_wdata),     //output

    // .w_inst_addr(w_inst_addr),      //output 改用下面一行的写法
    .w_inst_addr(w_inst_addr_cpu),  //output debug用

    .w_inst(w_inst) //debug用
    );

TC tc0(
    .clk(clk),
    .reset(reset),
    .Addr(DevAddr[31:2]),
    .WE(TC0WE),
    .Din(DevWD),
    //output
    .Dout(TC0RD),
    .IRQ(IRQ0)
    );

TC tc1(
    .clk(clk),
    .reset(reset),
    .Addr(DevAddr[31:2]),
    .WE(TC1WE),
    .Din(DevWD),
    //output
    .Dout(TC1RD),
    .IRQ(IRQ1)
    );

Bridge bridge(
//读写地址 input来自cpu output给外设
    .PrAddr(PrAddr),
    //output
    .DevAddr(DevAddr),

//读 input来自外设 output给cpu
    .DMRD(m_data_rdata),
    .TC0RD(TC0RD),
    .TC1RD(TC1RD),
    //output
    .PrRD(PrRD),

//写 input来自cpu output给外设
    .PrWD(PrWD),
    .PrWE(PrWE),
    //output
    .DevWD(DevWD),
    .DMWE(DMWE),
    .TC0WE(TC0WE),
    .TC1WE(TC1WE),
    .IRWE(IRWE)
    );

endmodule