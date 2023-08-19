module tffe_ref(q, d, clk, en, clr);
    input d, clk, en, clr;
    output q;
    wire qOut;
    wire w0;
    assign w0 = ~d & qOut;
    wire w1;
    assign w1 = ~qOut & d;
    wire w2;
    assign w2 = w0 | w1;
    dffe_ref dff(.q(qOut), .d(w2), .clk(clk), .en(1'b1), .clr(clr));
    assign q = qOut;
endmodule