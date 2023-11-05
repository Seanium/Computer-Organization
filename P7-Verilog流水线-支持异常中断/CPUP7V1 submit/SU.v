`timescale 1ns / 1ps
`include "const.v"

module SU(
    input [31:0] D_instr,
    input [31:0] E_instr,
    input [31:0] M_instr,
    input E_MDUstart,
    input E_MDUbusy,
    output stall
    );
    wire [4:0] D_rs;
    wire [4:0] D_rt;
    wire [4:0] D_type;
    wire D_eret;

    wire [4:0] E_type;
    wire [4:0] E_GRFA3;
    wire [4:0] E_rd;

    wire [4:0] M_type;
    wire [4:0] M_GRFA3;
    wire [4:0] M_rd;

    CU D (
        .instr(D_instr), 
        .rs(D_rs), 
        .rt(D_rt), 
        .type(D_type),
        .eret(D_eret)
        );
    CU E (
        .instr(E_instr), 
        .type(E_type),
        .GRFA3(E_GRFA3),
        .rd(E_rd)
        );
    CU M (
        .instr(M_instr), 
        .type(M_type),
        .GRFA3(M_GRFA3),
        .rd(M_rd)
        );
        
    wire [1:0] rs_tuse = 
        (D_type==`branch | D_type==`jr)? 2'b00:
        (D_type==`calr | D_type==`cali | D_type==`load | D_type==`store |
        D_type==`mt | D_type==`md)? 2'b01:
        2'b11;  //其他情况tuse设为最大值3

    wire [1:0] rt_tuse = 
        (D_type==`branch)? 2'b00:
        (D_type==`calr| D_type==`md)? 2'b01:
        (D_type==`store | D_type==`mtc0)? 2'b10:
        2'b11;  //其他情况tuse设为最大值3
    
    wire [1:0] E_tnew = 
        (E_type==`calr | E_type==`cali | E_type==`mf)? 2'b01:
        (E_type==`load | E_type==`mfc0)? 2'b10:
        2'b00;  //其他情况tnew设为最小值0

    wire [1:0] M_tnew = 
        (M_type==`load | M_type==`mfc0)? 2'b01:
         2'b00;  //其他情况tnew设为最小值0

    wire E_stall_rs = (E_tnew > rs_tuse) && D_rs && (D_rs == E_GRFA3);
    wire M_stall_rs = (M_tnew > rs_tuse) && D_rs && (D_rs == M_GRFA3);
    wire E_stall_rt = (E_tnew > rt_tuse) && D_rt && (D_rt == E_GRFA3);
    wire M_stall_rt = (M_tnew > rt_tuse) && D_rt && (D_rt == M_GRFA3);

    wire stall_rs = E_stall_rs | M_stall_rs;
    wire stall_rt = E_stall_rt | M_stall_rt;

    wire stall_MDU = (E_MDUstart | E_MDUbusy) & 
        (D_type==`mf | D_type==`mt | D_type==`md);

    wire stall_eret = D_eret &&
        ((E_type==`mtc0 && E_rd==5'd14) || 
         (M_type==`mtc0 && M_rd==5'd14));

    assign stall = stall_rs | stall_rt | stall_MDU |stall_eret;

endmodule
