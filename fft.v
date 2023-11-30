//`timescale 1ns/1ps
module dit_fft_8(clk,rst_n,in1r,in1i,in2r,in2i,in3r,in3i,in4r,in4i,in5r,in5i,in6r,in6i,in7r,in7i,in8r,in8i,y1r,y1i,y2r,y2i,y3r,y3i,y4r,y4i,y5r,y5i,y6r,y6i,y7r,y7i,y8r,y8i,write,start,ready);
input clk,rst_n,write,start;
input [15:0] in1r,in2r,in3r,in4r,in5r,in6r,in7r,in8r;
input [15:0] in1i,in2i,in3i,in4i,in5i,in6i,in7i,in8i;

output [15:0] y1r,y2r,y3r,y4r,y5r,y6r,y7r,y8r,y1i,y2i,y3i,y4i,y5i,y6i,y7i,y8i;
output ready;
reg write_n,start_n,ready;

wire [15:0] in1r,in2r,in3r,in4r,in5r,in6r,in7r,in8r,in1i,in2i,in3i,in4i,in5i,in6i,in7i,in8i;
wire [15:0] y1r,y2r,y3r,y4r,y5r,y6r,y7r,y8r,y1i,y2i,y3i,y4i,y5i,y6i,y7i,y8i;

wire signed [15:0] inc1_r,inc2_r,inc3_r,inc4_r,inc5_r,inc6_r,inc7_r,inc8_r,inc1_i,inc2_i,inc3_i,inc4_i,inc5_i,inc6_i,inc7_i,inc8_i;


//wire signed [15:0] in21r,in21i,in22r,in22i,in23r,in23i,in24r,in24i,in25r,in25i,in26r,in26i,in27r,in27i,in28r,in28i;

reg signed [15:0] in11r,in11i,in12r,in12i,in13r,in13i,in14r,in14i,in15r,in15i,in16r,in16i,in17r,in17i,in18r,in18i;

wire [15:0] f1r,f1i,f2r,f2i,f3r,f3i,f4r,f4i,f5r,f5i,f6r,f6i,f7r,f7i,f8r,f8i;
reg signed [15:0]  m1r,m1i,m2r,m2i,m3r,m3i,m4r,m4i,m5r,m5i,m6r,m6i,m7r,m7i,m8r,m8i;
//wire signed [15:0] n0r,n0i,n1r,n1i,n2r,n2i,n3r,n3i,n4r,nri,n5r,n5i,n6r,n6i,n7r,n7i;
reg signed [15:0]  n1r,n1i,n2r,n2i,n3r,n3i,n4r,n4i,n5r,n5i,n6r,n6i,n7r,n7i,n8r,n8i;
wire signed [15:0] twi_1r,twi_1i,twi_2r,twi_2i,twi_3r,twi_3i,twi_4r,twi_4i,twi_5r,twi_5i,twi_6r,twi_6i,twi_7r,twi_7i,twi_8r,twi_8i;



two_comp c0i(in1i,in2i,in3i,in4i,in5i,in6i,in7i,in8i,inc1_i,inc2_i,inc3_i,inc4_i,inc5_i,inc6_i,inc7_i,inc8_i);
two_comp c0r(in1r,in2r,in3r,in4r,in5r,in6r,in7r,in8r,inc1_r,inc2_r,inc3_r,inc4_r,inc5_r,inc6_r,inc7_r,inc8_r);


inv_comp d0r(n1r,n2r,n3r,n4r,n5r,n6r,n7r,n8r,f1r,f2r,f3r,f4r,f5r,f6r,f7r,f8r);
inv_comp d0i(n1i,n2i,n3i,n4i,n5i,n6i,n7i,n8i,f1i,f2i,f3i,f4i,f5i,f6i,f7i,f8i);


