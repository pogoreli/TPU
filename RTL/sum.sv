`timescale 1ns / 1ps

module sum(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    
    logic signA, signB;
    logic [7:0] exponentA, exponentB;
    logic [23:0] mantissaA, mantissaB;
    
    logic [7:0] smallerExponent, largerExponent;
    logic [47:0] smallerMantissa, largerMantissa;
    logic smallerSign, largerSign;

    logic [7:0] exponentDifference;
    
    logic [7:0] exponentNotNormalized;
    logic [47:0] mantissaNotNormalized;
    
    logic signOut;
    logic [7:0] exponentOut;
    logic [22:0] mantissaOut;
    
    logic [6:0] bias = 7'd127;
    
    always_comb begin
        signA = inputA[31];
        signB = inputB[31];
        
        exponentA = inputA[30:23] - bias;
        exponentB = inputB[30:23] - bias;
        
        mantissaA = {1'b1, inputA[22:0]};
        mantissaB = {1'b1, inputB[22:0]};
        
        //finding the number with larger exponent and assigning the numbers to variables according to the number
        if(exponentA < exponentB) begin
            smallerExponent = exponentA;
            largerExponent = exponentB;
            smallerMantissa = mantissaA;
            largerMantissa = mantissaB;
            smallerSign = signA;
            largerSign = signB;
        end else begin
            smallerExponent = exponentB;
            largerExponent = exponentA;
            smallerMantissa = mantissaB;
            largerMantissa = mantissaA;
            smallerSign = signB;
            largerSign = signA;
        end
        
        $display("smaller Mantissa %b ", smallerMantissa, " larger Mantissa %b ", largerMantissa);
        $display("smaller Exponent %b ", smallerExponent, " larger Exponent %b ", largerExponent);
        $display("smaller Sign %b ", smallerSign, " larger Sign %b ", largerSign);
        
        //Assigning the same exponent to both numbers
        exponentDifference = largerExponent - smallerExponent;
        smallerMantissa = smallerMantissa >> exponentDifference;
        
        exponentNotNormalized = largerExponent;
        
        //Adding or substracting the numbers, depending on their sign
        if(smallerSign == largerSign) begin
            mantissaNotNormalized = smallerMantissa + largerMantissa;
            signOut = smallerSign;
        end else begin
            if(smallerMantissa < largerMantissa) begin
                mantissaNotNormalized = largerMantissa - smallerMantissa;
                signOut = largerSign;
            end else begin
                mantissaNotNormalized = smallerMantissa - largerMantissa;
                signOut = smallerSign;
            end
        end
        
        $display("Mantissa nn %b ", mantissaNotNormalized, " Exponent nn %b ", exponentNotNormalized, " Sign out %b ", signOut);
        

        //Normalizing the number
        if (mantissaNotNormalized[47:24] > 0) begin
            for(int i = 0; i < 24; i++) begin
                if(mantissaNotNormalized[47:24] > 0) begin
                    mantissaNotNormalized = mantissaNotNormalized >> 1;
                    exponentNotNormalized = exponentNotNormalized + 1;
                end
            end
        end else begin
            for(int i = 0; i < 24; i++) begin
                if(mantissaNotNormalized[23] == 0) begin
                    mantissaNotNormalized = mantissaNotNormalized << 1;
                    exponentNotNormalized = exponentNotNormalized - 1;
                end
            end
        end
        
        //Concantenating the numbers to return the output
        mantissaOut = mantissaNotNormalized[22:0];
        exponentOut = exponentNotNormalized + bias;
        $display("Mantissa out %b ", mantissaOut, " Exponent out %b ", exponentOut, " Sign out %b ", signOut);
        
        out = {signOut, exponentOut[7:0], mantissaOut};
        
    end
endmodule