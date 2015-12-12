module exp1 (start, a, b, reset,sign, exp ,product, exception);

input [31:0] a, b;
input reset, start;
reg[22:0] mantissa_a, mantissa_b;
output reg sign, exception;
output reg[8:0] exp; // 9 bits, including 8 bits for exponent, and 1 bit for overflow
output reg  [47:0]product;
reg [8:0] exp_sum;
reg [47:0] mantissa;
parameter bias = 8'd127;
reg [7:0] exp1, exp2;
reg sign1, sign2;


always@ (*)
begin
	if (!reset)
	begin
			exp = 0;
			sign = 0;
			product = 0;
			exception = 0;
			
	end
	else if(start)
	begin
			mantissa_a = a[22:0];
			mantissa_b = b[22:0];			
			exp1 = a[30:23];
			exp2 = b[30:23];
			sign1 = a[31];
			sign2 = b[31];
			exp_sum = exp1 + exp2 - bias;
			mantissa = {1'b1, mantissa_a} * {1'b1, mantissa_b};
			if (exp_sum >= 0 && exp_sum <=255)
			begin
				exp = exp_sum;	
				sign = sign1 ^ sign2;
				product = mantissa;
				exception = 0;
				//$display ("exp3");
			end
			else
			begin
				exp = 0;
				sign = 0;
				product = 48'b0;;
				exception = 1;
				//$display ("exp4");
			end
	end
	else 
		begin
			exp = 0;
				sign = 0;
				product = 48'b0;;
				exception = 0;
		end

		
end
endmodule

				
			