bfly_stage4 S0(m1r,m1i,m3r,m3i,m5r,m5i,m7r,m7i,twi_1r,twi_1i,twi_2r,twi_2i,twi_3r,twi_3i,twi_4r,twi_4i);
bfly_stage4 S1(m2r,m2i,m4r,m4i,m6r,m6i,m8r,m8i,twi_5r,twi_5i,twi_6r,twi_6i,twi_7r,twi_7i,twi_8r,twi_8i);
//twi_inc t0(tw_1r,tw_1i,tw_2r,tw_2i,tw_3r,tw_3i,tw_4r,tw_4i,tw_5r,tw_5i,tw_6r,tw_6i,tw_7r,tw_7i,tw_8r,tw_8i,n1r,n1i,n2r,n2i,n3r,n3i,n4r,n4i,n5r,n5i,n6r,n6i,n7r,n7i,n8r,n8i);


assign y1r = f1r;
assign y2r = f2r;
assign y3r = f3r;
assign y4r = f4r;
assign y5r = f5r;
assign y6r = f6r;
assign y7r = f7r;
assign y8r = f8r;

assign y1i = f1i;
assign y2i = f2i;
assign y3i = f3i;
assign y4i = f4i;
assign y5i = f5i;
assign y6i = f6i;
assign y7i = f7i;
assign y8i = f8i;


always@(posedge clk) begin
if (~rst_n) begin
	ready <=1'b0;
end
else begin
	write_n <= write;
	start_n <= start;
	
	       
        if (start_n) begin
		n1r <= twi_1r + twi_5r;
		n1i <= twi_1i + twi_5i;

		n2i <= twi_2i - ((twi_6r>>>1)+(twi_6r>>>2)-(twi_6r>>>4)+(twi_6r>>>5)-(twi_6r>>>6)+(twi_6r>>>7)-(twi_6r>>>8)) + ((twi_6i>>>1)+(twi_6i>>>2)-(twi_6i>>>4)+(twi_6i>>>5)-(twi_6i>>>6)+(twi_6i>>>7)-(twi_6i>>>8)) ;

 		n2r <= twi_2r + ((twi_6r>>>1)+(twi_6r>>>2)-(twi_6r>>>4)+(twi_6r>>>5)-(twi_6r>>>6)+(twi_6r>>>7)-(twi_6r>>>8)) + ((twi_6i>>>1)+(twi_6i>>>2)-(twi_6i>>>4)+(twi_6i>>>5)-(twi_6i>>>6)+(twi_6i>>>7)-(twi_6i>>>8))   ;

		n3r <= twi_3r + twi_7i;
 		n3i <= twi_3i - twi_7r;


 		n4r <= twi_4r + ((twi_8i>>>1)+(twi_8i>>>2)-(twi_8i>>>4)+(twi_8i>>>5)-(twi_8i>>>6)+(twi_8i>>>7)-(twi_8i>>>8)) - ((twi_8r>>>1)+(twi_8r>>>2)-(twi_8r>>>4)+(twi_8r>>>5)-(twi_8r>>>6)+(twi_8r>>>7)-(twi_8r>>>8)) ;

 		n4i <= twi_4i - ((twi_8i>>>1)+(twi_8i>>>2)-(twi_8i>>>4)+(twi_8i>>>5)-(twi_8i>>>6)+(twi_8i>>>7)-(twi_8i>>>8)) - ((twi_8r>>>1)+(twi_8r>>>2)-(twi_8r>>>4)+(twi_8r>>>5)-(twi_8r>>>6)+(twi_8r>>>7)-(twi_8r>>>8)) ;


 		n5r <= twi_1r - twi_5r;
		n5i <= twi_1i - twi_5i;


		n6i <= twi_2i + ((twi_6r>>>1)+(twi_6r>>>2)-(twi_6r>>>4)+(twi_6r>>>5)-(twi_6r>>>6)+(twi_6r>>>7)-(twi_6r>>>8)) - ((twi_6i>>>1)+(twi_6i>>>2)-(twi_6i>>>4)+(twi_6i>>>5)-(twi_6i>>>6)+(twi_6i>>>7)-(twi_6i>>>8)) ;

		n6r <= twi_2r - ((twi_6i>>>1)+(twi_6i>>>2)-(twi_6i>>>4)+(twi_6i>>>5)-(twi_6i>>>6)+(twi_6i>>>7)-(twi_6i>>>8)) - ((twi_6r>>>1)+(twi_6r>>>2)-(twi_6r>>>4)+(twi_6r>>>5)-(twi_6r>>>6)+(twi_6r>>>7)-(twi_6r>>>8)) ;

 		n7r <= twi_3r - twi_7i;
		n7i <= twi_3i + twi_7r;



		n8r <= twi_4r - ((twi_8i>>>1)+(twi_8i>>>2)-(twi_8i>>>4)+(twi_8i>>>5)-(twi_8i>>>6)+(twi_8i>>>7)-(twi_8i>>>8)) + ((twi_8r>>>1)+(twi_8r>>>2)-(twi_8r>>>4)+(twi_8r>>>5)-(twi_8r>>>6)+(twi_8r>>>7)-(twi_8r>>>8)) ;

 		n8i <= twi_4i + ((twi_8i>>>1)+(twi_8i>>>2)-(twi_8i>>>4)+(twi_8i>>>5)-(twi_8i>>>6)+(twi_8i>>>7)-(twi_8i>>>8)) + ((twi_8r>>>1)+(twi_8r>>>2)-(twi_8r>>>4)+(twi_8r>>>5)-(twi_8r>>>6)+(twi_8r>>>7)-(twi_8r>>>8)) ;
        	
        	  
        	ready <= 1'b1;
        end
        else begin
        if (write_n) begin
        	m1r <= inc1_r;
        	m2r <= inc2_r;
        	m3r <= inc3_r;
        	m4r <= inc4_r;
        	m5r <= inc5_r;
        	m6r <= inc6_r;
        	m7r <= inc7_r;
        	m8r <= inc8_r;
        	
        
        	m1i <= inc1_i;
        	m2i <= inc2_i;
        	m3i <= inc3_i;
        	m4i <= inc4_i;
        	m5i <= inc5_i;
        	m6i <= inc6_i;
        	m7i <= inc7_i;
        	m8i <= inc8_i;
        end
        ready <= 1'b0;
