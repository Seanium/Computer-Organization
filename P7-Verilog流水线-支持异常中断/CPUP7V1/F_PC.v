`timescale 1ns / 1ps

module F_PC(
    input clk,
    input reset,
    input PCWE,
    input [31:0] npc,
    input D_eret,
    input [31:0] EPC,
    input req,
    output [31:0] pc,
    output excAdEL
    );
    reg [31:0] pc_reg;
    assign pc = D_eret? EPC: pc_reg;
    
    assign excAdEL = 
        ((|pc[1:0]) || (pc<32'h0000_3000) || (pc>32'h0000_6ffc)) && !D_eret;

    always @(posedge clk) begin
        if(reset) begin
            pc_reg <= 32'h0000_3000;
        end
        else if(PCWE | req) begin
            pc_reg <= npc;
        end
    end

    
endmodule
