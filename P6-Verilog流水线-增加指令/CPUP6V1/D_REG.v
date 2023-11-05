`timescale 1ns / 1ps

module D_REG(
    input clk,
    input reset,
    input WE,
    input [31:0] instr_in,
    input [31:0] pc_in,
    output [31:0] instr_out,
    output [31:0] pc_out
    );
    
    reg [31:0] instr;
    reg [31:0] pc;
    
    assign instr_out = instr;
    assign pc_out = pc;
    
    always @(posedge clk) begin
        if(reset) begin
            instr <= 0;
            pc <= 0;
        end
        else if(WE) begin
            instr <= instr_in;
            pc <= pc_in;
        end
    end

endmodule
