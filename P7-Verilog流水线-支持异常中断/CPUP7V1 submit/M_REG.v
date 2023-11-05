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
    input excOvDM_in,
    input [4:0] excCode_in,
    input bd_in,
    input req,
    output [31:0] instr_out,
    output [31:0] pc_out,
    output [31:0] RD2_out,
    output [31:0] EXT32_out,
    output [31:0] AO_out,
    output [31:0] MDUO_out,
    output excOvDM_out,
    output [4:0] excCode_out,
    output bd_out
    );
    
    reg [31:0] instr;
    reg [31:0] pc;
    reg [31:0] RD2;
    reg [31:0] EXT32;
    reg [31:0] AO;
    reg [31:0] MDUO;
    reg excOvDM;
    reg [4:0] excCode;
    reg bd;
    
    assign instr_out = instr;
    assign pc_out = pc;
    assign RD2_out = RD2;
    assign EXT32_out = EXT32;
    assign AO_out = AO;
    assign MDUO_out = MDUO;
    assign excOvDM_out = excOvDM;
    assign excCode_out = excCode;
    assign bd_out = bd;

    always @(posedge clk) begin
        if(reset|req) begin
            instr <= 0;
            pc <= req? 32'h0000_4180: 0;
            RD2 <= 0;
            EXT32 <= 0;
            AO <= 0;
            MDUO <= 0;
            excOvDM <= 0;
            excCode <= 0;
            bd <= 0;
        end
        else if(WE) begin
            instr <= instr_in;
            pc <= pc_in;
            RD2 <= RD2_in;
            EXT32 <= EXT32_in;
            AO <= AO_in;
            MDUO <= MDUO_in;
            excOvDM <= excOvDM_in;
            excCode <= excCode_in;
            bd <= bd_in;
        end
    end

endmodule
