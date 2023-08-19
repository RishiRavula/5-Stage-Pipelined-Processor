module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;
	wire [31:0] writeDecoderOut;
	wire [31:0] writeAndResult;
	wire [31:0] zeroReg;
	assign zeroReg = 32'b00000000000000000000000000000000;
	wire [31:0] regOut1, regOut2, regOut3, regOut4, regOut5, regOut6, regOut7, regOut8, regOut9, regOut10, regOut11, regOut12, regOut13, regOut14, regOut15, regOut16, regOut17, regOut18, regOut19, regOut20, regOut21, regOut22, regOut23, regOut24, regOut25, regOut26, regOut27, regOut28, regOut29, regOut30, regOut31;
	wire [31:0] whichRegToRead1;
	wire [31:0] whichRegToRead2;
	

	// add your code here
	decoder32 writeDecoder(writeDecoderOut, ctrl_writeReg, ctrl_writeEnable);
	and checkWrite0(writeAndResult[0], writeDecoderOut[0], ctrl_writeEnable);
	and checkWrite1(writeAndResult[1], writeDecoderOut[1], ctrl_writeEnable);
	and checkWrite2(writeAndResult[2], writeDecoderOut[2], ctrl_writeEnable);
	and checkWrite3(writeAndResult[3], writeDecoderOut[3], ctrl_writeEnable);
	and checkWrite4(writeAndResult[4], writeDecoderOut[4], ctrl_writeEnable);
	and checkWrite5(writeAndResult[5], writeDecoderOut[5], ctrl_writeEnable);
	and checkWrite6(writeAndResult[6], writeDecoderOut[6], ctrl_writeEnable);
	and checkWrite7(writeAndResult[7], writeDecoderOut[7], ctrl_writeEnable);
	and checkWrite8(writeAndResult[8], writeDecoderOut[8], ctrl_writeEnable);
	and checkWrite9(writeAndResult[9], writeDecoderOut[9], ctrl_writeEnable);
	and checkWrite10(writeAndResult[10], writeDecoderOut[10], ctrl_writeEnable);
	and checkWrite11(writeAndResult[11], writeDecoderOut[11], ctrl_writeEnable);
	and checkWrite12(writeAndResult[12], writeDecoderOut[12], ctrl_writeEnable);
	and checkWrite13(writeAndResult[13], writeDecoderOut[13], ctrl_writeEnable);
	and checkWrite14(writeAndResult[14], writeDecoderOut[14], ctrl_writeEnable);
	and checkWrite15(writeAndResult[15], writeDecoderOut[15], ctrl_writeEnable);
	and checkWrite16(writeAndResult[16], writeDecoderOut[16], ctrl_writeEnable);
	and checkWrite17(writeAndResult[17], writeDecoderOut[17], ctrl_writeEnable);
	and checkWrite18(writeAndResult[18], writeDecoderOut[18], ctrl_writeEnable);
	and checkWrite19(writeAndResult[19], writeDecoderOut[19], ctrl_writeEnable);
	and checkWrite20(writeAndResult[20], writeDecoderOut[20], ctrl_writeEnable);
	and checkWrite21(writeAndResult[21], writeDecoderOut[21], ctrl_writeEnable);
	and checkWrite22(writeAndResult[22], writeDecoderOut[22], ctrl_writeEnable);
	and checkWrite23(writeAndResult[23], writeDecoderOut[23], ctrl_writeEnable);
	and checkWrite24(writeAndResult[24], writeDecoderOut[24], ctrl_writeEnable);
	and checkWrite25(writeAndResult[25], writeDecoderOut[25], ctrl_writeEnable);
	and checkWrite26(writeAndResult[26], writeDecoderOut[26], ctrl_writeEnable);
	and checkWrite27(writeAndResult[27], writeDecoderOut[27], ctrl_writeEnable);
	and checkWrite28(writeAndResult[28], writeDecoderOut[28], ctrl_writeEnable);
	and checkWrite29(writeAndResult[29], writeDecoderOut[29], ctrl_writeEnable);
	and checkWrite30(writeAndResult[30], writeDecoderOut[30], ctrl_writeEnable);
	and checkWrite31(writeAndResult[31], writeDecoderOut[31], ctrl_writeEnable);
	
	
	register32 reg1 (regOut1, data_writeReg, clock, writeAndResult[1], ctrl_reset);
	register32 reg2 (regOut2, data_writeReg, clock, writeAndResult[2], ctrl_reset);
	register32 reg3 (regOut3, data_writeReg, clock, writeAndResult[3], ctrl_reset);
	register32 reg4 (regOut4, data_writeReg, clock, writeAndResult[4], ctrl_reset);
	register32 reg5 (regOut5, data_writeReg, clock, writeAndResult[5], ctrl_reset);
	register32 reg6 (regOut6, data_writeReg, clock, writeAndResult[6], ctrl_reset);
	register32 reg7 (regOut7, data_writeReg, clock, writeAndResult[7], ctrl_reset);
	register32 reg8 (regOut8, data_writeReg, clock, writeAndResult[8], ctrl_reset);
	register32 reg9 (regOut9, data_writeReg, clock, writeAndResult[9], ctrl_reset);
	register32 reg10 (regOut10, data_writeReg, clock, writeAndResult[10], ctrl_reset);
	register32 reg11 (regOut11, data_writeReg, clock, writeAndResult[11], ctrl_reset);
	register32 reg12 (regOut12, data_writeReg, clock, writeAndResult[12], ctrl_reset);
	register32 reg13 (regOut13, data_writeReg, clock, writeAndResult[13], ctrl_reset);
	register32 reg14 (regOut14, data_writeReg, clock, writeAndResult[14], ctrl_reset);
	register32 reg15 (regOut15, data_writeReg, clock, writeAndResult[15], ctrl_reset);
	register32 reg16 (regOut16, data_writeReg, clock, writeAndResult[16], ctrl_reset);
	register32 reg17 (regOut17, data_writeReg, clock, writeAndResult[17], ctrl_reset);
	register32 reg18 (regOut18, data_writeReg, clock, writeAndResult[18], ctrl_reset);
	register32 reg19 (regOut19, data_writeReg, clock, writeAndResult[19], ctrl_reset);
	register32 reg20 (regOut20, data_writeReg, clock, writeAndResult[20], ctrl_reset);
	register32 reg21 (regOut21, data_writeReg, clock, writeAndResult[21], ctrl_reset);
	register32 reg22 (regOut22, data_writeReg, clock, writeAndResult[22], ctrl_reset);
	register32 reg23 (regOut23, data_writeReg, clock, writeAndResult[23], ctrl_reset);
	register32 reg24 (regOut24, data_writeReg, clock, writeAndResult[24], ctrl_reset);
	register32 reg25 (regOut25, data_writeReg, clock, writeAndResult[25], ctrl_reset);
	register32 reg26 (regOut26, data_writeReg, clock, writeAndResult[26], ctrl_reset);
	register32 reg27 (regOut27, data_writeReg, clock, writeAndResult[27], ctrl_reset);
	register32 reg28 (regOut28, data_writeReg, clock, writeAndResult[28], ctrl_reset);
	register32 reg29 (regOut29, data_writeReg, clock, writeAndResult[29], ctrl_reset);
	register32 reg30 (regOut30, data_writeReg, clock, writeAndResult[30], ctrl_reset);
	register32 reg31 (regOut31, data_writeReg, clock, writeAndResult[31], ctrl_reset);

	

	decoder32 readDecoder1(whichRegToRead1, ctrl_readRegA, 1'b1);
	decoder32 readDecoder2(whichRegToRead2, ctrl_readRegB, 1'b1);

	tri_state_buffer RS1_0(data_readRegA, zeroReg, whichRegToRead1[0]);
	tri_state_buffer RS1_1(data_readRegA, regOut1, whichRegToRead1[1]);
	tri_state_buffer RS1_2(data_readRegA, regOut2, whichRegToRead1[2]);
	tri_state_buffer RS1_3(data_readRegA, regOut3, whichRegToRead1[3]);
	tri_state_buffer RS1_4(data_readRegA, regOut4, whichRegToRead1[4]);
	tri_state_buffer RS1_5(data_readRegA, regOut5, whichRegToRead1[5]);
	tri_state_buffer RS1_6(data_readRegA, regOut6, whichRegToRead1[6]);
	tri_state_buffer RS1_7(data_readRegA, regOut7, whichRegToRead1[7]);
	tri_state_buffer RS1_8(data_readRegA, regOut8, whichRegToRead1[8]);
	tri_state_buffer RS1_9(data_readRegA, regOut9, whichRegToRead1[9]);
	tri_state_buffer RS1_10(data_readRegA, regOut10, whichRegToRead1[10]);
	tri_state_buffer RS1_11(data_readRegA, regOut11, whichRegToRead1[11]);
	tri_state_buffer RS1_12(data_readRegA, regOut12, whichRegToRead1[12]);
	tri_state_buffer RS1_13(data_readRegA, regOut13, whichRegToRead1[13]);
	tri_state_buffer RS1_14(data_readRegA, regOut14, whichRegToRead1[14]);
	tri_state_buffer RS1_15(data_readRegA, regOut15, whichRegToRead1[15]);
	tri_state_buffer RS1_16(data_readRegA, regOut16, whichRegToRead1[16]);
	tri_state_buffer RS1_17(data_readRegA, regOut17, whichRegToRead1[17]);
	tri_state_buffer RS1_18(data_readRegA, regOut18, whichRegToRead1[18]);
	tri_state_buffer RS1_19(data_readRegA, regOut19, whichRegToRead1[19]);
	tri_state_buffer RS1_20(data_readRegA, regOut20, whichRegToRead1[20]);
	tri_state_buffer RS1_21(data_readRegA, regOut21, whichRegToRead1[21]);
	tri_state_buffer RS1_22(data_readRegA, regOut22, whichRegToRead1[22]);
	tri_state_buffer RS1_23(data_readRegA, regOut23, whichRegToRead1[23]);
	tri_state_buffer RS1_24(data_readRegA, regOut24, whichRegToRead1[24]);
	tri_state_buffer RS1_25(data_readRegA, regOut25, whichRegToRead1[25]);
	tri_state_buffer RS1_26(data_readRegA, regOut26, whichRegToRead1[26]);
	tri_state_buffer RS1_27(data_readRegA, regOut27, whichRegToRead1[27]);
	tri_state_buffer RS1_28(data_readRegA, regOut28, whichRegToRead1[28]);
	tri_state_buffer RS1_29(data_readRegA, regOut29, whichRegToRead1[29]);
	tri_state_buffer RS1_30(data_readRegA, regOut30, whichRegToRead1[30]);
	tri_state_buffer RS1_31(data_readRegA, regOut31, whichRegToRead1[31]);

	tri_state_buffer RS2_0(data_readRegB, zeroReg, whichRegToRead2[0]);
	tri_state_buffer RS2_1(data_readRegB, regOut1, whichRegToRead2[1]);
	tri_state_buffer RS2_2(data_readRegB, regOut2, whichRegToRead2[2]);
	tri_state_buffer RS2_3(data_readRegB, regOut3, whichRegToRead2[3]);
	tri_state_buffer RS2_4(data_readRegB, regOut4, whichRegToRead2[4]);
	tri_state_buffer RS2_5(data_readRegB, regOut5, whichRegToRead2[5]);
	tri_state_buffer RS2_6(data_readRegB, regOut6, whichRegToRead2[6]);
	tri_state_buffer RS2_7(data_readRegB, regOut7, whichRegToRead2[7]);
	tri_state_buffer RS2_8(data_readRegB, regOut8, whichRegToRead2[8]);
	tri_state_buffer RS2_9(data_readRegB, regOut9, whichRegToRead2[9]);
	tri_state_buffer RS2_10(data_readRegB, regOut10, whichRegToRead2[10]);
	tri_state_buffer RS2_11(data_readRegB, regOut11, whichRegToRead2[11]);
	tri_state_buffer RS2_12(data_readRegB, regOut12, whichRegToRead2[12]);
	tri_state_buffer RS2_13(data_readRegB, regOut13, whichRegToRead2[13]);
	tri_state_buffer RS2_14(data_readRegB, regOut14, whichRegToRead2[14]);
	tri_state_buffer RS2_15(data_readRegB, regOut15, whichRegToRead2[15]);
	tri_state_buffer RS2_16(data_readRegB, regOut16, whichRegToRead2[16]);
	tri_state_buffer RS2_17(data_readRegB, regOut17, whichRegToRead2[17]);
	tri_state_buffer RS2_18(data_readRegB, regOut18, whichRegToRead2[18]);
	tri_state_buffer RS2_19(data_readRegB, regOut19, whichRegToRead2[19]);
	tri_state_buffer RS2_20(data_readRegB, regOut20, whichRegToRead2[20]);
	tri_state_buffer RS2_21(data_readRegB, regOut21, whichRegToRead2[21]);
	tri_state_buffer RS2_22(data_readRegB, regOut22, whichRegToRead2[22]);
	tri_state_buffer RS2_23(data_readRegB, regOut23, whichRegToRead2[23]);
	tri_state_buffer RS2_24(data_readRegB, regOut24, whichRegToRead2[24]);
	tri_state_buffer RS2_25(data_readRegB, regOut25, whichRegToRead2[25]);
	tri_state_buffer RS2_26(data_readRegB, regOut26, whichRegToRead2[26]);
	tri_state_buffer RS2_27(data_readRegB, regOut27, whichRegToRead2[27]);
	tri_state_buffer RS2_28(data_readRegB, regOut28, whichRegToRead2[28]);
	tri_state_buffer RS2_29(data_readRegB, regOut29, whichRegToRead2[29]);
	tri_state_buffer RS2_30(data_readRegB, regOut30, whichRegToRead2[30]);
	tri_state_buffer RS2_31(data_readRegB, regOut31, whichRegToRead2[31]);


endmodule
