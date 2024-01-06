`timescale 1ns / 1ps

module power(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic [31:0] naturalLog, multiple;
    
    ln ln(.inputA(inputA), .inputB(32'b0), .out(naturalLog));
    multiply multiply(.inputA(inputB), .inputB(naturalLog), .out(multiple));
    exponent exponent(.inputA(multiple), .inputB(32'b0), .out(out));
endmodule
