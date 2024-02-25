`timescale 1ns / 1ps

module square_root(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic [31:0] half;
    assign half = 32'b00111111000000000000000000000000;
    power power(.inputA(inputA), .inputB(half), .out(out));
endmodule
