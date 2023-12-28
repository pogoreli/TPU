`timescale 1ns / 1ps

module substract_9bit(
    input logic[8:0] inputA, inputB,
    output logic [8:0] out
    );
    
    logic [8:0] minusB;
    
    flip_9bit flip(.inputA(inputB), .out(minusB));
    sum_9bit sum(.inputA(inputA), .inputB(minusB), .out(out));
endmodule
