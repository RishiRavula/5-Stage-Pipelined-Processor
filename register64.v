module register64(out, in, clk, reset);
    input [63:0] in;
    input clk, reset;
    output [63:0] out;

    register32 reg32_1 (out[31:0], in[31:0], clk, 1'b1, reset);
    register32 reg32_2 (out[63:32], in[63:32], clk, 1'b1, reset);

    
endmodule
