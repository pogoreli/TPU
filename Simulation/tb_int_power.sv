`timescale 1ns / 1ps


module tb_int_power;
    logic [31:0] inputA;
    logic [50:0][31:0] out;
    
    int_power uut (.inputA(inputA), .out(out));

    initial begin
        inputA = 32'b01000000000000000000000000000000;
        #10;
        $display("Test 1: 2 =  %b", inputA);   
        
        inputA = 32'b01000000010000000000000000000000;
        #10;
        $display("Test 2: 3 =  %b", inputA); 
        
        inputA = 32'b01000000001000000000000000000000;
        #10;
        $display("Test 3: 2.5 =  %b", inputA); 
     end
endmodule
