`timescale 1ns / 1ps

module tb_flip_9bit;
    logic [8:0] inputA;
    logic [8:0] out;

    logic [8:0] A;
    logic [8:0] expected;
    
    flip_9bit uut (.inputA(inputA), .out(out));
    
    initial begin
        A = 9'b000000011;
        expected = 9'b100000011;
        inputA = A;
        #10;
        $display("A value is %d", inputA);
        $display("Test 1: 3 = %d", out);
        
        A = 9'b100000011;
        expected = 9'b000000011;
        inputA = A;
        #10;
        $display("A value is %d", inputA);
        $display("Test 2: -3 = %d", out);  
    end
endmodule
