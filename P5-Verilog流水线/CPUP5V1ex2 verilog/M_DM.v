`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:51 11/05/2022 
// Design Name: 
// Module Name:    M_DM 
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
module M_DM(
    input [31:0] wpc,
    input clk,
    input reset,
    input WE,
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD,
    output lwso_con
    );
    
    reg [31:0] dm[3071:0];
    
    wire [13:2] Areal;
    assign Areal = A[13:2];
    
    wire [32:0] temp = {WD[31], WD} + {dm[Areal][31], dm[Areal]};
    assign lwso_con = temp[32]==temp[31];
    
    assign RD = lwso_con? (WD+dm[Areal]): dm[Areal];
    
    integer i;
    always @(posedge clk) begin
        if(reset) begin
            for(i=0; i<=3071; i=i+1)
                dm[i] <= 32'h0000_0000;
        end
        else if(WE) begin
            dm[Areal] <= WD;
            $display("%d@%h: *%h <= %h", $time, wpc, A, WD);
            //$display("@%h: *%h <= %h", wpc, A, WD); //调试用
        end
    end
    
endmodule
