`timescale 1ns / 1ps

module sigmoid(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic [31:0] zero, one, exp, expPlusOne, rawOut, rawOutMin;
    assign zero = 32'b00000000000000000000000000000000;
    assign one = 32'b00111111100000000000000000000000;
    
    exponent exponent(.inputA(inputA), .inputB(zero), .out(exp));
    sum sum(.inputA(exp), .inputB(one), .out(expPlusOne));
    divide divide(.inputA(exp), .inputB(expPlusOne), .out(rawOut));
    max max(.inputA(rawOut), .inputB(zero), .out(rawOutMin));
    min min(.inputA(rawOutMin), .inputB(one), .out(out));
endmodule
