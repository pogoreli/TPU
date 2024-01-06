`timescale 1ns / 1ps

module tanh(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic[31:0] zero, minusTwenty, twenty, Amin, Amax, exponentA, minusA, exponentMinusA, numerator, denominator, result;
    
    assign zero = 32'b00000000000000000000000000000000;
    assign twenty = 32'b01000001101000000000000000000000;
    assign minusTwenty = 32'b11000001101000000000000000000000;
    
//    max max(.inputA(inputA), .inputB(minusTwenty), .out(Amin));
//    min min(.inputA(Amin), .inputB(twenty), .out(Amax));
    
    exponent expA(.inputA(inputA), .inputB(zero), .out(exponentA));
    flip flip(.inputA(inputA), .inputB(zero), .out(minusA));
    exponent expMinusA(.inputA(minusA), .inputB(zero), .out(exponentMinusA));
    
    substract substractNum(.inputA(exponentA), .inputB(exponentMinusA), .out(numerator));
    sum sumDenom(.inputA(exponentA), .inputB(exponentMinusA), .out(denominator));
    
    divide divide(.inputA(numerator), .inputB(denominator), .out(out));
    
//    always_comb begin
//        $display("Amax: ", $bitstoshortreal(Amax));
//        $display("exponentA: ", $bitstoshortreal(exponentA));
//        $display("exponentMinusA: ", $bitstoshortreal(exponentMinusA));
//        $display("numerator: ", $bitstoshortreal(numerator));
//        $display("denominator: ", $bitstoshortreal(denominator));
//        $display("result: ", $bitstoshortreal(result));
//    end
endmodule
