`timescale 1ns / 1ps

module W_REG(
    input clk,
    input reset,
    input WE,
    input [31:0] instr_in,
    input [31:0] pc_in,
    input [31:0] EXT32_in,
    input [31:0] AO_in,
    input [31:0] MDUO_in,
    input [31:0] RD_in,
    input req,
    input [31:0] CP0OUT_in,
    output [31:0] instr_out,
    output [31:0] pc_out,
    output [31:0] EXT32_out,
    output [31:0] AO_out,
    output [31:0] MDUO_out,
    output [31:0] RD_out,
    output [31:0] CP0OUT_out
    );
    
    reg [31:0] instr;
    reg [31:0] pc;
    reg [31:0] EXT32;
    reg [31:0] AO;
    reg [31:0] RD;
    reg [31:0] MDUO;
    reg [31:0] CP0OUT;
    
    assign instr_out = instr;
    assign pc_out = pc;
    assign EXT32_out = EXT32;
    assign AO_out = AO;
    assign MDUO_out = MDUO;
    assign RD_out = RD;
    assign CP0OUT_out = CP0OUT;

    always @(posedge clk) begin
        if(reset|req) begin
            instr <= 0;
            pc <= req? 32'h0000_4180: 0;
            EXT32 <= 0;
            MDUO <= 0;
            AO <= 0;
            RD <= 0;
            CP0OUT <= 0;
        end
        else if(WE) begin
            instr <= instr_in;
            pc <= pc_in;
            EXT32 <= EXT32_in;
            MDUO <= MDUO_in;
            AO <= AO_in;
            RD <= RD_in;
            CP0OUT <= CP0OUT_in;
        end
    end


endmodule
