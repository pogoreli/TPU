`timescale 1ns / 1ps

module tb_adjustForLn;
    logic [31:0] inputA;
    logic [31:0] n, x;
    
    shortreal tolerance = 0.001;
    shortreal A;
    shortreal expectedN;
    shortreal expectedX;
    shortreal diffN;
    shortreal diffX;
    logic passed;
    
    int numberOfTests;
    int numberOfSuccessfullTests;

    // Instantiate the multiply module
    adjustForLn uut (.inputA(inputA), .n(n), .x(x));
    
    // Convert a floating-point number to its IEEE 754 representation
    function automatic [31:0] real_to_ieee(real value);
        real_to_ieee = $shortrealtobits(value);
    endfunction
    
    function shortreal absolute(shortreal value);
        return (value < 0.0) ? -value : value;
    endfunction
    
    function shortreal random_shortreal();
        shortreal num;
        shortreal denum;
        num = shortreal($urandom_range(1, 10000));
        denum = shortreal($random);
        $display("num ", num, " denum ", denum);
        random_shortreal = num / denum;
    endfunction

    initial begin
        A = 0.5;
        expectedN = 0;
        expectedX = 0.5;
        inputA = real_to_ieee(A);
        #10;
        diffN = absolute(($bitstoshortreal(n)) - expectedN);
        diffX = absolute(($bitstoshortreal(x)) - expectedX);
        passed = (diffN < tolerance) && (diffX < tolerance);
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 1: n=", $bitstoshortreal(n), "  x=", $bitstoshortreal(x), " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 2;
        expectedN = 1.0;
        expectedX = 1.0;
        inputA = real_to_ieee(A);
        #10;
        diffN = absolute(($bitstoshortreal(n)) - expectedN);
        diffX = absolute(($bitstoshortreal(x)) - expectedX);
        passed = (diffN < tolerance) && (diffX < tolerance);
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 2: n=", $bitstoshortreal(n), "  x=", $bitstoshortreal(x), " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 5;
        expectedN = 2.0;
        expectedX = 1.25;
        inputA = real_to_ieee(A);
        #10;
        diffN = absolute(($bitstoshortreal(n)) - expectedN);
        diffX = absolute(($bitstoshortreal(x)) - expectedX);
        passed = (diffN < tolerance) && (diffX < tolerance);
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 3: n=", $bitstoshortreal(n), "  x=", $bitstoshortreal(x), " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 100;
        expectedN = 6.0;
        expectedX = 1.5625;
        inputA = real_to_ieee(A);
        #10;
        diffN = absolute(($bitstoshortreal(n)) - expectedN);
        diffX = absolute(($bitstoshortreal(x)) - expectedX);
        passed = (diffN < tolerance) && (diffX < tolerance);
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 4: n=", $bitstoshortreal(n), "  x=", $bitstoshortreal(x), " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 950;
        expectedN = 9.0;
        expectedX = 1.85546875;
        inputA = real_to_ieee(A);
        #10;
        diffN = absolute(($bitstoshortreal(n)) - expectedN);
        diffX = absolute(($bitstoshortreal(x)) - expectedX);
        passed = (diffN < tolerance) && (diffX < tolerance);
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 5: n=", $bitstoshortreal(n), "  x=", $bitstoshortreal(x), " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
   

        $display("Passed ", numberOfSuccessfullTests, " out of ", numberOfTests, " tests");
        
        end
endmodule