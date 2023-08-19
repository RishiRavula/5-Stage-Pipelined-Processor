module productRegister(productOut,nothing,productFrom65AfterShift,claOut,ctrl_MULT,clk,a);
    input [64:0] productFrom65AfterShift;
    input [31:0] claOut,a;
    input nothing,clk,ctrl_MULT;
    output [64:0] productOut;

    wire [31:0] upperHalf;
    wire [64:0] productIn;
    
    assign upperHalf = nothing ? productFrom65AfterShift[64:33] : claOut;
    assign productIn[64:33] = ctrl_MULT ? 32'b00000000000000000000000000000000 : upperHalf;
    assign productIn[32:1] = ctrl_MULT ? a : productFrom65AfterShift[32:1];
    assign productIn[0] = ctrl_MULT ? 1'b0 : productFrom65AfterShift[0];
    register65 productRegister(.out(productOut), .in(productIn), .clk(clk), .reset(1'b0));
endmodule