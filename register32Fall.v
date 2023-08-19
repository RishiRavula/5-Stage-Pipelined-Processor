module register32Fall(out, in, clk, en, reset);
    input [31:0] in;
    input clk, en, reset, oe;
    output [31:0] out;

    dffe_fall reg32[31:0] (out, in, clk, en, reset);
endmodule