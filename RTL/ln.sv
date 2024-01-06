`timescale 1ns / 1ps

module ln(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic [31:0] one, minusOne, XMinusOne, ln, lnOfTwo, lnOfTwoTimesN;
    logic [31:0] n, x;
    logic [30:0][31:0] powers, count, powersDivideByCount, powersOfMinusOne, terms, sumOfTerms;
    
    adjustForLn adjustForLn(.inputA(inputA), .n(n), .x(x));
    
    assign one = 32'b00111111100000000000000000000000;
    assign minusOne = 32'b10111111100000000000000000000000;
    assign lnOfTwo = 32'b00111111001100010111001000011000;
    
    substract XMinusOneSubstraction(.inputA(x), .inputB(one), .out(XMinusOne));
    int_power powersOfXMinusOne(.inputA(XMinusOne), .out(powers));
    
    assign count[0] = 32'b00000000000000000000000000000000;
    assign powersOfMinusOne[0] = minusOne;
    assign sumOfTerms[0] = 32'b00000000000000000000000000000000;
    assign terms[0] = 32'b00000000000000000000000000000000;
    assign powersDivideByCount[0] = 32'b00000000000000000000000000000000;

    genvar i;
    generate
        for (i = 1; i <= 30; i++) begin
            sum count(.inputA(count[i-1]), .inputB(one), .out(count[i]));
            multiply multiplyByMinusOne(.inputA(powersOfMinusOne[i-1]), .inputB(minusOne), .out(powersOfMinusOne[i]));
            sum sumTerms(.inputA(sumOfTerms[i-1]), .inputB(terms[i]), .out(sumOfTerms[i]));
            
        end
    endgenerate
    
    genvar j;
    generate
        for (j = 1; j <= 30; j++) begin
            divide powersDivided(.inputA(powers[j]), .inputB(count[j]), .out(powersDivideByCount[j]));
            multiply findEachTerm(.inputA(powersOfMinusOne[j]), .inputB(powersDivideByCount[j]), .out(terms[j])); 
        end
    endgenerate
    
    assign ln = sumOfTerms[30];
    multiply multiplyByN(.inputA(lnOfTwo), .inputB(n), .out(lnOfTwoTimesN));
    sum outputValue(.inputA(ln), .inputB(lnOfTwoTimesN), .out(out));
    
//    always_comb begin
////         $display("x-1= ", $bitstoshortreal(x), " - ", $bitstoshortreal(one), " = ", $bitstoshortreal(XMinusOne));
//        for(int i = 0; i <=30; i++) begin
////            $display("count: ", $bitstoshortreal(count[i]));
////            $display("powers of -0.5: ", i, ": ", $bitstoshortreal(powers[i]));
////            $display("powers of -0.5 divided by count: ", i, ": ", $bitstoshortreal(powersDivideByCount[i]));
////            $display(i, ": ", $bitstoshortreal(powers[i]), " / ",  $bitstoshortreal(count[i]), " = ", $bitstoshortreal(powersDivideByCount[i]));
////            $display("powers of -1: ", i, " : ", $bitstoshortreal(powersOfMinusOne[i]));
////            $display("Terms: ", i, " : ", $bitstoshortreal(terms[i]));
////            divide powersDivided(.inputA(powers[j]), .inputB(count[j]), .out(powersDivideByCount[j]));          
//        end
//        $display("ln of ", $bitstoshortreal(x), " * ", $bitstoshortreal(n), " = ", $bitstoshortreal(ln), " + ", $bitstoshortreal(lnOfTwo), " * ", $bitstoshortreal(n), " = ", $bitstoshortreal(out));
//    end
endmodule
