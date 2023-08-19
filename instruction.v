module instruction(rs, rt, rd, rdSpecialCase, rType, iType, jIType, jIIType, we, mult, div, branch, lw, sw, jr, j, jal, bNE, bLT, bex, instruction);
    input [31:0] instruction;
    output rType, iType, jIType, jIIType, we, mult, div, branch, lw, sw, jr, j, bex, jal, bNE, bLT;
    output [4:0] rs, rt, rd, rdSpecialCase;
    wire setx, addi;
    wire [4:0] rd1, rd2;
    assign setx = (instruction[31:27] == 5'b10101);
    assign addi = (instruction[31:27] == 5'b00101);
    //Check opcodes for diff type
    assign rType = (instruction[31:27] == 5'b00000);
    assign iType = (instruction[31:27] == 5'b00101) ||
                   (instruction[31:27] == 5'b00111) ||
                   (instruction[31:27] == 5'b01000) ||
                   (instruction[31:27] == 5'b00010) ||
                   (instruction[31:27] == 5'b00110);
    assign jIType = (instruction[31:27] == 5'b00001) ||
                    (instruction[31:27] == 5'b00011) ||
                    (instruction[31:27] == 5'b10110) ||
                    (instruction[31:27] == 5'b10101);
    assign jIIType = (instruction[31:27] == 5'b00100);

    //WE
    assign we = rType || addi || lw || jal || setx;

    // Mult Div
    assign mult = rType && (instruction[6:2] == 5'b00110);
    assign div = rType && (instruction[6:2] == 5'b00111);

    // Branch
    //add back in iType sanity check
    assign bLT = (instruction[31:27] == 5'b00110);
    assign bNE = (instruction[31:27] == 5'b00010);
    assign branch = bLT || bNE;
    // LW SW
    assign lw = (instruction[31:27] == 5'b01000);
    assign sw = (instruction[31:27] == 5'b00111);
    
    // JR J JAL
    assign jr = (instruction[31:27] == 5'b00100);
    assign j = (instruction[31:27] == 5'b00001) || (instruction[31:27] == 5'b00011);
    assign jal = (instruction[31:27] == 5'b00011);

    // BEX
    assign bex = (instruction[31:27] == 5'b10110);


    //REGISTER INSTRUCTIONS
    assign rd = instruction[26:22];
    assign rd1 = jal ? 5'b11111 : rd;
    assign rd2 = setx ? 5'b11110 : rd;
    assign rdSpecialCase = rd1 == 5'b11111 ? rd1 : rd2;
    assign rs = instruction[21:17];
    assign rt = instruction[16:12];


    

                
endmodule