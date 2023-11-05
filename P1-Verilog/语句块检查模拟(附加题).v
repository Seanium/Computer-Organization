`timescale 1ns / 1ps
module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );

    reg [31:0] cnt;
    reg [3:0] state;
    reg error;
    wire isB;
    wire isE;
    wire isG;
    wire isI;
    wire isN;
    wire isD;
    wire isSpace;
    assign isB = (in=="b" || in=="B");
    assign isE = (in=="e" || in=="E");
    assign isG = (in=="g" || in=="G");
    assign isI = (in=="i" || in=="I");
    assign isN = (in=="n" || in=="N");
    assign isD = (in=="d" || in=="D");
    assign isSpace = (in==" ");

    always @(posedge clk, posedge reset) begin
        if(reset) begin
            cnt <= 0;
            state <= 0;
            error <= 0;
        end
        else begin
            case(state)
            0: state <= isB? 2: isE? 7: isSpace? 0: 1;
            1: state <= isSpace? 0: 1;
            2: state <= isE? 3: isSpace? 0: 1;
            3: state <= isG? 4: isSpace? 0: 1;
            4: state <= isI? 5: isSpace? 0: 1;
            5: begin
                if(isN) begin
                    state <= 6;
                    cnt <= cnt + 1;
                end
                else if(isSpace) state <= 0;
                else state <= 1;
            end
            6: begin
                if(isSpace) state <= 0;
                else begin
                    state <= 1;
                    cnt <= cnt - 1;
                end
            end
            7: state <= isN? 8: isSpace? 0: 1;
            8: begin
                if(isD) begin
                    state <= 9;
                    cnt <= cnt - 1;
                end
                else if(isSpace) state <= 0;
                else state <= 1;
            end
            9: begin
                if(isSpace) begin
                    state <= 0;
                    if($signed(cnt)<0) error <= 1;
                end
                else begin
                    state <= 1;
                    cnt <= cnt + 1;
                end
            end
            endcase
        end
    end
    
    assign result = (cnt==0 && error==0);

endmodule
