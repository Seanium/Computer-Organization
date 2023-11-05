`timescale 1ns / 1ps

module D_EXT(
    input [15:0] imm16,
    input [4:0] EXTOp,
    output [31:0] EXT32
    );
    
    wire [31:0] signext;
    assign signext = {{16{imm16[15]}}, imm16};
    
    assign EXT32 =  
        (EXTOp==5'd0)? {16'h0000, imm16}:   //无符号扩展
        (EXTOp==5'd1)? signext:             //有符号扩展
        (EXTOp==5'd2)? {imm16, 16'h0000}:   //加载到高位
        {16'h0000, imm16};                      //其他情况 默认无符号扩展
        
endmodule
