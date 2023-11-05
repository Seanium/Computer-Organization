`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:40:55 10/26/2022 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input reset,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input WE,
    input [31:0] pc,    //相应指令的储存地址 用于测评
    output [31:0] RD1,
    output [31:0] RD2
    );
    reg [31:0] rf[31:0];
    
    assign RD1 = rf[A1];
    assign RD2 = rf[A2];
    
    integer i;
    always @(posedge clk) begin
        if(reset) begin
            for(i=0; i<=31; i=i+1)
                rf[i] <= 32'h0000_0000;
        end
        else if(WE && A3!=0) begin
            rf[A3] <= WD;
            $display("@%h: $%d <= %h", pc, A3, WD);
            
        end
    end
endmodule
