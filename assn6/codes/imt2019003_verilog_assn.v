`timescale 1ns/1ps

//mealy_fsm module
module mealy_fsm (input_A, clk, output_Y, reset);
input input_A, clk, reset;
output reg output_Y;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

reg [1:0] current_state;

always @(posedge clk, posedge reset)
begin

  if(reset) begin
    current_state <= S0;
    output_Y <= 0;
    end

  else begin
    case(current_state)
    S0: begin
        if(input_A) begin
          current_state <= S2;
          output_Y <= 0;
          end

        else begin
          current_state <= S1;
          output_Y <= 0;
          end
        end

    S1: begin
        if(input_A) begin
          current_state <= S2;
          output_Y <= 1;
          end

        else begin
          current_state <= S1;
          output_Y <= 0;
          end
        end

    S2: begin
        if(input_A) begin
          current_state <= S2;
          output_Y <= 0;
          end

        else begin
          current_state <= S1;
          output_Y <= 1;
          end
        end

    default:begin
            current_state <= S0;
            output_Y <= 0;
            end
    endcase
  end
end
endmodule // mealy_fsm

//Testbench for the mealy_fsm.
module mealy_fsmtb;

wire Y;
reg A, rst, clock;

mealy_fsm uut (A, clock, Y, rst);

  initial begin

    $dumpfile ("mealy_fsm_out.vcd");
    $dumpvars(0,mealy_fsmtb);

    //These initial statements are very important- without which the next always block
    //will not work

    rst = 1;
    clock = 0;
    #50

    //each test case for input-output has been covered below
    rst = 0;  A = 0;  #10;
    rst = 0;  A = 0;  #10;
    rst = 0;  A = 1;  #10;
    rst = 0;  A = 1;  #10;
    rst = 0;  A = 0;  #10;
    rst = 1;  A = 1;  #10;
    rst = 0;  A = 1;  #10;

  end

always
#5 clock=~clock;

endmodule
