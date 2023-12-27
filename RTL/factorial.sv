`timescale 1ns / 1ps

module factorial(
    output logic [30:0][31:0] out
    );
    logic [30:0][31:0] count;
    logic [31:0] one;
    
    genvar i;
    generate
        for (i = 2; i <= 30; i++) begin : power_calculation
            sum sum(.inputA(count[i-1]), .inputB(one), .out(count[i]));
            multiply multiply(.inputA(count[i]), .inputB(out[i-1]), .out(out[i]));
        end
    endgenerate
    
    always_comb begin
        out[0] = 32'b00111111100000000000000000000000;
        out[1] = 32'b00111111100000000000000000000000;
        
        count[0] = 32'b00000000000000000000000000000000;
        count[1] = 32'b00111111100000000000000000000000;
        
        one = 32'b00111111100000000000000000000000;
    end
endmodule
