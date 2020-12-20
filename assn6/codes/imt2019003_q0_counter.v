//This is a Johnson counter
//0, 1, 3, 7, F, E, C, 8, 0, repeat

module dff(q,d,clk,reset);
output q;
input d,clk,reset;
reg q;

always@(posedge clk or reset)
begin
	if (reset==1) q=0;
	else q=d;
end
endmodule



module counter(q,reset,clk);
output [3:0]q;
input clk,reset;
reg w; /* w is not to be stored anywhere. It is to be PASSED as an output to the not gate. Hence 'wire' keyword should be used instead of 'reg'.*/

initial begin/* 'initial' statements are only used in testbenches. Hence, this 'begin' keyword is also not needed.*/
not n1 (q[3],w);/*the port list is not in order. Output(w) should come before the input(q[3])*/

/*the port lists for f1, f2, f3, f4 are not in order. the 'clk' should come before 'reset'*/

dff f1(q[0],w,reset,clk);
dff f2(q[1],q[0],reset,clk);
dff f3(q[2],q[1],reset,clk);
dff f4(q[3],q[2],reset,clk);


end/* since the above 'begin' keyword is not needed, so is this 'end' */
endmodule

`timescale 10ns/1ps
module tb_johnson;
    // Inputs
    reg clock;
     reg r;
    // Outputs
    wire Count_out;/* Count_out has to be passed as a 4 bit value. Hence, a vector should be added after 'wire' keyword.*/


//in this following notation you have to pass the signals in the same order
//as in the original module
counter uut (Count_out,clock,r);/* port list in uut is not in order. 'r' should come before 'clock'. */


//alternately, the following notation means that clk in the module connects to clock in the testbench.
//reset connects to r, and q to Count_out.
//In this notation, you can pass signals in any order, as you are explicitly mentioning
//the signal connections

//  counter uut ( .clk(clock),  .reset(r),.q(Count_out) );


initial begin


clk = 0;/* wrong vriable name. it should be 'clock' instead of 'clk'. */
r=1;
#50 r=0;  //reset=1 never shows up on the waveform -- why?
/* It is so because "dumpvars" statement comes below the line where we have assigned the reset to be 1. */

$dumpfile ("counter.vcd");
$dumpvars(0,counter_test);/*wrong name of testbench module in 'dumpvars'. It should be 'tb_johnson' instead of 'counter_test'. */

end

always
clk=~clk;/* wrong variable name. It should be 'clock' instead of 'clk' */


//initial #300 $finish;

endmodule
