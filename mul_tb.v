`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2025 23:58:38
// Design Name: 
// Module Name: mul_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module mul_tb;

    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg signed [7:0] X, Y;

    // Outputs
    wire signed [15:0] Z;
    wire valid;

    // the multiplier
    mul uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .X(X),
        .Y(Y),
        .Z(Z),
        .valid(valid)
    );

    // Clock 
    always #5 clk = ~clk;

    //  apply stimulus
    task test_case(input signed [7:0] a, input signed [7:0] b);
        begin
            @(negedge clk);
            start = 1;
            X = a;
            Y = b;
            @(negedge clk);
            start = 0;

            // valid signal
            wait(valid == 1);
            $display("X = %d, Y = %d, Z = %d (Expected = %d)", a, b, Z, a * b);
            if (Z !== (a * b))
                $display(" ERROR: Incorrect result!");
            else
                $display("PASS");
        end
    endtask

    initial begin
        $display(" 8-bit Booth Multiplier Test ");
        clk = 0;
        reset = 0;
        start = 0;
        X = 0;
        Y = 0;

        // reset
        #20;
        reset = 1;

        // test cases
        test_case(8'd5, 8'd3);      // 5 * 3 = 15
        test_case(-8'd6, 8'd2);     // -6 * 2 = -12
        test_case(8'd15, -8'd4);    // 15 * -4 = -60
        test_case(-8'd7, -8'd7);    // -7 * -7 = 49
        test_case(8'd0, 8'd127);    // 0 * 127 = 0
        test_case(8'd127, 8'd1);    // 127 * 1 = 127
        test_case(8'd100, -8'd1);   // 100 * -1 = -100
        test_case(-8'd128, 8'd1);   // -128 * 1 = -128

        #100;
        $finish;
    end

endmodule

