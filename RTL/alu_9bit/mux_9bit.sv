`timescale 1ns / 1ps

module mux_9bit(
    input logic select,
    input logic [8:0] inputA, inputB,
    output logic [8:0] out
    );
    
    always_comb begin
        if (select == 1'b0) begin
            out = inputA;
        end else begin
            out = inputB;
        end
    end
endmodule
