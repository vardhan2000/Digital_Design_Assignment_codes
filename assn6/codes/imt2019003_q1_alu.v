//if select line s=00101, out=a+b
//if s=00110, out= a-b;
//if s=01000, a*b
//01011 --> a/b


module alu (a,b,s,out);/* port list is incomplete. 'clk' is missing. */
input [39:0] a,b;
input [4:0] s;
input clk;
reg [39:0] c,d;/* these 2 variables are neither used nor needed anywhere. */
output [39:0]out;/* out also has to store value. Hence, 'reg' keyword should be added after 'output' */

reg i;/* 'i' is neither used nor needed anywhere. */

always @ (posedge clk)
begin
if (s==5'b00101)
out = a+b;
else if (s==5'b1000)/* since it's a 5 bit value. It should be passed as 01000 instead of 1000. */
begin/* no need of 'begin' keyword here. Remove it to avoid ambiguity. */
out= a*b;
else if (s==5'b00110)
out = a-b;
else if (s==5'b01011)
out = a/b;
end
endmodule


`timescale 1ns/1ps
module alu_test;
reg [39:0]a,b;
reg clk;
reg [4:0]select;
wire out;/* out has to be passed as a 40 bit value. Hence, a vector should be added after 'wire' keyword. */
alu uut (a,b,out,select);/* the uut port list is incomplete. 'clk' should be added at the end. Also the parametres 'select' and 'out' should be interchanged*/
initial
begin
$dumpfile("alua.vcd");
$dumpvars(0, alu_test);
a= 40'h000000000b;
b= 40'h0000000003;
clk=0;
s= 5'b00101;/* wrong variable name. It should be 'select' instead of 's'. */
end

always
begin
#3 clk=~clk;
end

always
begin

/* Wrong variable names in the below 4 lines. 'select' should be used instead of 's'. */
s = 5'b00111;
#10 s = 5'b00110;
#10 s = 5'b01000;
#10 s = 5'b01011;
end

endmodule
