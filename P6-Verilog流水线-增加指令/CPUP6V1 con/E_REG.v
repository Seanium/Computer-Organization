`timescale 1ns / 1ps

module E_REG(
    input clk,
    input reset,
    input WE,
    input [31:0] instr_in,
    input [31:0] pc_in,
    input [31:0] RD1_in,
    input [31:0] RD2_in,
    input [31:0] EXT32_in,
    input con_in,
    output [31:0] instr_out,
    output [31:0] pc_out,
    output [31:0] RD1_out,
    output [31:0] RD2_out,
    output [31:0] EXT32_out,
    output con_out
    );
    
    reg [31:0] instr;
    reg [31:0] pc;
    reg [31:0] RD1;
    reg [31:0] RD2;
    reg [31:0] EXT32;
    reg con;
    
    assign instr_out = instr;
    assign pc_out = pc;
    assign RD1_out = RD1;
    assign RD2_out = RD2;
    assign EXT32_out = EXT32;
    assign con_out = con;
    
    always @(posedge clk) begin
        if(reset) begin
            instr <= 0;
            pc <= 0;
            RD1 <= 0;
            RD2 <= 0;
            EXT32 <= 0;
            con <= 0;
        end
        else if(WE) begin
            instr <= instr_in;
            pc <= pc_in;
            RD1 <= RD1_in;
            RD2 <= RD2_in;
            EXT32 <= EXT32_in;
            con <= con_in;
        end
    end

endmodule
