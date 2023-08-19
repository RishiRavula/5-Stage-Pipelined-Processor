module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    wire [31:0] claRes;
    wire [31:0] andRes;
    wire [31:0] orRes;
    wire [31:0] sllRes;
    wire [31:0] sraRes;
    wire [31:0] notB;
    wire [31:0] bAfterMux;
    wire lt;
    // add your code here:

    //Preliminary mux to get B or notB for subtraction

    not_32 not_B(.in(data_operandB), .out(notB));
    mux_2 muxB(.in0(data_operandB), .in1(notB), .select(ctrl_ALUopcode[0]), .out(bAfterMux));

    //ALU-Ops
    // 00000 - Add
    // 00001 - Sub
    cla_32 adderOp(.A(data_operandA), .B(bAfterMux), .ovf(overflow), .S(claRes), .Cin(ctrl_ALUopcode[0]));
    // 00010 - AND
    and_32 andOp(.a(data_operandA), .b(data_operandB), .out(andRes));
    // 00011 - OR
    or_32 orOp(.a(data_operandA), .b(data_operandB), .out(orRes));
    // 00100 - SLL
    sll_32 sllOp(.a(data_operandA), .shamt(ctrl_shiftamt), .out(sllRes));
    // 00101 - SRA
    sra_32 sraOp(.a(data_operandA), .shamt(ctrl_shiftamt), .out(sraRes));
    //MUX to select ALU operation, use only the first 3 bits of ctrl_ALUopcode
    mux_8 muxOp(.in0(claRes), .in1(claRes), .in2(andRes), .in3(orRes), .in4(sllRes), .in5(sraRes), .in6(32'b0), .in7(32'b0), .select(ctrl_ALUopcode[2:0]), .out(data_result));

    //HANDLE EQUALITIES
    //isLessThan
    not notLT(lt, claRes[31]);
    assign isLessThan = overflow ? lt : claRes[31];

    //isNotEqual
    or ine(isNotEqual, claRes[0], claRes[1], claRes[2], claRes[3], claRes[4], claRes[5], claRes[6], claRes[7], claRes[8], claRes[9], claRes[10], claRes[11], claRes[12], claRes[13], claRes[14], claRes[15], claRes[16], claRes[17], claRes[18], claRes[19], claRes[20], claRes[21], claRes[22], claRes[23], claRes[24], claRes[25], claRes[26], claRes[27], claRes[28], claRes[29], claRes[30], claRes[31]);


    

endmodule