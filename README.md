# Booth_multiplier
Designed a signed 8-bit sequential multiplier using Booth’s algorithm in Verilog. The system uses a state machine and arithmetic right shifts to compute a 16-bit signed product over 8 cycles. Includes a testbench for validation with multiple signed input cases.
sequence of events :

 8bit Signed Sequential Booth Multiplier (Verilog)

 Description

This project implements a   signed 8bit multiplier   using the   Booth's algorithm  , written in Verilog HDL. It supports 2's complement inputs and produces a 16bit signed product. The multiplication is performed sequentially over 8 clock cycles with a control state machine.



 Features

 Signed multiplication using Booth's algorithm
 8bit multiplicand and multiplier inputs
 16bit signed output product
 Sequential operation with clocked FSM
 Onecycle  valid  signal to indicate result readiness
 Fully testbenched with various edge cases



 Files

 File              Description                                  

  mul.v       RTL module for 8bit signed Booth multiplier 
  mul_tb.v    Testbench for functional simulation          
  README.md        Project overview and usage guide             



 How It Works

1.   Inputs:  
     X  and  Y : 8bit signed operands
     start : Begins multiplication
     reset : Resets the system
     clk : Clock signal
2.   Output:  
     Z : 16bit signed product
     valid : High for one cycle when multiplication is done

3.   Operation:  
    Based on Booth’s algorithm
    Uses 2bit Booth encoding at each cycle
    Performs an arithmetic right shift after each step
    Completes in 8 clock cycles



