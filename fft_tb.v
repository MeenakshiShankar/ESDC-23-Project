`timescale 1ns/1ps
module testbench;
reg clk,rst_n,START,WRITE;
wire ready_sig;
reg [15:0] ip1_r,ip2_r,ip3_r,ip4_r,ip5_r,ip6_r,ip7_r,ip8_r,ip1_i,ip2_i,ip3_i,ip4_i,ip5_i,ip6_i,ip7_i,ip8_i;
wire signed [15:0] op1_r,op1_i,op2_r,op2_i,op3_r,op3_i,op4_r,op4_i,op5_r,op5_i,op6_r,op6_i,op7_r,op7_i,op8_r,op8_i;

dit_fft_8 u_DUT(.clk(clk),.rst_n(rst_n),.start(START),.write(WRITE),.ready(ready_sig),.in1r(ip1_r),.in2r(ip2_r),.in3r(ip3_r),.in4r(ip4_r),.in5r(ip5_r),.in6r(ip6_r),.in7r(ip7_r),.in8r(ip8_r),.in1i(ip1_i),.in2i(ip2_i),.in3i(ip3_i),.in4i(ip4_i),.in5i(ip5_i),.in6i(ip6_i),.in7i(ip7_i),.in8i(ip8_i),.y1r(op1_r),.y2r(op2_r),.y3r(op3_r),.y4r(op4_r),.y5r(op5_r),.y6r(op6_r),.y7r(op7_r),.y8r(op8_r),.y1i(op1_i),.y2i(op2_i),.y3i(op3_i),.y4i(op4_i),.y5i(op5_i),.y6i(op6_i),.y7i(op7_i),.y8i(op8_i));

initial
begin 
	ip1_r <= 16'b0000000000000000;
	ip1_i <= 16'b0000000000000000;
	ip2_r <= 16'b0000000100000000;
	ip2_i <= 16'b0000000000000000;
	ip3_r <= 16'b0000001000000000;
	ip3_i <= 16'b0000000000000000;
	ip4_r <= 16'b0000001100000000;
	ip4_i <= 16'b0000000000000000;
	ip5_r <= 16'b0000010000000000;
	ip5_i <= 16'b0000000000000000;
	ip6_r <= 16'b0000010100000000;
	ip6_i <= 16'b0000000000000000;
	ip7_r <= 16'b0000011000000000;
	ip7_i <= 16'b0000000000000000;
	ip8_r <= 16'b0000011100000000;
	ip8_i <= 16'b0000000000000000;
	
	clk = 0;
	rst_n = 1;
	#5
	rst_n = 0;
	#10 rst_n = 1;
	WRITE = 1'b1;
//	$display("%d",WRITE);
	#10 WRITE = 1'b0;
	#10 START = 1'b1;
	#10 START = 1'b0;
	#1110000 $finish; 
end

always begin
	#7 clk = ~clk;
end

initial
begin
	$dumpfile("fft_tb.vcd");
	$dumpvars(0,u_DUT);
//	$display("%b",clk);
//	$display("%b",rst_n);
//	$display("%b",ready_sig);
//	$display("%d,%d",ip1_r,ip1_i);
//	$display("%d,%d",op1_r,op1_i);
//	$display("%d,%d",op2_r,op2_i);
//	$display("%d,%d",op3_r,op3_i);
//	$display("%d,%d",op4_r,op4_i);
//	$display("%d,%d",op5_r,op5_i);
//	$display("%d,%d",op6_r,op6_i);
//	$display("%d,%d",op7_r,op7_i);
//	$display("%d,%d",op8_r,op8_i);
	
	$monitor("Time: %t \n op1_r = %b, op1_i = %b \n op2_r = %b, op2_i = %b \n op3_r = %b, op3_i = %b \n op4_r = %b, op4_i = %b \n op5_r = %b, op5_i = %b \n op6_r = %b, op6_i = %b \n op7_r = %b, op7_i = %b \n op8_r = %b, op8_i = %b \n ready = %b",$time,op1_r,op1_i,op2_r,op2_i,op3_r,op3_i,op4_r,op4_i,op5_r,op5_i,op6_r,op6_i,op7_r,op7_i,op8_r,op8_i,ready_sig);
	
	
end
endmodule
