`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:57 11/05/2022 
// Design Name: 
// Module Name:    W_REG 
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
module W_REG(
    input clk,
    input reset,
    input WE,
    input [31:0] instr_in,
    input [31:0] pc_in,
    input [31:0] EXT32_in,
    input [31:0] AO_in,
    input [31:0] RD_in,
    input con_in,
    output [31:0] instr_out,
    output [31:0] pc_out,
    output [31:0] EXT32_out,
    output [31:0] AO_out,
    output [31:0] RD_out,
    output con_out
    );
    
    reg [31:0] instr;
    reg [31:0] pc;
    reg [31:0] EXT32;
    reg [31:0] AO;
    reg [31:0] RD;
    reg con;
    
    assign instr_out = instr;
    assign pc_out = pc;
    assign EXT32_out = EXT32;
    assign AO_out = AO;
    assign RD_out = RD;
    assign con_out = con;
    
    always @(posedge clk) begin
        if(reset) begin
            instr <= 0;
            pc <= 0;
            EXT32 <= 0;
            AO <= 0;
            RD <= 0;
            con <= 0;
        end
        else if(WE) begin
            instr <= instr_in;
            pc <= pc_in;
            EXT32 <= EXT32_in;
            AO <= AO_in;
            RD <= RD_in;
            con <= con_in;
        end
    end


endmodule
