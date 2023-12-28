`timescale 1ns / 1ps

module flip_9bit(
    input logic [8:0] inputA,
    output logic [8:0] out
    );
    
    always_comb begin
        out = {~inputA[8], inputA[7:0]};
    end
endmodule
