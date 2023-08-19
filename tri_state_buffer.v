module tri_state_buffer(out, in, oe);
    input [31:0] in;
    input oe;
    output [31:0] out;
    assign out = oe? in : 32'bz;
endmodule