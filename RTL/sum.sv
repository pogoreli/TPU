`timescale 1ns / 1ps

module sum(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    
    logic signA, signB;
    logic [8:0] exponentA, exponentB;
    logic [23:0] mantissaA, mantissaB;
    
    logic [8:0] smallerExponent, largerExponent;
    logic [47:0] smallerMantissa, largerMantissa;
    logic smallerSign, largerSign;

    logic [8:0] exponentDifference;
    
    logic [7:0] exponentNotNormalized;
    logic [47:0] mantissaNotNormalized;
    
    logic signOut;
    logic [7:0] exponentOut;
    logic [22:0] mantissaOut;
    
    logic [8:0] bias = 9'b001111111;
    
    logic [1:0] add, substract, min, max;
    assign add = 2'b00;
    assign substract = 2'b01;
    assign min = 2'b10;
    assign max = 2'b11;
    
    logic [8:0] exponentAIn, exponentBIn;
    assign exponentAIn = {1'b0, inputA[30:23]};
    assign exponentBIn = {1'b0, inputB[30:23]};
    
    alu_9bit substractExponentA(.select(substract), .inputA(exponentAIn), .inputB(bias), .out(exponentA));
    alu_9bit substractExponentB(.select(substract), .inputA(exponentBIn), .inputB(bias), .out(exponentB));
    
    alu_9bit minValue(.select(min), .inputA(exponentA), .inputB(exponentB), .out(smallerExponent));
    alu_9bit maxValue(.select(max), .inputA(exponentA), .inputB(exponentB), .out(largerExponent));

    alu_9bit substractExponents(.select(substract), .inputA(largerExponent), .inputB(smallerExponent), .out(exponentDifference));
    
    logic[8:0] biasedExponent;
    
    alu_9bit addBias(.select(add), .inputA(largerExponent), .inputB(bias), .out(biasedExponent));
    
    logic [7:0] exponentForNormalization;
    assign exponentForNormalization = biasedExponent[7:0];
    
    always_comb begin
//        $display("Raw exponent A %b", exponentAIn, "Raw exponent B %b", exponentBIn);
//        $display("Exponent A %b", exponentA, "Exponent B %b", exponentB);
//        $display("Smaller exponent %b", smallerExponent, "Larger exponent %b", largerExponent);
//        $display("exponentDifference: %b", exponentDifference);
    
    
        if(inputA == 32'b00000000000000000000000000000000) begin
            out = inputB;
        end else if(inputB == 32'b00000000000000000000000000000000) begin
            out = inputA;
        end else begin
            signA = inputA[31];
            signB = inputB[31];
            
//            exponentA = inputA[30:23] - bias;
//            exponentB = inputB[30:23] - bias;
            
            mantissaA = {1'b1, inputA[22:0]};
            mantissaB = {1'b1, inputB[22:0]};
            
            //finding the number with larger exponent and assigning the numbers to variables according to the number
            if(exponentA == smallerExponent) begin
                smallerMantissa = mantissaA;
                largerMantissa = mantissaB;
                smallerSign = signA;
                largerSign = signB;
            end else begin
                smallerMantissa = mantissaB;
                largerMantissa = mantissaA;
                smallerSign = signB;
                largerSign = signA;
            end
            
//            $display("smaller Mantissa %b ", smallerMantissa, " larger Mantissa %b ", largerMantissa);
//            $display("smaller Exponent %b ", smallerExponent, " larger Exponent %b ", largerExponent);
//            $display("smaller Sign %b ", smallerSign, " larger Sign %b ", largerSign);
            
            //Assigning the same exponent to both numbers
            smallerMantissa = smallerMantissa >> exponentDifference[7:0];
            
//            $display("smaller Mantissa %b ", smallerMantissa, " larger Mantissa %b ", largerMantissa);
            
            //Adding or substracting the numbers, depending on their sign
            if(smallerSign == largerSign) begin
                mantissaNotNormalized = smallerMantissa + largerMantissa;
                signOut = smallerSign;
//                $display("case 0");
            end else begin
                if(smallerMantissa < largerMantissa) begin
//                    $display("smaller Mantissa %b ", smallerMantissa, " larger Mantissa %b ", largerMantissa);
                    mantissaNotNormalized = largerMantissa - smallerMantissa;
                    signOut = largerSign;
//                    $display("case 1");
                end else begin
                    mantissaNotNormalized = smallerMantissa - largerMantissa;
                    signOut = smallerSign;
//                    $display("case 2");
                end
            end
            
 //           $display("Mantissa nn %b ", mantissaNotNormalized, " Exponent nn %b ", exponentNotNormalized, " Sign out %b ", signOut);
            exponentNotNormalized = exponentForNormalization;
//            $display("mantissaNotNormalized: %b", mantissaNotNormalized, "exponentNotNormalized: %b", exponentNotNormalized);
            //Normalizing the number
            if(mantissaNotNormalized != 48'b0) begin
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
            end
//            $display("mantissaNotNormalized %b", mantissaNotNormalized, "exponentNotNormalized %b", exponentNotNormalized);
            //Concantenating the numbers to return the output
            mantissaOut = mantissaNotNormalized[22:0];
            exponentOut = exponentNotNormalized;
//            $display("Mantissa out %b ", mantissaOut, " Exponent out %b ", exponentOut, " Sign out %b ", signOut);
            
            out = {signOut, exponentOut, mantissaOut};
        end
    end
endmodule