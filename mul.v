`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: self
// Engineer: SURAJ
// 
// Create Date: 29.06.2025 23:17:43
// Design Name:  
// Module Name: mul
// Project Name: 8 bit booth multiplier
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


module mul (
    input clk,
    input reset,
    input start,
    input signed [7:0] X, Y,
    output reg signed [15:0] Z,
    output reg valid
);

    // register we needed
    reg signed [15:0] next_Z, Z_temp; //storing two outputs
    reg [3:0] count, next_count; //counting iterations
    reg [1:0] booth_pair, next_booth_pair; // paired form
    reg pres_state, next_state; //

    parameter IDLE = 1'b0, START = 1'b1;

    // Sequential logic dataset
    always @(posedge clk or negedge reset) begin //Two initial set
        if (!reset) begin
            Z <= 16'd0;
            valid <= 1'b0;
            count <= 4'd0;
            booth_pair <= 2'd0;
            pres_state <= IDLE;
        end else begin
            Z <= next_Z;
            valid <= (next_state == IDLE && pres_state == START); // One-cycle valid
            count <= next_count;
            booth_pair <= next_booth_pair;
            pres_state <= next_state;
        end
    end

    // Combinational logic
    always @(*) begin
        next_Z = Z;
        next_count = count;
        next_booth_pair = booth_pair;
        next_state = pres_state;

        case (pres_state)
            IDLE: begin
                next_count = 4'd0;
                next_booth_pair = {X[0], 1'b0};     // x0 and  Qminus 1
                next_Z = {8'd0, X};                 // partial product initially
                if (start)
                    next_state = START;
                else
                    next_state = IDLE;
            end

            START: begin
                // Booth encoding
                case (booth_pair) //comparator
                    2'b01: Z_temp = {Z[15:8] + Y, Z[7:0]}; 
                    2'b10: Z_temp = {Z[15:8] - Y, Z[7:0]};
                    default: Z_temp = Z;
                endcase

                next_Z = Z_temp >>> 1; // arithmetic shift right

                if (count < 4'd7) begin 
                    next_booth_pair = {X[count + 1], X[count]};
                    next_count = count + 1;
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
