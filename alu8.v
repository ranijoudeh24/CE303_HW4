`timescale 1ns/1ps

module alu8(
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] F,
    output [7:0] Q,
    output       Cout
);
    reg  [8:0] res9;
    reg  [7:0] q_r;
    reg        c_r;

    assign Q    = q_r;
    assign Cout = c_r;

    always @(*) begin
        res9 = 9'd0;
        q_r  = 8'd0;
        c_r  = 1'b0;

        case(F)
            3'b000: begin
                res9 = {1'b0,a} + {1'b0,b};
                q_r  = res9[7:0];
                c_r  = res9[8];
            end
            3'b001: begin
                res9 = {1'b0,a} - {1'b0,b};
                q_r  = res9[7:0];
                c_r  = (a < b);
            end
            3'b010: begin q_r = a | b; end
            3'b011: begin q_r = a & b; end
            3'b100: begin q_r = a ^ b; end
            3'b101: begin q_r = ~a; end
            3'b110: begin
                res9 = {1'b0,a} << 1;
                q_r  = res9[7:0];
                c_r  = res9[8];
            end
            3'b111: begin
                q_r = {a[7], a[7:1]};
            end
        endcase
    end
endmodule
