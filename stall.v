module stallModule (irInputDX, stall, activeMultOrDiv, multDX, divDX, lwDX, rTypeFD, rsFD, rtFD, rdFD, rdDX, weFD, irOutputFD, rdSpecialCaseFD, isBranch);
    output stall;
    output [31:0] irInputDX;
    input activeMultOrDiv, multDX, divDX, lwDX, rTypeFD,  weFD, isBranch;
    input [4:0] rsFD, rtFD, rdFD, rdSpecialCaseFD, rdDX;
    input [31:0] irOutputFD;
    wire stallMD;
    //TODO: ACTIVE MULT/DIV NOT MADE YET
    assign stallMD =  activeMultOrDiv || (multDX || divDX) || (lwDX && ((rsFD == rdDX) || (rtFD == rdDX) && rTypeFD));
    assign stall = stallMD ||  (lwDX && ((rsFD == rdDX) || (rtFD == rdDX) && rTypeFD)) ;
    assign irInputDX = stall || isBranch || (weFD && rdSpecialCaseFD == 5'b00000) ? 32'b00000000000000000000000000000000 : irOutputFD;
endmodule