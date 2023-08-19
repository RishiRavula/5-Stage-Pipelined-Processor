module regBypass(jumpRetIn, rdFD, rdSpecialCaseDX, rdSpecialCaseMW, rdSpecialCaseXM, jIIFD, bexFD, irOutputDX, irOutputMW, irOutputXM, weDX, weXM, ctrl_writeReg, data_writeReg, data_readRegA, aluDXOutput, oOutputXM);
    input [31:0] aluDXOutput, oOutputXM;
    input [4:0] rdFD, rdSpecialCaseDX, rdSpecialCaseMW, rdSpecialCaseXM,ctrl_writeReg;
    input jIIFD, bexFD, weDX, weXM;
    input [31:0] irOutputDX, irOutputMW, irOutputXM, data_writeReg, data_readRegA;
    output [31:0] jumpRetIn;

    wire jBypassFD, jBypassMD, jBypassWD;
    assign jBypassFD = irOutputDX != 32'b00000000000000000000000000000000 && weDX && ((rdSpecialCaseDX == rdFD && jIIFD) || (rdSpecialCaseDX == 5'b11110 && bexFD));
    assign jBypassMD = irOutputXM != 32'b00000000000000000000000000000000 && weXM && ((rdSpecialCaseXM == rdFD && jIIFD) || (rdSpecialCaseXM == 5'b11110 && bexFD));
    assign jBypassWD = irOutputMW != 32'b00000000000000000000000000000000 && ctrl_writeReg && ((rdSpecialCaseMW == rdFD && jIIFD) || (rdSpecialCaseMW == 5'b11110 && bexFD));
    assign jumpRetIn = jBypassFD ? aluDXOutput : jBypassMD ? oOutputXM : jBypassWD ? data_writeReg : data_readRegA;
endmodule;