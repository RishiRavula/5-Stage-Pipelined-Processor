module controlQuotient(quotientAfterShiftFrom64, quotientRegIn, quotientRegOut, claOut, bootUp, aAfterCheck);
    input [63:0] quotientRegOut;
    input [31:0] aAfterCheck, claOut;
    input bootUp;
    output [63:0] quotientAfterShiftFrom64, quotientRegIn;

    assign quotientAfterShiftFrom64[63:1] = quotientRegOut[62:0];
    assign quotientAfterShiftFrom64[0] = ~claOut[31];
    assign quotientRegIn[63:32] = bootUp ? 32'b00000000000000000000000000000000 : claOut;
    assign quotientRegIn[31:0] = bootUp ? aAfterCheck : quotientAfterShiftFrom64[31:0];


endmodule