`timescale 1ns / 1ps

`define IM SR[15:10]        //Interrupt Mask 6位中断屏蔽位 分别对应6个外部中断 相应位置1表示允许中断 置0表示禁止中断
`define EXL SR[1]           //Exception Level 异常级 1-进入异常 不允许再中断 0-允许中断
`define IE SR[0]            //Interrupt Enable 全局中断使能
`define BD Cause[31]        //Branch Delay
`define IP Cause[15:10]     //Interrupt Pending 对应6个外部中断 记录当前哪些硬件中断正在有效
`define ExcCode Cause[6:2]  //异常编码 记录当前发生的是什么异常

module M_CP0(
    input clk,              //时钟信号
    input reset,            //复位信号
    input en,               //写使能信号
    input [4:0] CP0Add,     //寄存器地址
    input [31:0] CP0In,     //CP0 写入数据
    input [31:0] VPC,       //受害 PC
    input BDIn,             //是否是延迟槽指令
    input [4:0] ExcCodeIn,  //记录异常类型
    input [5:0] HWInt,      //输入中断信号
    input EXLClr,           //用来复位 EXL
    output [31:0] CP0Out,   //CP0 读出数据
    output [31:0] EPCOut,   //EPC 的值
    output Req             //进入处理程序请求
);

    reg [31:0] SR;      //状态寄存器
    reg [31:0] Cause;   //原因寄存器
    reg [31:0] EPC;     //异常返回地址寄存器 记录异常处理结束后需要返回的 PC

    //中断请求
    wire IntReq = (|(HWInt & `IM)) & `IE & !`EXL;
    //异常请求
    wire ExcReq = (|ExcCodeIn) & !`EXL;
    //进入处理程序请求
    assign Req = IntReq | ExcReq;

    // assign EPCOut = (Req & BDIn)? VPC-32'h4:
    //                 (Req & !BDIn)? VPC:
    //                 EPC;
    assign EPCOut = EPC;

    // assign EPCOut = EPC;
    assign CP0Out = (CP0Add==5'd12)? SR:
                    (CP0Add==5'd13)? Cause:
                    (CP0Add==5'd14)? EPC:
                    0;

    always @(posedge clk) begin
        if(reset) begin
            SR <= 0;
            Cause <= 0;
            EPC <= 0;
        end
        else begin
            if(EXLClr) begin
                `EXL <= 1'b0;
            end
            if(Req) begin
                `BD <= BDIn;    //保存BD
                `ExcCode <= IntReq? 5'b0: ExcCodeIn; //保存ExcCode
                // EPC <= EPCOut;  //保存PC
                EPC <= BDIn? (VPC-32'd4): VPC;  //保存PC
                `EXL <= 1'b1;   //关中断
            end
            else if(en) begin
                if(CP0Add==12) SR <= CP0In;
                else if(CP0Add==14) EPC <= CP0In;
            end
            `IP <= HWInt; //不断更新外部6个中断
        end
    end

endmodule