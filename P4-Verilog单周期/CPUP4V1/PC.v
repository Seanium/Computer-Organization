`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:29:33 10/26/2022 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input reset,
    input [31:0] NPC,
    output [31:0] PC
    );
    reg [31:0] pc;
    
    assign PC = pc;
    
    always @(posedge clk) begin
        if(reset) begin
            pc <= 32'h0000_3000;
        end
        else begin
            pc <= NPC;
        end
    end

endmodule