end
end
end
endmodule
        	



	
module bfly_stage4(a1_r,a1_i,a2_r,a2_i,a3_r,a3_i,a4_r,a4_i,inX1r,inX1i,inX2r,inX2i,inX3r,inX3i,inX4r,inX4i);
input [15:0] a1_r,a1_i,a2_r,a2_i,a3_r,a3_i,a4_r,a4_i;
output [15:0] inX1r,inX1i,inX2r,inX2i,inX3r,inX3i,inX4r,inX4i;

wire signed [15:0] a1_r,a1_i,a2_r,a2_i,a3_r,a3_i,a4_r,a4_i;
wire signed [15:0] inX1r,inX1i,inX2r,inX2i,inX3r,inX3i,inX4r,inX4i;


assign inX1r = a1_r + a2_r + a3_r + a4_r;
assign inX1i = a1_i + a2_i + a3_i + a4_i;


//assign inX2r = a1_r - a2_i - a3_r - a4_i;
//assign inX2i = a1_i + a2_r - a3_i - a4_r;

//assign inX2i = a1_i + a2_r - a3_i - a4_r;
//assign inX2r = a1_r + a2_i - a3_r - a4_i;

//assign inX2i = a1_i + a2_r - a3_i - a4_r;
//assign inX2r = a1_r + a2_i - a3_r - a4_i;


assign inX2i = a1_i - a2_r - a3_i + a4_r;
assign inX2r = a1_r + a2_i - a3_r - a4_i;


assign inX3r = a1_r - a2_r + a3_r - a4_r;
assign inX3i = a1_i - a2_i + a3_i - a4_i;


