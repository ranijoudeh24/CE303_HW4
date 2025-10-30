// tb_alu8.v -- Testbench for 8-bit ALU
`timescale 1ns/1ps

module tb_alu8;

    reg  [7:0] a, b;
    reg  [2:0] F;
    wire [7:0] Q;
    wire       Cout;

    reg  [8:0] expected;
    reg  [7:0] expected_Q;
    reg        expected_Cout;

    alu8 dut (.a(a), .b(b), .F(F), .Q(Q), .Cout(Cout));

    initial begin
        $dumpfile("tb_alu8.vcd");
        $dumpvars(0, tb_alu8);
    end

    task apply;
        input [7:0] a_in, b_in;
        input [2:0] f_in;
        begin
            a = a_in; b = b_in; F = f_in;

            case(f_in)
                3'b000: begin expected = a_in + b_in; expected_Q=expected[7:0]; expected_Cout=expected[8]; end
                3'b001: begin expected = {1'b0,a_in} - {1'b0,b_in}; expected_Q=expected[7:0]; expected_Cout=(a_in<b_in); end
                3'b010: begin expected_Q = a_in | b_in; expected_Cout = 0; end
                3'b011: begin expected_Q = a_in & b_in; expected_Cout = 0; end
                3'b100: begin expected_Q = a_in ^ b_in; expected_Cout = 0; end
                3'b101: begin expected_Q = ~a_in;       expected_Cout = 0; end
                3'b110: begin expected = {1'b0,a_in}<<1; expected_Q=expected[7:0]; expected_Cout=expected[8]; end
                3'b111: begin expected_Q = {a_in[7],a_in[7:1]}; expected_Cout = 0; end
            endcase

            #1;

            $display("F=%b A=%d B=%d -> Q=%d Cout=%b  | exp Q=%d Cout=%b",
                      F,a,b,Q,Cout,expected_Q,expected_Cout);

            if ((Q !== expected_Q) || (Cout !== expected_Cout)) begin
                $display("ERROR!");
                $stop;
            end
        end
    endtask

    initial begin
        apply(250,   6, 3'b000);
        apply(3,     7, 3'b001);
        apply(181,  77, 3'b010);
        apply(181,  77, 3'b011);
        apply(181,  77, 3'b100);
        apply(181,   0, 3'b101);
        apply(200,   0, 3'b110);
        apply(200,   0, 3'b111);

        $display("ALL TESTS PASSED");
        $finish;
    end
endmodule
