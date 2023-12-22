`timescale 1ns / 1ps

module tb_flip;
    logic [31:0] inputA;
    logic [31:0] out;
    
    flip uut (.inputA(inputA), .out(out));
    
    function automatic [31:0] real_to_ieee(real value);
        real_to_ieee = $shortrealtobits(value);
    endfunction
    
    function shortreal absolute(shortreal value);
        return (value < 0.0) ? -value : value;
    endfunction
    
    shortreal tolerance = 0.001;
    shortreal A;
    shortreal expected;
    shortreal diff;
    logic passed;
    
    int numberOfTests;
    int numberOfSuccessfullTests;
    
    initial begin
        // Test with both numbers positive
        A = 3.5;
        expected = -1 * A;
        inputA = real_to_ieee(A);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;

        $display("Test 1: 3.5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        $display("Test 1: 3.5 = ", $bitstoshortreal(out));

        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = -3.5;
        expected = -1 * A;
        inputA = real_to_ieee(A);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 2: -3.5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 0;
        expected = -1 * A;
        inputA = real_to_ieee(A);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 3: 0 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
     end   
endmodule

