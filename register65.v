module register65(out, in, clk, reset);
    input [64:0] in;
    input clk, reset;
    output [64:0] out;

    dffe_ref  dff(.q(out[0]), .d(in[0]), .clk(clk), .en(1'b1), .clr(reset));
    register32 reg32_1 (out[32:1], in[32:1], clk, 1'b1, reset);
    register32 reg32_2 (out[64:33], in[64:33], clk, 1'b1, reset);
endmodule
