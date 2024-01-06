`timescale 1ns / 1ps

module alu_9bit(
    input logic [1:0] select,
    input logic [8:0] inputA, inputB,
    output logic [8:0] out
    );
    logic [8:0] outSum, outSubstract, outMin, outMax;
    
    sum_9bit sum(.inputA(inputA), .inputB(inputB), .out(outSum));
    substract_9bit substract(.inputA(inputA), .inputB(inputB), .out(outSubstract));
    min_9bit min(.inputA(inputA), .inputB(inputB), .out(outMin));
    max_9bit max(.inputA(inputA), .inputB(inputB), .out(outMax));
    mux_9bit mux(.select(select), .inputA(outSum), .inputB(outSubstract), .inputC(outMin), .inputD(outMax), .out(out));
    
    always_comb begin
//        $display("ALU. In A: %b", inputA, " Input B: %b", inputB, " select: %b", select, " output: %b", out);
    end
endmodule
