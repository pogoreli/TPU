`timescale 1ns / 1ps

module int_power(
    input logic[31:0] inputA,
    output logic [30:0][31:0] out
    );
    
    genvar i;
    generate
        for (i = 2; i <= 30; i++) begin : power_calculation
            multiply multiply_inst(.inputA(inputA), .inputB(out[i-1]), .out(out[i]));
        end
    endgenerate
    
    always_comb begin
        out[0] = 32'b00111111100000000000000000000000;
        out[1] = inputA;
    end 
endmodule
