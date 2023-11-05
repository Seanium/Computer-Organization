`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:33 10/26/2022 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] A,
    output [31:0] RD
    );
    reg [31:0] im[4095:0];
    wire [31:0] Asub;
    
    assign Asub = A-32'h0000_3000;
    assign RD = im[Asub[13:2]];
    
    integer i;
    initial begin
        //先手动复位
        for(i=0; i<4096; i=i+1) begin
            im[i]=32'h0;
        end
        //再从文件读入指令
        $readmemh("code.txt", im);
    end
    
endmodule
