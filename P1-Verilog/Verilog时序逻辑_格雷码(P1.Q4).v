`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:54:46 10/05/2022 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );
    reg [2:0] OutputReg;
    reg OverflowReg;
    assign Output = OutputReg;
    assign Overflow = OverflowReg;
	always @(posedge Clk) begin
        if(Reset) begin
            OutputReg <= 0;
            OverflowReg <= 0;
        end
        else begin
            if(En == 1) begin
                case(OutputReg)
                    3'b000: OutputReg<=3'b001;
                    3'b001: OutputReg<=3'b011;
                    3'b011: OutputReg<=3'b010;
                    3'b010: OutputReg<=3'b110;
                    3'b110: OutputReg<=3'b111;
                    3'b111: OutputReg<=3'b101;
                    3'b101: OutputReg<=3'b100;
                    3'b100: begin
                        OutputReg<=3'b000;
                        OverflowReg<=1;
                    end
                endcase
            end
        end
	end
endmodule
