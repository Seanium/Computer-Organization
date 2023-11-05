`timescale 1ns / 1ps

module D_REG(
    input clk,
    input reset,
    input WE,
    input [31:0] instr_in,
    input [31:0] pc_in,
    input [4:0] excCode_in,
    input bd_in,
    input req,
    output [31:0] instr_out,
    output [31:0] pc_out,
    output [4:0] excCode_out,
    output bd_out
    );
    
    reg [31:0] instr;
    reg [31:0] pc;
    reg [4:0] excCode;
    reg bd;
    
    assign instr_out = instr;
    assign pc_out = pc;
    assign excCode_out = excCode;
    assign bd_out = bd;
    
    always @(posedge clk) begin
        if(reset|req) begin
            instr <= 0;
            pc <= req? 32'h0000_4180: 0;
            excCode <= 0;
            bd <= 0;
        end
        else if(WE) begin
            instr <= instr_in;
            pc <= pc_in;
            excCode <= excCode_in;
            bd <= bd_in;
        end
    end

endmodule
