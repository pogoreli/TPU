`timescale 1ns / 1ps

module substract(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    
    logic [31:0] minusB;
    
    flip flip(.inputA(inputB), .out(minusB));
    sum sum(.inputA(inputA), .inputB(minusB), .out(out));
endmodule
