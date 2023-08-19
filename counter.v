module counter(out, clk, reset);
    input clk, reset;
    output [5:0] out;
    wire w0, w1, w2, w3;
    tffe_ref first(.q(out[0]), .d(1'b1), .clk(clk), .en(1'b1), .clr(reset));
    tffe_ref second(.q(out[1]), .d(out[0]), .clk(clk), .en(1'b1), .clr(reset));
    assign w0 = out[1] & out[0];
    tffe_ref third(.q(out[2]), .d(w0), .clk(clk), .en(1'b1), .clr(reset));
    assign w1 = w0 & out[2];
    tffe_ref fourth(.q(out[3]), .d(w1), .clk(clk), .en(1'b1), .clr(reset));
    assign w2 = w1 & out[3];
    tffe_ref fifth(.q(out[4]), .d(w2), .clk(clk), .en(1'b1), .clr(reset));
    assign w3 = w2 & out[4];
    tffe_ref sixth(.q(out[5]), .d(w3), .clk(clk), .en(1'b1), .clr(reset));
    
endmodule