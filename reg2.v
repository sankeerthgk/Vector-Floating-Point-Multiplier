module reg2 (exp_3,norm,ov,sign1,clk,reset,exp_4,norm1,ov1,sign2);
input ov,clk,reset,sign1;
input [8:0]exp_3;
input [47:0]norm;
output reg ov1,sign2;
output reg [8:0]exp_4;
output reg [47:0]norm1;

always@ (posedge clk or negedge reset)
begin
		if (!reset)
		begin
				ov1 <= 0;
				exp_4 <= 0;
				norm1 <= 0;
				sign2<=0;
		end
		
	else
		begin
				ov1 <= ov;
				exp_4 <= exp_3;
				norm1 <= norm;
				sign2 <= sign1;
		end
end
endmodule
