`timescale 1ns / 1ps

module log(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic [31:0] lnA, lnB, zero;
    
    assign zero = 32'b00000000000000000000000000000000;
    
    ln nLnA(.inputA(inputA), .inputB(zero), .out(lnA));
    ln nLnB(.inputA(inputB), .inputB(zero), .out(lnB));
    divide divide(.inputA(lnB), .inputB(lnA), .out(out));
endmodule
