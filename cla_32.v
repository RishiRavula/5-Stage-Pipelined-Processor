module cla_32(S, ovf, A, B, Cin);
    input [31:0] A, B;
    input Cin;
    output [31:0] S;
    output ovf;
    
    wire [3:0] G, P;
    wire c8, c16, c24, c32;
    wire w0;
    wire w1,w2;
    wire w3,w4,w5;
    wire w6,w7,w8,w9;

    wire [1:0] ovfAB;

    cla_8 b0(.S(S[7:0]), .GenOut(G[0]), .PropOut(P[0]), .A(A[7:0]), .B(B[7:0]), .Cin(Cin));
    cla_8 b1(.S(S[15:8]), .GenOut(G[1]), .PropOut(P[1]), .A(A[15:8]), .B(B[15:8]), .Cin(G[0]));
    cla_8 b2(.S(S[23:16]), .GenOut(G[2]), .PropOut(P[2]), .A(A[23:16]), .B(B[23:16]), .Cin(G[1]));
    cla_8 b3(.S(S[31:24]), .GenOut(G[3]), .PropOut(P[3]), .A(A[31:24]), .B(B[31:24]), .Cin(G[2]));

    //Second CLA Stage 

    //Level 1
    and carry1And(w0, P[0],Cin);
    or carry1Or(c8, w0, G[0]);

    //Level 2
    and carry2And0(w1, P[0],P[1],Cin);
    and carry2And1(w2, G[0],P[1]);
    or carry2Or0(c16, w1, w2, G[1]);

    //Level 3
    and carry3And0(w3, P[0],P[1],P[2],Cin);
    and carry3And1(w4, G[0],P[1],P[2]);
    and carry3And2(w5, G[1],P[2]);
    or carry3Or0(c24, w3, w4, w5, G[2]);

    //Level 4
    and carry4And0(w6, P[0],P[1],P[2],P[3],Cin);
    and carry4And1(w7, G[0],P[1],P[2],P[3]);
    and carry4And2(w8, G[1],P[2],P[3]);
    and carry4And3(w9, G[2],P[3]);
    or carry4Or0(c32, w6, w7, w8, w9, G[3]);


    //Overflow
    xor ovfARes(ovfAB[1], A[31], S[31]);
    xor ovfBRes(ovfAB[0], B[31], S[31]);
    and ovfRes(ovf, ovfAB[1], ovfAB[0]);

endmodule