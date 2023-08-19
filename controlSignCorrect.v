module controlSignCorrect(out,a,b,quotientAfterShiftFrom64);
    output [31:0] out;
    
    input [31:0] a,b;
    input [63:0] quotientAfterShiftFrom64;
    
    wire [31:0] negationOfQuotient;
    wire doNegationOrNot;

    cla_32 outNegation(.S(negationOfQuotient), .A(~quotientAfterShiftFrom64[31:0]), .B(32'b00000000000000000000000000000000), .Cin(1'b1));

    assign doNegationOrNot = a[31] ^ b[31];
    assign out = doNegationOrNot ? negationOfQuotient : quotientAfterShiftFrom64[31:0];

endmodule