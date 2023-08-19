/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */

    //Program Counter - Begin
    wire [31:0] pcOutput, nextPC;
    wire [31:0] pcInput;
    assign pcInput = actualNextPC;
    register32Fall pc(.out(pcOutput), .in(pcInput), .clk(clock), .en(~stall), .reset(reset));
    cla_32 pcPlusOne(.S(nextPC), .A(pcOutput), .B(32'b00000000000000000000000000000001), .Cin(1'b0));
    assign address_imem = pcOutput;
    

    //F-D Stage
    wire [31:0] pcOutputFD, pcInputFD, irInputFD, irOutputFD, instructionFD;
    wire [4:0] rtFD, rdFD, rsFD, rdSpecialCaseFD;
    wire swFD, rTypeFD, jIIFD, branchFD, weFD, bexFD, jFD, jrFD, jalFD;
    assign pcInputFD = nextPC;
    
    register32Fall pcFD(.out(pcOutputFD), .in(pcInputFD), .clk(clock), .en(1'b1), .reset(reset));
    register32Fall irFD(.out(irOutputFD), .in(irInputFD), .clk(clock), .en(~stall), .reset(reset));
    assign instructionFD = irOutputFD;
    instruction checkInstructionFD(.instruction(instructionFD), .rType(rTypeFD), .jIIType(jIIFD), .branch(branchFD), .sw(swFD), .we(weFD), .bex(bexFD), .j(jFD), .jal(jalFD), .jr(jrFD), .rs(rsFD), .rt(rtFD), .rd(rdFD), .rdSpecialCase(rdSpecialCaseFD));
    
    assign ctrl_readRegA = (bexFD || jIIFD || branchFD) ? rdFD : rsFD;
    assign ctrl_readRegB = branchFD ? rsFD : swFD ? rdFD : rtFD;
    

    //D-X Stage
    wire [31:0] pcOutputDX, pcInputDX, irOutputDX, irInputDX, aOutputDX, aInputDX, bOutputDX, bInputDX, instructionDX, aluInA, aluInB, signExtendedImm, aluDXOutput;
    wire [4:0] rsDX, rtDX, rdDX, rdSpecialCaseDX, aluDXOpCode, aluDXshamt;
    wire iTypeDX, rTypeDX, lwDX, weDX, branchDX, multDX, divDX, jalDX, bNEDX, bLTDX, iNE, iLT, iOV;
    assign pcInputDX = pcOutputFD;
    assign aInputDX = data_readRegA;

    register32Fall pcDX(.out(pcOutputDX), .in(pcInputDX), .clk(clock), .en(1'b1), .reset(reset));
    register32Fall irDX(.out(irOutputDX), .in(irInputDX), .clk(clock), .en(1'b1), .reset(reset));
    register32Fall aDX(.out(aOutputDX), .in(aInputDX), .clk(clock), .en(1'b1), .reset(reset));
    register32Fall bDX(.out(bOutputDX), .in(bInputDX), .clk(clock), .en(1'b1), .reset(reset));


    assign instructionDX = irOutputDX;
    instruction checkInstructionDX(.instruction(instructionDX), .iType(iTypeDX), .rType(rTypeDX), .lw(lwDX), .we(weDX), .branch(branchDX), .jal(jalDX), .mult(multDX), .div(divDX), .rs(rsDX), .rt(rtDX), .rd(rdDX), .rdSpecialCase(rdSpecialCaseDX), .bNE(bNEDX), .bLT(bLTDX));
    assign signExtendedImm = {{15{irOutputDX[16]}}, irOutputDX[16:0]};
    assign aluDXOpCode = branchDX ? 5'b00001 : ~rTypeDX ? 5'b00000 : instructionDX[6:2];
    assign aluDXshamt = irOutputDX[11:7];
    assign aluInA = aBypassMX ? oOutputXM : aBypassWX ? data_writeReg : aOutputDX;
    assign aluInB = (iTypeDX && ~branchDX) ? signExtendedImm : bBypassMX ? oOutputXM : bBypassWX ? data_writeReg : bOutputDX;
    alu ALU(.data_operandA(aluInA), .data_operandB(aluInB), .ctrl_ALUopcode(aluDXOpCode), .ctrl_shiftamt(aluDXshamt), .data_result(aluDXOutput), .isNotEqual(iNE), .isLessThan(iLT), .overflow(iOV));


    //INSERTING MULT DIV HERE
    wire [31:0] multDivOut; 
    wire activeMultOrDiv, dataResultReady, dataException;
    wire mult_exception, div_exception;

    multdiv multDivLogic(.data_operandA(aluInA), .data_operandB(aluInB), .ctrl_MULT(multDX), .ctrl_DIV(divDX), .clock(clock), .data_result(multDivOut), .data_exception(dataException), .data_resultRDY(dataResultReady), .mult_exception1(mult_exception), .div_exception1(div_exception));
    dffe_fall activeMultOrDivFF(.q(activeMultOrDiv), .d(1'b1), .clk(clock), .en((multDX || divDX)), .clr((dataResultReady || reset)));
    dffe_fall activeDiv (.q(divLatch), .d(1'b1), .clk(clock), .en(divDX), .clr((dataResultReady || reset)));

    //P/W REGISTER BYPASS SECTION
    wire [31:0] irOutputPW, irInputPW;
    assign irInputPW = irOutputDX;
    register32Fall irPW(.out(irOutputPW), .in(irInputPW), .clk(clock), .en(~activeMultOrDiv), .reset(reset));


    //X-M Stage
    wire[31:0] oOutputXM, oInputXM, bOutputXM, bInputXM, irInputXM, irOutputXM, instructionXM;
    wire [4:0] rdXM, rdSpecialCaseXM;
    wire swXM, weXM,rTypeXM, iTypeXM;
    wire divLatch;
    wire multInstructionXM, divInstructionXM, subInstructionXM, addInstructionXM, addiInstructionXM;
    assign multInstructionXM = rTypeDX && instructionDX[6:2] == 5'b00110 ? 1'b1 : 1'b0;
    assign divInstructionXM = rTypeDX && instructionDX[6:2] == 5'b00111 ? 1'b1 : 1'b0;
    assign addInstructionXM = rTypeDX && instructionDX[6:2] == 5'b00000 ? 1'b1 : 1'b0;
    assign subInstructionXM = rTypeDX && instructionDX[6:2] == 5'b00001 ? 1'b1 : 1'b0;
    assign addiInstructionXM = iTypeDX && instructionDX[31:27] == 5'b00101 ? 1'b1 : 1'b0;
    
    //rstatus for:
    //Sub = 3
    //Mult = 4
    //Div = 5
    //Add = 1
    //Addi = 2
    assign oInputXM = jalDX ? pcOutputDX :  (iOV && subInstructionXM) ? 32'b00000000000000000000000000000011 : (iOV && addiInstructionXM) ? 32'b00000000000000000000000000000010 : (iOV && addInstructionXM) ? 32'b00000000000000000000000000000001 : (divLatch && dataException) ? 32'b00000000000000000000000000000101 : (dataResultReady && dataException) ? 32'b00000000000000000000000000000100 :  aluDXOutput;
    assign bInputXM = bOutputDX;
    //How do i detect sub exception?
    //TO DETECT A MULT EXCEPTION = dataException = rstatus = 4
    //DIV IS DIFF THO, ITS dataException && div_exception = rstatus = 5
    //How do i store the rstatus in register31? 
    assign irInputXM = (iOV || dataException) ? {irOutputDX[31:27], 5'b11110, irOutputDX[21:0]} : (activeMultOrDiv) ? 32'b00000000000000000000000000000000 : irOutputDX;

    register32Fall oXM(.out(oOutputXM), .in(oInputXM), .clk(clock), .en(1'b1), .reset(reset));
    register32Fall bXM(.out(bOutputXM), .in(bInputXM), .clk(clock), .en(1'b1), .reset(reset));
    register32Fall irXM(.out(irOutputXM), .in(irInputXM), .clk(clock), .en(1'b1), .reset(reset));

    assign instructionXM = irOutputXM;
    instruction checkInstructionXM(.instruction(instructionXM), .sw(swXM), .we(weXM), .rd(rdXM), .rdSpecialCase(rdSpecialCaseXM), .rType(rTypeXM), .iType(iTypeXM));
    assign address_dmem = oOutputXM;
    assign wren = swXM;


    //M-W Stage
    wire [31:0] oOutputMW, oInputMW, irInputMW, irOutputMW, dOutputMW, dInputMW, instructionMW;
    wire [4:0] rdMW, rdSpecialCaseMW;
    wire lwMW;
    assign oInputMW = oOutputXM;
    assign dInputMW = q_dmem;
    assign irInputMW = irOutputXM;

    register32Fall oMW(.out(oOutputMW), .in(oInputMW), .clk(clock), .en(1'b1), .reset(reset));
    register32Fall dMW(.out(dOutputMW), .in(dInputMW), .clk(clock), .en(1'b1), .reset(reset));
    register32Fall irMW(.out(irOutputMW), .in(irInputMW), .clk(clock), .en(1'b1), .reset(reset));

    assign instructionMW = irOutputMW;
    instruction checkInstructionMW(.instruction(instructionMW), .lw(lwMW), .rd(rdMW), .we(ctrl_writeEnable), .rdSpecialCase(rdSpecialCaseMW));
    assign data_writeReg = lwMW ? dOutputMW : dataResultReady && ~dataException ? multDivOut : oOutputMW;
    assign ctrl_writeReg = dataResultReady ? irOutputPW[26:22] : rdSpecialCaseMW;

    //Jumping
    wire [31:0] addrJump, actualNextPC;
    wire isJump, isSetX;
    assign isSetX = (q_imem[31:27] == 5'b10101);
    assign isJump = jFD || jrFD || (bexFD != 32'b00000000000000000000000000000000 && jumpRetIn != 32'b00000000000000000000000000000000);
    assign addrJump = jrFD ? jumpRetIn : {5'b00000, irOutputFD[26:0]};
    assign actualNextPC = isBranch ? addrBranch : isJump ? addrJump : nextPC;
    assign irInputFD = isBranch || isJump ? 32'b00000000000000000000000000000000 : isSetX ? {15'b001011111000000, q_imem[16:0]} : q_imem; // manual setting of irInputFD to 0 if branch or jump

    //Aside: Register Jumping 
    wire [31:0] jumpRetIn;
    regBypass registerJumpBypass(.jumpRetIn(jumpRetIn), .rdFD(rdFD), .rdSpecialCaseDX(rdSpecialCaseDX), .rdSpecialCaseMW(rdSpecialCaseMW), .rdSpecialCaseXM(rdSpecialCaseXM), .jIIFD(jIIFD), .bexFD(bexFD), .irOutputDX(irOutputDX), .irOutputMW(irOutputMW), .irOutputXM(irOutputXM), .weDX(weDX), .weXM(weXM), .ctrl_writeReg(ctrl_writeReg), .data_writeReg(data_writeReg), .data_readRegA(data_readRegA), .aluDXOutput(aluDXOutput), .oOutputXM(oOutputXM));

    //Bypassing 
    //Possible issue with bypassing, need to check sort.s?
    //MX-WX Bypassing
    wire aBypassMX, bBypassMX, aBypassWX, bBypassWX;
    bypassAB bypassMod(.aBypassMX(aBypassMX), .bBypassMX(bBypassMX), .aBypassWX(aBypassWX), .bBypassWX(bBypassWX), .rdDX(rdDX), .rdXM(rdXM), .rdMW(rdMW), .branchDX(branchDX), .rsDX(rsDX), .rtDX(rtDX), .rdSpecialCaseMW(rdSpecialCaseMW), .rdSpecialCaseXM(rdSpecialCaseXM), .weXM(weXM), .ctrl_writeEnable(ctrl_writeEnable), .irOutputXM(irOutputXM), .irOutputMW(irOutputMW));
    

    //Memory Bypassing
    wire memBypassIn, memBypassOut;
    assign memBypassIn = lwMW && swXM && (rdXM == rdMW);
    assign memBypassOut = weDX && swFD && (rdDX == rdFD);
    assign data = memBypassIn ? data_writeReg : bOutputXM;
    assign bInputDX = memBypassOut ? aluDXOutput : data_readRegB;

    //Branching
    //Possible issue with branching: sort.s?
    wire [31:0] addrBranch;
    wire isBranch;
    branchModule branchMod(.isBranch(isBranch), .addrBranch(addrBranch), .signExtendedImm(signExtendedImm), .pcOutputDX(pcOutputDX), .iNE(iNE), .bNEDX(bNEDX), .iLT(iLT), .bLTDX(bLTDX));
    
    //Stalling 
    wire stall;
    stallModule stallMod(.irInputDX(irInputDX), .stall(stall), .activeMultOrDiv(activeMultOrDiv), .multDX(multDX), .divDX(divDX), .lwDX(lwDX), .rTypeFD(rTypeFD), .rsFD(rsFD), .rtFD(rtFD), .rdFD(rdFD), .rdDX(rdDX), .weFD(weFD), .irOutputFD(irOutputFD), .rdSpecialCaseFD(rdSpecialCaseFD), .isBranch(isBranch));
	
	/* END CODE */

endmodule
