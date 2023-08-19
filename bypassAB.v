module bypassAB(aBypassMX, bBypassMX, aBypassWX, bBypassWX, rdDX, rsDX, rdXM, rdMW, branchDX, rsDX, rtDX, rdSpecialCaseMW, rdSpecialCaseXM, weXM, ctrl_writeEnable, irOutputXM, irOutputMW);

input [4:0] rdDX, rsDX, rdXM, rdMW, rtDX, rdSpecialCaseMW, rdSpecialCaseXM;
input branchDX, weXM, ctrl_writeEnable;
input [31:0] irOutputXM, irOutputMW;
output aBypassMX, bBypassMX, aBypassWX, bBypassWX;

assign aBypassMX = ((rdDX == rdXM && branchDX) || rsDX == rdSpecialCaseXM  ) && weXM && irOutputXM != 32'b00000000000000000000000000000000;
assign aBypassWX = ((rdDX == rdMW && branchDX) || rsDX == rdSpecialCaseMW  ) && ctrl_writeEnable && irOutputMW != 32'b00000000000000000000000000000000;
assign bBypassMX = ((rsDX == rdXM && branchDX) || rtDX == rdSpecialCaseXM  ) && weXM && irOutputXM != 32'b00000000000000000000000000000000; 
assign bBypassWX = ((rsDX == rdMW && branchDX) || rtDX == rdSpecialCaseMW  ) && ctrl_writeEnable && irOutputMW != 32'b00000000000000000000000000000000; 
endmodule