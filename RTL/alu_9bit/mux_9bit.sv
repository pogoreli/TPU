`timescale 1ns / 1ps

module mux_9bit(
    input logic [1:0] select,
    input logic [8:0] inputA, inputB, inputC, inputD,
    output logic [8:0] out
    );
    
    always_comb begin
        case (select)
            2'b00: out = inputA;
            2'b01: out = inputB;
            2'b10: out = inputC;
            2'b11: out = inputD;
        endcase
    end
endmodule
