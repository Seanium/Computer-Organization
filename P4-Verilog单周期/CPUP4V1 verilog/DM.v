`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:43 10/26/2022 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input [31:0] A,
    input WE,
    input [31:0] WD,
    input [31:0] pc,    //相应指令的储存地址 用于测评
    output [31:0] RD
    );
    reg [31:0] dm[3071:0];
    wire [13:2] Areal;
    assign Areal = A[13:2];
    assign RD = dm[Areal];
    
    integer i;
    always @(posedge clk) begin
        if(reset) begin
            for(i=0; i<=3071; i=i+1)
                dm[i] <= 32'h0000_0000;
        end
        else if(WE) begin
            dm[Areal] <= WD;
            $display("@%h: *%h <= %h", pc, A, WD);
        end
    end

endmodule
