`timescale 1ns / 1ps
`include "const.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:10:40 11/06/2022 
// Design Name: 
// Module Name:    SU 
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
module SU(
    input [31:0] D_instr,
    input [31:0] E_instr,
    input [31:0] M_instr,
    output stall
    );
    wire [4:0] D_rs;
    wire [4:0] D_rt;
    wire [4:0] D_type;

    wire [4:0] E_type;
    wire [4:0] E_GRFA3;

    wire [4:0] M_type;
    wire [4:0] M_GRFA3;

    CU D (
        .instr(D_instr), 
        .rs(D_rs), 
        .rt(D_rt), 
        .type(D_type)
        );
    CU E (
        .instr(E_instr), 
        .type(E_type),
        .GRFA3(E_GRFA3)
        );
    CU M (
        .instr(M_instr), 
        .type(M_type),
        .GRFA3(M_GRFA3)
        );
        
    wire [1:0] rs_tuse = 
        (D_type==`beq | D_type==`jr)? 2'b00:
        (D_type==`calr | D_type==`cali | D_type==`load | D_type==`store)? 2'b01:
        2'b11;  //其他情况tuse设为最大值3

    wire [1:0] rt_tuse = 
        (D_type==`beq)? 2'b00:
        (D_type==`calr)? 2'b01:
        (D_type==`store)? 2'b10:
        2'b11;  //其他情况tuse设为最大值3
    
    wire [1:0] E_tnew = 
        (E_type==`calr | E_type==`cali)? 2'b01:
        (E_type==`load)? 2'b10:
        2'b00;  //其他情况tnew设为最小值0

    wire [1:0] M_tnew = 
        (M_type==`load)? 2'b01:
         2'b00;  //其他情况tnew设为最小值0

    wire E_stall_rs = (E_tnew > rs_tuse) && D_rs && (D_rs == E_GRFA3);
    wire M_stall_rs = (M_tnew > rs_tuse) && D_rs && (D_rs == M_GRFA3);
    wire E_stall_rt = (E_tnew > rt_tuse) && D_rt && (D_rt == E_GRFA3);
    wire M_stall_rt = (M_tnew > rt_tuse) && D_rt && (D_rt == M_GRFA3);

    wire stall_rs = E_stall_rs | M_stall_rs;
    wire stall_rt = E_stall_rt | M_stall_rt;

    assign stall = stall_rs | stall_rt;

endmodule
