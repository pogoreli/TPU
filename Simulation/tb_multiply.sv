`timescale 1ns / 1ps

//http://weitz.de/ieee/

module tb_multiply;

    logic [31:0] inputA, inputB;
    logic [31:0] out;
    
    shortreal tolerance = 0.0000000001;
    shortreal A;
    shortreal B;
    shortreal expected;
    shortreal diff;
    logic passed;
    
    int numberOfTests;
    int numberOfSuccessfullTests;

    // Instantiate the multiply module
    multiply uut (.inputA(inputA), .inputB(inputB), .out(out));
    
    // Convert a floating-point number to its IEEE 754 representation
    function automatic [31:0] real_to_ieee(real value);
        real_to_ieee = $shortrealtobits(value);
//        $display("Real to ieee: %b", real_to_ieee);
    endfunction
    
    function shortreal absolute(shortreal value);
        return (value < 0.0) ? -value : value;
    endfunction
    
    function shortreal random_shortreal();
        shortreal num;
        shortreal denum;
        num = shortreal($urandom_range(1, 10000));
        denum = shortreal($random);
//        $display("num ", num, " denum ", denum);
        random_shortreal = num / denum;
    endfunction
    
//    function automatic [31:0] ieee_to_real(real value);
//        real_to_ieee = $bitstoshortreal(value);
//    endfunction

    // Test routine
    initial begin
        // Test with both numbers positive
        A = 3.5;
        B = 2.5;
        expected = A * B;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 1: 3.5 * 2.5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with one positive and one negative number
        A = -3.5;
        B = 2.5;
        expected = A * B;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 2: 3.5 * 2.5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with both numbers negative
        A = -3.5;
        B = -2.5;
        expected = A * B;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 3: -3.5 * -2.5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with large numbers
        A = -35001;
        B = 40015;
        expected = A * B;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 4: -3500.1 * 4001.5 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with small numbers
        A = 32'b00110101100001100011011110111101;
        B = 32'b00111111011111111111111101011000;
        expected = 9.9999E-7;
        inputA = A;
        inputB = B;
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 5: 0.00001 * 0.99999 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with small numbers
        A = -1.0000001;
        B = 2.0;
        expected = A * B;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 6: -1.0000001 * 2.0 = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        for (int i = 6; i <= 99; i++) begin
            A = random_shortreal();
            B = random_shortreal();
            expected = A * B;
            inputA = real_to_ieee(A);
            inputB = real_to_ieee(B);
            #10;
            diff = absolute(($bitstoshortreal(out)) - expected);
            passed = diff < tolerance;
            $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
            $display("Test ", i, ": ", A, "*", B, " = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
            numberOfTests++;
            numberOfSuccessfullTests += passed;
        
        end
        
        $display("Passed ", numberOfSuccessfullTests, " out of ", numberOfTests, " tests");
        
        $finish;
    end

endmodule