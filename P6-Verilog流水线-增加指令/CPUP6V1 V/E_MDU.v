`timescale 1ns / 1ps
`include "const.v"

module E_MDU(
    input clk,
    input reset,
    input [4:0] MDUType,
    input [31:0] A,
    input [31:0] B,
    output [31:0] MDUO,
    output start,
    output busy
    );
    reg [31:0] hi, lo, hi_temp, lo_temp;
    reg [4:0] cnt;

    assign MDUO = 
        (MDUType==`MDUType_mfhi)? hi:
        (MDUType==`MDUType_mflo)? lo:
        32'd0;  //默认输出0

    always @(posedge clk) begin
        if(reset) begin
            hi <= 32'd0;
            lo <= 32'd0;
            hi_temp <= 32'd0;
            lo_temp <= 32'd0;
            cnt <= 5'd0;
        end
        else begin
            if(cnt==4'd0) begin
                if(MDUType==`MDUType_mthi) begin
                    hi <= A;
                end
                else if(MDUType==`MDUType_mtlo) begin
                    lo <= A;
                end
                else if(MDUType==`MDUType_mult) begin
                    {hi_temp, lo_temp} <= $signed(A) * $signed(B);
                    cnt <= 5'd5;
                end
                else if(MDUType==`MDUType_multu) begin
                    {hi_temp, lo_temp} <= A * B;
                    cnt <= 5'd5;
                end
                else if(MDUType==`MDUType_div) begin
                    lo_temp <= $signed(A) / $signed(B);
                    hi_temp <= $signed(A) % $signed(B);
                    cnt <= 5'd10;
                end
                else if(MDUType==`MDUType_divu) begin
                    lo_temp <= A / B;
                    hi_temp <= A % B;
                    cnt <= 5'd10;
                end
            end
            else begin
                cnt <= cnt - 1;
                if(cnt==5'd1) begin
                    hi <= hi_temp;
                    lo <= lo_temp;
                end
            end
        end
    end

    assign start = (MDUType==`MDUType_mult | MDUType==`MDUType_multu |
                    MDUType==`MDUType_div | MDUType==`MDUType_divu);
    assign busy = ($signed(cnt) > 4'd0);
    
endmodule