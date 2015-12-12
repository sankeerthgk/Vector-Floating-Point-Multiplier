module reg1 (sign,exp_1,prod,clk,reset,sign1,exp_2,prod_2);
input sign,clk,reset;
input [8:0]exp_1;
input [47:0]prod;
output reg sign1;
output reg [8:0]exp_2;
output reg [47:0]prod_2;

always@ (posedge clk or negedge reset)
begin
		if (!reset)
		begin
				sign1 <= 0;
				exp_2 <= 0;
				prod_2 <= 0;
		end
		
	else
		begin
				sign1 <= sign;
				exp_2 <= exp_1;
				prod_2 <= prod;
		end
end
endmodule
