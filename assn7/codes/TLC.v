`timescale 1ns/1ps

//moore_fsm module
module moore_fsm (input_Ta, input_Tb, clk, La, Lb, reset);

input input_Ta, input_Tb, clk, reset;
output reg [1:0] La, Lb;

parameter S0 = 3'b000, S1 = 3'b010, S2 = 3'b011, S3 = 3'b100, S4 = 3'b101, S5 = 3'b110;
parameter red = 2'b00, yellow = 2'b01, green = 2'b10;

reg [2:0] current_state;

always @(posedge clk, posedge reset)
begin

  if(reset) begin
    current_state <= S0;
    La <= green;
    Lb <= red;
    end

  else begin
    case(current_state)
    S0: begin
        if(input_Ta) begin
          current_state <= S0;
          La <= green;
          Lb <= red;
        end

        else begin
          current_state <= S1;
          La <= yellow;
          Lb <= red;
          end
        end

    S1: begin
        current_state <= S2;
        La <= yellow;
        Lb <= red;
        end

    S2: begin
        current_state <= S3;
        La <= red;
        Lb <= green;
        end

    S3: begin
        if(input_Tb) begin
          current_state <= S3;
          La <= red;
          Lb <= green;
        end

        else begin
          current_state <= S4;
          La <= red;
          Lb <= yellow;
          end
        end

    S4: begin
        current_state <= S5;
        La <= red;
        Lb <= yellow;
        end

    S5: begin
        current_state <= S0;
        La <= green;
        Lb <= red;
        end
    default:begin
            current_state <= S0;
            La <= green;
            Lb <= red;
            end
    endcase
  end
end
endmodule // moore_fsm

//Testbench for the moore_fsm.
module moore_fsmtb;

wire [1:0] tb_La, tb_Lb;
reg rst, clock;
reg tb_Ta, tb_Tb;

moore_fsm uut (tb_Ta, tb_Tb, clock, tb_La, tb_Lb, rst);

  initial begin

    $dumpfile ("moore_fsm_out.vcd");
    $dumpvars(0,moore_fsmtb);

    //These initial statements are very important- without which the next always block
    //will not work

    rst = 1;
    clock = 0;
    #50

    //each test case for input-output has been covered below
    rst = 0;  tb_Ta = 1; tb_Tb = 0;  #10;
    rst = 0;  tb_Ta = 0; tb_Tb = 0;  #10;
    rst = 0;  tb_Ta = 0; tb_Tb = 1;  #10;
    rst = 0;  tb_Ta = 1; tb_Tb = 0;  #10;
    rst = 0;  tb_Ta = 0; tb_Tb = 1;  #10;
    rst = 0;  tb_Ta = 0; tb_Tb = 0;  #10;
    rst = 0;  tb_Ta = 1; tb_Tb = 1;  #10;
    rst = 0;  tb_Ta = 1; tb_Tb = 0;  #10;
    rst = 0;  tb_Ta = 0; tb_Tb = 0;  #10;



  end

always
#5 clock=~clock;

endmodule
