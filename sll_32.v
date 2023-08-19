module sll_32(out, shamt, a);
    input [31:0] a; 
    input [4:0] shamt;
    output [31:0] out;
    wire [31:0] st16,st8,st4,st2,st1;
    wire [31:0] o16,o8,o4,o2;

    assign st16 = {a[15:0], {16{1'b0}}};
    assign o16 = (shamt[4]) ? st16 : a;

    assign st8 = {o16[23:0], {8{1'b0}}};
    assign o8 = (shamt[3]) ? st8 : o16;

    assign st4 = {o8[27:0], {4{1'b0}}};
    assign o4 = (shamt[2]) ? st4 : o8;

    assign st2 = {o4[29:0], {2{1'b0}}};
    assign o2 = (shamt[1]) ? st2 : o4;
    
    assign st1 = {o2[30:0], {1{1'b0}}};
    assign out = (shamt[0]) ? st1 : o2;

    
    
endmodule