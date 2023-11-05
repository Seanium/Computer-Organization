`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:26 11/05/2022 
// Design Name: 
// Module Name:    E_ALU 
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
module E_ALU(
    input [4:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    output [31:0] AO
    );
    
    function [31:0] cmco;
        input [31:0] b;
        reg [31:0] temp;
        reg [31:0] count;
        integer i;
        begin
            i=0;
            temp=0;
            count=0;
            cmco=0;
            for(i=0;i<=31;i=i+1) begin
                if(b[i]==1) begin
                    count = count+1;
                    if(count>temp) begin
                        temp=count;
                    end
                end
                else begin
                    count=0;
                end
            end
            cmco=temp;
        end
    endfunction
    
    assign AO = (ALUOp==5'd0)? (A&B):
                (ALUOp==5'd1)? (A|B):
                (ALUOp==5'd2)? (A+B):
                (ALUOp==5'd3)? (A-B):
                (ALUOp==5'd5)? cmco(B):
                32'h0000_0000;

endmodule
