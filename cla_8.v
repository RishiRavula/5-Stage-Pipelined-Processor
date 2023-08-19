
module cla_8(S, GenOut, PropOut, A, B, Cin);
    input [7:0] A, B;
    input Cin;
    output [7:0] S;
    output GenOut, PropOut;
    //generation and propagation bits
    wire [7:0] G, P;
    //carry bits
    wire c1, c2, c3, c4, c5, c6, c7,c8;
    wire w0; //level 1
    wire w1, w2; //level 2
    wire w3, w4, w5; //level 3
    wire w6, w7, w8, w9; //level 4
    wire w10, w11, w12, w13, w14; //level 5
    wire w15, w16, w17, w18, w19, w20; //level 6
    wire w21, w22, w23, w24, w25, w26, w27; //level 7
    wire w28, w29, w30, w31, w32, w33, w34, w35; //level 8


    //genBits
    and gen0(G[0], A[0], B[0]);
    and gen1(G[1], A[1], B[1]);
    and gen2(G[2], A[2], B[2]);
    and gen3(G[3], A[3], B[3]);
    and gen4(G[4], A[4], B[4]);
    and gen5(G[5], A[5], B[5]);
    and gen6(G[6], A[6], B[6]);
    and gen7(G[7], A[7], B[7]);
    

    //propBits
    or prop0(P[0], A[0], B[0]);
    or prop1(P[1], A[1], B[1]);
    or prop2(P[2], A[2], B[2]);
    or prop3(P[3], A[3], B[3]);
    or prop4(P[4], A[4], B[4]);
    or prop5(P[5], A[5], B[5]);
    or prop6(P[6], A[6], B[6]);
    or prop7(P[7], A[7], B[7]);

    //carry bits - level 1
    and CinAnd(w0, P[0], Cin);
    or c1Out(c1, G[0], w0);
    
    //carry bits - level 2
    and c2And0(w1, P[0], P[1], Cin);
    and c2And1(w2, G[0], P[1]);
    or c2Or(c2, w1, w2, G[1]);

    //carry bits - level 3
    and c3And0(w3, P[0], P[1], P[2], Cin);
    and c3And1(w4, G[0], P[1], P[2]);
    and c3And2(w5, G[1], P[2]);
    or c3Or(c3, w3, w4, w5, G[2]);

    //carry bits - level 4
    and c4And0(w6, P[0], P[1], P[2], P[3], Cin);
    and c4And1(w7, G[0], P[1], P[2], P[3]);
    and c4And2(w8, G[1], P[2], P[3]);
    and c4And3(w9, G[2], P[3]);
    or c4Or(c4, w6, w7, w8, w9, G[3]);

    //carry bits - level 5
    and c5And0(w10, P[0], P[1], P[2], P[3], P[4], Cin);
    and c5And1(w11, G[0], P[1], P[2], P[3], P[4]);
    and c5And2(w12, G[1], P[2], P[3], P[4]);
    and c5And3(w13, G[2], P[3], P[4]);
    and c5And4(w14, G[3], P[4]);
    or c5Or(c5, w10, w11, w12, w13, w14, G[4]);

    //carry bits - level 6
    and c6And0(w15, P[0], P[1], P[2], P[3], P[4], P[5], Cin);
    and c6And1(w16, G[0], P[1], P[2], P[3], P[4], P[5]);
    and c6And2(w17, G[1], P[2], P[3], P[4], P[5]);
    and c6And3(w18, G[2], P[3], P[4], P[5]);
    and c6And4(w19, G[3], P[4], P[5]);
    and c6And5(w20, G[4], P[5]);
    or c6Or(c6, w15, w16, w17, w18, w19, w20, G[5]);

    //carry bits - level 7
    and c7And0(w21, P[0], P[1], P[2], P[3], P[4], P[5], P[6], Cin);
    and c7And1(w22, G[0], P[1], P[2], P[3], P[4], P[5], P[6]);
    and c7And2(w23, G[1], P[2], P[3], P[4], P[5], P[6]);
    and c7And3(w24, G[2], P[3], P[4], P[5], P[6]);
    and c7And4(w25, G[3], P[4], P[5], P[6]);
    and c7And5(w26, G[4], P[5], P[6]);
    and c7And6(w27, G[5], P[6]);
    or c7Or(c7, w21, w22, w23, w24, w25, w26, w27, G[6]);

    //carry bits - level 8
    and c8And0(w28, P[0], P[1], P[2], P[3], P[4], P[5], P[6], P[7], Cin);
    and c8And1(w29, G[0], P[1], P[2], P[3], P[4], P[5], P[6], P[7]);
    and c8And2(w30, G[1], P[2], P[3], P[4], P[5], P[6], P[7]);
    and c8And3(w31, G[2], P[3], P[4], P[5], P[6], P[7]);
    and c8And4(w32, G[3], P[4], P[5], P[6], P[7]);
    and c8And5(w33, G[4], P[5], P[6], P[7]);
    and c8And6(w34, G[5], P[6], P[7]);
    and c8And7(w35, G[6], P[7]);
    
    or c8Or(GenOut, G[7], w28, w29, w30, w31, w32, w33, w34, w35);
    and propOut(PropOut, P[0], P[1], P[2], P[3], P[4], P[5], P[6], P[7]);
    //sumBits
    xor sum0(S[0], A[0], B[0], Cin);
    xor sum1(S[1], A[1], B[1], c1);
    xor sum2(S[2], A[2], B[2], c2);
    xor sum3(S[3], A[3], B[3], c3);
    xor sum4(S[4], A[4], B[4], c4);
    xor sum5(S[5], A[5], B[5], c5);
    xor sum6(S[6], A[6], B[6], c6);
    xor sum7(S[7], A[7], B[7], c7);
    

endmodule





