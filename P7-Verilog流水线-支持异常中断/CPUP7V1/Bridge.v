`timescale 1ns / 1ps

module Bridge(
    //读写地址
    input [31:0] PrAddr,
    output [31:0] DevAddr,

    //读 input来自外设 output给cpu
    input [31:0] DMRD,
    input [31:0] TC0RD,
    input [31:0] TC1RD,
    output [31:0] PrRD,

    //写 input来自cpu output给外设
    input [31:0] PrWD,
    input [3:0] PrWE,
    output [31:0] DevWD,
    output [3:0] DMWE,
    output TC0WE,
    output TC1WE,
    output [3:0] IRWE
    );
    
    assign DevAddr = PrAddr;

    wire DM_sel = (PrAddr>=32'h0000_0000 && PrAddr<=32'h0000_2fff);
    wire TC0_sel = (PrAddr>=32'h0000_7f00 && PrAddr<=32'h0000_7f0b);
    wire TC1_sel = (PrAddr>=32'h0000_7f10 && PrAddr<=32'h0000_7f1b);
    wire IR_sel = (PrAddr>=32'h0000_7f20 && PrAddr<=32'h0000_7f23);

    assign PrRD =   (DM_sel)? DMRD:
                    (TC0_sel)? TC0RD:
                    (TC1_sel)? TC1RD:
                    0;

    assign DevWD = PrWD;

    assign DMWE = DM_sel? PrWE: 4'b0;
    assign TC0WE = TC0_sel? (|PrWE): 1'b0;
    assign TC1WE = TC1_sel? (|PrWE): 1'b0;
    // assign TC0WE = TC0_sel? (&PrWE): 1'b0;
    // assign TC1WE = TC1_sel? (&PrWE): 1'b0;

    assign IRWE = IR_sel? PrWE: 4'b0;
    // assign IRWE = PrWE;

endmodule