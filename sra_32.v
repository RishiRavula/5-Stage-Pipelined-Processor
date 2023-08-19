module sra_32(out, shamt, a);
    input [31:0] a; 
    input [4:0] shamt;
    output [31:0] out;
    wire [31:0] st16,st8,st4,st2,st1;
    wire [31:0] o16,o8,o4,o2;

    //MSB
    assign st16 = {a[31], {15{a[31]}}, a[31:16]};
    assign o16 = (shamt[4]) ? st16 : a;

    assign st8 = {o16[31], {7{o16[31]}}, o16[31:8]};
    assign o8 = (shamt[3]) ? st8 : o16;

    assign st4 = {o8[31], {3{o8[31]}}, o8[31:4]};
    assign o4 = (shamt[2]) ? st4 : o8;

    assign st2 = {o4[31], {1{o4[31]}}, o4[31:2]};
    assign o2 = (shamt[1]) ? st2 : o4;

    assign st1 = {o2[31], o2[31:1]};
    assign out = (shamt[0]) ? st1 : o2;

    



    
endmodule