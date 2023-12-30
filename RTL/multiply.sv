`timescale 1ns / 1ps

module multiply(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    
    logic signA, signB;
    logic [8:0]  exponentA, exponentB;
    logic [23:0] mantissaA, mantissaB;
    
    logic [7:0] exponentDuringNormalization;
    logic [47:0] mantissaDuringNormalization;
    
    logic signOut;
    logic [7:0] exponentOut;
    logic [22:0] mantissaOut;
    
    logic [7:0] exponentNotNormalized;
    logic [47:0] mantissaNotNormalized; //24bit*24bit=48

    logic [8:0] bias = 9'b001111111;
    
    logic add, substract;
    assign add = 1'b0;
    assign substract = 1'b1;
    
    logic [8:0] exponentAIn, exponentBIn;
    assign exponentAIn = {1'b0, inputA[30:23]};
    assign exponentBIn = {1'b0, inputB[30:23]};
    alu_9bit substractExponentA(.select(substract), .inputA(exponentAIn), .inputB(bias), .out(exponentA));
    alu_9bit substractExponentB(.select(substract), .inputA(exponentBIn), .inputB(bias), .out(exponentB));
    logic [8:0] sumOfExponents;
    alu_9bit addExponents(.select(add), .inputA(exponentA), .inputB(exponentB), .out(sumOfExponents));
    logic [8:0] sumOfExponentsWithBias;
    alu_9bit addBiasToExponents(.select(add), .inputA(sumOfExponents), .inputB(bias), .out(sumOfExponentsWithBias));

    assign signA = inputA[31];
    assign signB = inputB[31];
    assign signOut = signA ^ signB;
    
    assign mantissaA = {1'b1, inputA[22:0]};
    assign mantissaB = {1'b1, inputB[22:0]};
    assign mantissaNotNormalized = mantissaA * mantissaB;
    
    always_comb begin
//        $display("Raw exponent A %b ", exponentAIn, " Raw exponent B %b ", exponentBIn);
//        $display("Mantissa A %b ", mantissaA, " Exponent A %b ", exponentA, " Sign A %b ", signA);
//        $display("Mantissa B %b ", mantissaB, " Exponent B %b ", exponentB, " Sign B %b ", signB);
//        $display("Mantissa not normalized %b ", mantissaNotNormalized, " Sum of exponents %b ", sumOfExponents, " Sign out %b ", signOut);

        mantissaDuringNormalization = mantissaNotNormalized;
        exponentDuringNormalization = sumOfExponentsWithBias[7:0];

        if (mantissaDuringNormalization[47] == 0) begin
            for(int i = 0; i < 48; i++) begin
                if(mantissaDuringNormalization[47] == 0) begin
                    mantissaDuringNormalization = mantissaDuringNormalization<<1;
                    exponentDuringNormalization = exponentDuringNormalization - 1;
                end
            end
        end
        
        exponentDuringNormalization = exponentDuringNormalization + 1'b1;
        
        mantissaOut = mantissaDuringNormalization[46:24];
        exponentOut = exponentDuringNormalization;

//        $display("Mantissa out %b ", mantissaOut, " Exponent out %b ", exponentOut, " Sign out %b ", signOut);
        
        out = {signOut, exponentOut[7:0], mantissaOut};
    end
endmodule