//指令分类小类
`define calr 5'd0
`define cali 5'd1
`define lui 5'd2
`define load 5'd3
`define store 5'd4
`define branch 5'd5
`define jal 5'd6
`define jr 5'd7
`define mf 5'd8
`define mt 5'd9
`define md 5'd10

//GRFWDSrc
`define GRFWDSrc_AO 5'd0
`define GRFWDSrc_RD 5'd1
`define GRFWDSrc_EXT32 5'd2
`define GRFWDSrc_pc8 5'd3
`define GRFWDSrc_MDUO 5'd4

//MDUType
//读hilo
`define MDUType_mfhi 5'd0
`define MDUType_mflo 5'd1
//写hilo
`define MDUType_mthi 5'd2
`define MDUType_mtlo 5'd3
`define MDUType_mult 5'd4
`define MDUType_multu 5'd5
`define MDUType_div 5'd6
`define MDUType_divu 5'd7

//DMWDType
`define DMWDType_sw 5'd0
`define DMWDType_sh 5'd1
`define DMWDType_sb 5'd2