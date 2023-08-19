module branchModule (isBranch, addrBranch, signExtendedImm, pcOutputDX, iNE, bNEDX, iLT, bLTDX);

 //LETS BRANCH
    input [31:0] signExtendedImm, pcOutputDX;
    input iNE, bNEDX, iLT, bLTDX;
    output [31:0] addrBranch;
    output isBranch;
    
    cla_32 branchCLA(.S(addrBranch), .A(pcOutputDX), .B(signExtendedImm), .Cin(1'b0));
    assign isBranch = (bLTDX && iLT) || (bNEDX && iNE);
    
endmodule