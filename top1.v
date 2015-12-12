`include "expnew.v"
`include "reg1.v"
`include "reg2.v"
`include "reg3.v"
`include "normalizer.v"
`include "round_norm.v"

module top(input clk,reset,start,output reg done);
reg [31:0]a,b;
reg [31:0]reg_file[0:95];
reg flag6[64:95];
integer read_ptr_a=0;
integer write_ptr=64;
integer i=0,j=0;
wire[31:0] c1;
wire e1;
wire ov,ov1,exception;
wire e2, eout;
wire sign,sign1,sign2;
wire[8:0] exp_1,exp_2,exp_4,exp_3;
wire[7:0] exp_c,exp_s,exp_t;
wire [47:0]prod,prod_1,prod_2,norm1,norm;
wire [31:0]c, cout;

exp1 x1 (start, a, b, reset,sign, exp_1 ,prod, exception);
reg1 r1 (sign,exp_1,prod,clk,reset,sign1,exp_2,prod_2);
norm_overflow n1 (start,prod_2, reset, exp_2, norm, exp_3, ov);
reg2 r2 (exp_3,norm,ov,sign1,clk,reset,exp_4,norm1,ov1,sign2);
round_norm n2 (start,sign2,norm1, exp_4, ov1,exception, reset, c,e2);
reg3 r3 (c,e2,clk,reset,c1,e1);

always @(posedge clk or negedge reset)
begin
	if(!reset)
		begin
			a<=32'h0000_0000;
			b<=32'h0000_0000;
			read_ptr_a<=0;
			write_ptr<=64;
			i<=0;
			done<=1'b0;
		end
	else if(write_ptr>95)
		begin
			done<=1'b1;
		end
	else if(start)
		begin
			done<=1'b0;
			read_ptr_a<=read_ptr_a+1;
			a<=reg_file[read_ptr_a];
			b<=reg_file[read_ptr_a+32];
			i<=i+1;
			j<=j+1;
		if(i>=4)
			begin
				reg_file[write_ptr]<=c1;
				flag6[write_ptr]<=e1;
				write_ptr<=write_ptr+1;
			end
		end
end
endmodule

