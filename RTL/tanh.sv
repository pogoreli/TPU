`timescale 1ns / 1ps

module tanh(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic[31:0] zero, one, minusOne, outMin, exponentA, minusA, exponentMinusA, numerator, denominator, result, rawOut;
    
    assign zero = 32'b00000000000000000000000000000000;
    assign one = 32'b00111111100000000000000000000000;
    assign minusOne = 32'b10111111100000000000000000000000;
   
    exponent expA(.inputA(inputA), .inputB(zero), .out(exponentA));
    flip flip(.inputA(inputA), .inputB(zero), .out(minusA));
    exponent expMinusA(.inputA(minusA), .inputB(zero), .out(exponentMinusA));
    
    substract substractNum(.inputA(exponentA), .inputB(exponentMinusA), .out(numerator));
    sum sumDenom(.inputA(exponentA), .inputB(exponentMinusA), .out(denominator));
    
    divide divide(.inputA(numerator), .inputB(denominator), .out(result));
    
    max max(.inputA(result), .inputB(minusOne), .out(outMin));
    min min(.inputA(outMin), .inputB(one), .out(rawOut));
    
    always_comb begin
        if(inputA == zero) begin
            out = zero;
        end else begin
            out = rawOut;
        end
    end
endmodule
