`timescale 1ns / 1ps

module exponent(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    logic [31:0] one, outSum;
    logic [30:0][31:0] powers, terms, sumOfTerms, factorialValues;
    
    factorial factorial(.out(factorialValues));
    assign one = 32'b00111111100000000000000000000000;
    int_power powersOfx(.inputA(inputA), .out(powers));

    assign sumOfTerms[0] = 32'b00000000000000000000000000000000;
    assign terms[0] = 32'b00000000000000000000000000000000;

    genvar i;
    generate
        for (i = 1; i <= 30; i++) begin
            divide divideTerms(.inputA(powers[i]), .inputB(factorialValues[i]), .out(terms[i]));
            sum sumTerms(.inputA(sumOfTerms[i-1]), .inputB(terms[i]), .out(sumOfTerms[i]));
        end
    endgenerate
   
    assign outSum = sumOfTerms[30];
    sum outputSum(.inputA(one), .inputB(outSum), .out(out));
    
        
//    always_comb begin
//        for(int i = 0; i <=30; i++) begin
//            $display("Terms: ", i, " : ", $bitstoshortreal(terms[i]));
//        end
//    end
    
endmodule