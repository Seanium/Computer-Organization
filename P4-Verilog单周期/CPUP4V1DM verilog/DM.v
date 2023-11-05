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
    input [2:0] DMType, //new
    output [31:0] RD
    );
    reg [31:0] dm[3071:0];
    
    wire [13:2] Areal = A[13:2];
    wire [31:0] lw = dm[Areal];
    
    /////////////////////////////
    //备用部分
    //lh lhu
    //wire [15:0] half = (A[1]==1'b0)? lw[15:0]:
    //                    (A[1]==1'b1)? lw[31:16]:
    //                    lw[15:0];
    //wire [31:0] lh = {{16{byte_[15]}}, half};
    //wire [31:0] lhu = {16'h0000, half};

    //lb, lbu
    //wire [7:0] byte_ = (A[1:0]==2'b00)? lw[7:0]:
    //                    (A[1:0]==2'b01)? lw[15:8]:
    //                    (A[1:0]==2'b10)? lw[23:16]:
    //                    (A[1:0]==2'b11)? lw[31:24]:
    //                    lw[7:0];
    //wire [31:0] lb = {{24{byte_[7]}}, byte_};
    //wire [31:0] lbu = {{24{1'b0}}, half};
    
    //lwrr
    //wire temp = A[1:0];
    //wire [31:0] lwrr = (lw<<(32-8*temp))|(lw>>(8*temp));
    
    //swrr
    //wire temp = A[1:0];
    //wire [31:0] swrr = (WD<<(32-8*temp))|(WD>>(8*temp));
    /////////////////////////////
    
    assign RD = (DMType==3'd0)? lw:
                lw;
    integer i;
    always @(posedge clk) begin
        if(reset) begin
            for(i=0; i<=3071; i=i+1)
                dm[i] <= 32'h0000_0000;
        end
        else if(WE) begin
            if(DMType==3'd0) begin
                dm[Areal] <= WD;
            end
            else begin
                dm[Areal] <= WD;
            end
            $display("@%h: *%h <= %h", pc, A, WD);
        end
    end

endmodule
