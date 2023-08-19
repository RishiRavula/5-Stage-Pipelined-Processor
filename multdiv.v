module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY, mult_exception1, div_exception1);
    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;
	output mult_exception1, div_exception1;

    // Your code here
	 
	 wire stop_mult, mult_exception, mult_ready;
	 wire stop_div, div_exception, div_ready;
	 wire [31:0] mult_result;
	 wire [31:0] div_result;
	 
	 assign stop_mult = ctrl_DIV;
	 assign stop_div = ctrl_MULT;
	 
	 multiplier mult (data_operandA, data_operandB, ctrl_MULT, stop_mult, clock, mult_result, mult_exception, mult_ready);
	 divider div (data_operandA, data_operandB, ctrl_DIV, stop_div, clock, div_result, div_exception, div_ready);
	 
	 assign data_resultRDY = mult_ready || div_ready;
	 assign data_result = mult_ready ? mult_result : div_result;
	 assign data_exception = mult_ready ? mult_exception : div_exception;
	 assign mult_exception1 = mult_ready ? mult_exception : 1'b0;
	 assign div_exception1 = div_ready ? div_exception : 1'b0;
	 
endmodule
