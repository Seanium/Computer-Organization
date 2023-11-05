`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:49 11/05/2022 
// Design Name: 
// Module Name:    F_IFU 
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
module F_IFU(
    input clk,
    input reset,
    input PCWE,
    input [31:0] npc,
    output [31:0] instr,
    output [31:0] pc
    );
    reg [31:0] pc_reg;
    assign pc = pc_reg;
    
    reg [31:0] im[4095:0];
    wire [31:0] pcsub;
    assign pcsub = pc-32'h0000_3000;
    assign instr = im[pcsub[13:2]];
    
    integer i;
    initial begin
        //先手动复位im
        for(i=0; i<4096; i=i+1) begin
            im[i]=32'h0;
        end
        //再从文件读入指令
        $readmemh("code.txt", im);
    end
    
    always @(posedge clk) begin
        if(reset) begin
            pc_reg <= 32'h0000_3000;
        end
        else if(PCWE) begin
            pc_reg <= npc;
        end
    end
    
endmodule
