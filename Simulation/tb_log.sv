`timescale 1ns / 1ps



module tb_log;
    logic [31:0] inputA, inputB;
    logic [31:0] out;
    
    shortreal tolerance = 0.001;
    shortreal A;
    shortreal B;
    shortreal expected;
    shortreal diff;
    logic passed;
    
    int numberOfTests;
    int numberOfSuccessfullTests;

    // Instantiate the multiply module
    log uut (.inputA(inputA), .inputB(inputB), .out(out));
    
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
        // Test with both numbers positive
        A = 3;
        B = 5;
        expected = 1.4649735207;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 1: 3 and 5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with both numbers positive
        A = 3.5;
        B = 5.5;
        expected = 1.3607906165;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 2: 3.5 and 5.5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with one number positive and one number negative
        A = 0.3;
        B = 0.5;
        expected = 0.5757166425;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 3: 0.3 and 0.5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with one number positive and one number negative
        A = 10;
        B = 100;
        expected = 2;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 4: 10 and 100 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with both numbers negative
        A = 2;
        B = 8;
        expected = 3;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 5: 2 and 8 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        $display("Passed ", numberOfSuccessfullTests, " out of ", numberOfTests, " tests");
        
        end

endmodule