assign inX4r = a1_r - a2_i - a3_r + a4_i;
assign inX4i = a1_i + a2_r - a3_i - a4_r ;

endmodule


module two_comp(ip1,ip2,ip3,ip4,ip5,ip6,ip7,ip8,op1,op2,op3,op4,op5,op6,op7,op8);
	input [15:0] ip1,ip2,ip3,ip4,ip5,ip6,ip7,ip8;
	output [15:0] op1,op2,op3,op4,op5,op6,op7,op8;
	
	
	reg  [15:0] op1,op2,op3,op4,op5,op6,op7,op8;
	reg  [14:0] val;
	
	always @* begin
	if (ip1[15]== 1) begin
		val = ~(ip1)+1'b1;
		op1 = {1'b1,val};
	end
	else begin
		op1 <= ip1;
	end
	if (ip2[15]== 1) begin
		val = ~(ip2)+1'b1;
		op2 = {1'b1,val};
		
	end
	else begin
		op2 <= ip2;
	end
	if (ip3[15]== 1) begin
		val = ~(ip3)+1'b1;
		op3 = {1'b1,val};
		
	end
	else begin
		op3 <= ip3;
	end
	if (ip4[15]== 1) begin
		val = ~(ip4)+1'b1;
		op4 = {1'b1,val};

	end
	else begin
		op4 <= ip4;
	end
	if (ip5[15]== 1) begin
		val = ~(ip5)+1'b1;
		op5 = {1'b1,val};

	end
	else begin
		op5 <= ip5;
	end
	if (ip6[15]== 1) begin
		val = ~(ip6)+1'b1;
		op6 = {1'b1,val};
	end
	else begin
		op6 <= ip6;
	end
	if (ip7[15]== 1) begin
		val = ~(ip7)+1'b1;
		op7 = {1'b1,val};

	end
	else begin
		op7 <= ip7;
	end
	if (ip8[15]== 1) begin
		val = ~(ip8)+1'b1;
		op8 = {1'b1,val};
	end
	else begin
		op8 <= ip8;
	end
	end
endmodule




module inv_comp(ip1,ip2,ip3,ip4,ip5,ip6,ip7,ip8,op1,op2,op3,op4,op5,op6,op7,op8);
	input [15:0] ip1,ip2,ip3,ip4,ip5,ip6,ip7,ip8;
	output [15:0] op1,op2,op3,op4,op5,op6,op7,op8;
	
	wire signed [15:0] ip1,ip2,ip3,ip4,ip5,ip6,ip7,ip8;
	reg  [15:0] op1,op2,op3,op4,op5,op6,op7,op8;
	reg  [14:0] val;
	
	always @* begin
	if (ip1[15]== 1) begin
		val = ip1-1;
		op1 = {1'b1,~val};
	end
	else begin
		op1 <= ip1;
	end
	if (ip2[15]== 1) begin
		val = ip2-1;
		op2 = {1'b1,~val};
		
	end
	else begin
		op2 <= ip2;
	end
	if (ip3[15]== 1) begin
		val = ip3-1;
		op3 = {1'b1,~val};
		
	end
	else begin
		op3 <= ip3;
	end
	if (ip4[15]== 1) begin
		val = ip4-1;
		op4 = {1'b1,~val};

	end
	else begin
		op4 <= ip4;
	end
	if (ip5[15]== 1) begin
		val = ip5-1;
		op5 = {1'b1,~val};

	end
	else begin
		op5 <= ip5;
	end
	if (ip6[15]== 1) begin
		val = ip6-1;
		op6 = {1'b1,~val};
	end
	else begin
		op6 <= ip6;
	end
	if (ip7[15]== 1) begin
		val = ip7-1;
		op7 = {1'b1,~val};

	end
	else begin
		op7 <= ip7;
	end
	if (ip8[15]== 1) begin
		val = ip8-1;
		op8 = {1'b1,~val};
	end
	else begin
		op8 <= ip8;
	end
	end
endmodule





