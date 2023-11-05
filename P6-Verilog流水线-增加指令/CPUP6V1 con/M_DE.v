`timescale 1ns / 1ps

module M_DE(
    input [31:0] DEI,
    input [4:0] DEOp,
    input [1:0] Aoffset,
    output [31:0] DEO
    );

    wire [31:0] lw = DEI;

    wire [15:0] half = 
        (Aoffset[1]==1'b0)? DEI[15:0]:
        (Aoffset[1]==1'b1)? DEI[31:16]:
        16'd0;
    wire [31:0] lh = {{16{half[15]}}, half};

    wire [7:0] byte = 
        (Aoffset==2'b00)? DEI[7:0]:
        (Aoffset==2'b01)? DEI[15:8]:
        (Aoffset==2'b10)? DEI[23:16]:
        (Aoffset==2'b11)? DEI[31:24]:
        8'd0;
    wire [31:0] lb = {{24{byte[7]}}, byte};

    assign DEO = 
        (DEOp==4'd0)? lw:
        (DEOp==4'd1)? lh:
        (DEOp==4'd2)? lb:
        32'd0;
endmodule