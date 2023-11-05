`timescale 1ns / 1ps

module M_REG(
    input clk,
    input reset,
    input WE,
    input [31:0] instr_in,
    input [31:0] pc_in,
    input [31:0] RD2_in,
    input [31:0] EXT32_in,
    input [31:0] AO_in,
    input [31:0] MDUO_in,
    output [31:0] instr_out,
    output [31:0] pc_out,
    output [31:0] RD2_out,
    output [31:0] EXT32_out,
    output [31:0] AO_out,
    output [31:0] MDUO_out
    );
    
    reg [31:0] instr;
    reg [31:0] pc;
    reg [31:0] RD2;
    reg [31:0] EXT32;
    reg [31:0] AO;
    reg [31:0] MDUO;
    
    assign instr_out = instr;
    assign pc_out = pc;
    assign RD2_out = RD2;
    assign EXT32_out = EXT32;
    assign AO_out = AO;
    assign MDUO_out = MDUO;
    
    always @(posedge clk) begin
        if(reset) begin
            instr <= 0;
            pc <= 0;
            RD2 <= 0;
            EXT32 <= 0;
            AO <= 0;
            MDUO <= 0;
        end
        else if(WE) begin
            instr <= instr_in;
            pc <= pc_in;
            RD2 <= RD2_in;
            EXT32 <= EXT32_in;
            AO <= AO_in;
            MDUO <= MDUO_in;
        end
    end

endmodule
