`timescale 1ns / 1ps

module F_PC(
    input clk,
    input reset,
    input PCWE,
    input [31:0] npc,
    output [31:0] pc
    );
    reg [31:0] pc_reg;
    assign pc = pc_reg;
    
    always @(posedge clk) begin
        if(reset) begin
            pc_reg <= 32'h0000_3000;
        end
        else if(PCWE) begin
            pc_reg <= npc;
        end
    end
    
endmodule
