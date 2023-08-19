module controlBooth(addMult, subMult, shift, nothing, in);
    input [31:0] in;
    output addMult, subMult, shift, nothing;
    wire doNothing000;
    wire subMultShift100;
    wire addMult010;
    wire subMult110;
    wire addMult001;
    wire subMult101;
    wire addMultShift011;
    wire doNothing111;
    
    //Booth Algorithm
    assign doNothing000 = ~in[2] & ~in[1] & ~in[0];
    assign subMultShift100 = in[2] & ~in[1] & ~in[0];
    assign addMult010 = ~in[2] & in[1] & ~in[0];
    assign subMult110 = in[2] & in[1] & ~in[0];
    assign addMult001 = ~in[2] & ~in[1] & in[0];
    assign subMult101 = in[2] & ~in[1] & in[0];
    assign addMultShift011 = ~in[2] & in[1] & in[0];
    assign doNothing111 = in[2] & in[1] & in[0];

    assign addMult = addMult010 | addMult001 | addMultShift011;
    assign subMult = subMultShift100 | subMult110 | subMult101;
    assign shift = subMultShift100 | addMultShift011;
    assign nothing = doNothing000 | doNothing111;


endmodule