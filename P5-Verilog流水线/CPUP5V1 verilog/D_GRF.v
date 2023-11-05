`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:34:35 11/05/2022 
// Design Name: 
// Module Name:    D_GRF 
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
module D_GRF(
    input [31:0] wpc,
    input clk,
    input reset,
    input WE,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2
    );
    
    reg [31:0] grf[31:0];
    
    //使用内部转发
    //当前GRF被写入的值会即时反馈到读取端上
    
    //当读寄存器时的地址与同周期写寄存器的地址相同时
    //将读取的内容改为写寄存器的内容
    //而不是该地址索引到的寄存器的值
    assign RD1 = (A3==A1 && A3 && WE)? WD: grf[A1];
    assign RD2 = (A3==A2 && A3 && WE)? WD: grf[A2];
    
    integer i;
    always @(posedge clk) begin
        if(reset) begin
            for(i=0; i<=31; i=i+1)
                grf[i] <= 32'h0000_0000;
        end
        else if(WE && A3) begin
            grf[A3] <= WD;
            $display("%d@%h: $%d <= %h", $time, wpc, A3, WD);
            //$display("@%h: $%d <= %h", wpc, A3, WD); //调试用
        end
    end

endmodule
