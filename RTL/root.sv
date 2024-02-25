`timescale 1ns / 1ps

module root(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic [31:0] one, powerOfNumber;
    assign one = 32'b00111111100000000000000000000000;
    divide divide(.inputA(one), .inputB(inputA), .out(powerOfNumber));
    power power(.inputA(inputB), .inputB(powerOfNumber), .out(out));
endmodule
