`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:15 10/05/2022 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );
    parameter s0=0, s1=1, s2=2, s3=3, s4=4;
    reg [2:0] state, next;
    
    wire isNum;
    wire isOp;
    assign isNum = (in>="0" && in <="9");
    assign isOp = (in=="+" || in == "*");
    
    initial begin
        state = 0;
        next = 0;
    end
    
    always @(*) begin
        case(state)
            s0: next = isNum? s1: isOp? s4: s4;
            s1: next = isNum? s4: isOp? s2: s4;
            s2: next = isNum? s3: isOp? s4: s4;
            s3: next = isNum? s4: isOp? s2: s4;
            s4: next = s4;
        endcase
    end
    
    always @(posedge clk, posedge clr) begin
        if (clr) state <= s0;
        else state <= next;
    end
    
    assign out = (state == s1 || state == s3);
    
endmodule
