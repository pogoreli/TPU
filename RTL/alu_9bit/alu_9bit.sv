`timescale 1ns / 1ps

module alu_9bit(
    input logic select,
    input logic [8:0] inputA, inputB,
    output logic [8:0] out
    );
    logic [8:0] outSum, outSubstract;
    
    sum_9bit sum(.inputA(inputA), .inputB(inputB), .out(outSum));
    substract_9bit substract(.inputA(inputA), .inputB(inputB), .out(outSubstract));
    mux_9bit mux(.select(select), .inputA(outSum), .inputB(outSubstract), .out(out));
endmodule
