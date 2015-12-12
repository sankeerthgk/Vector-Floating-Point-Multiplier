//module for normalizing the product and check for overflow 

module norm_overflow(start,product, reset, bias_exp, norm_out, exp_out, overflow);
input [47:0] product;
input reset,start;
input [8:0] bias_exp;
output reg [47:0] norm_out;
output reg [8:0] exp_out;
output reg overflow;

//assign overflow = (o || exception);
always@ (*)
begin
	if (!reset)
		begin
				norm_out = 0;
				exp_out = 0;
				overflow = 0;
		end
	else
		begin
		if(start)
		begin
			//overflow = (o || exception);
			if (product[47])
					begin
						norm_out = product >> 1;
						exp_out = bias_exp + 1'b1;
						if (exp_out[8])
						begin
							overflow = 1;	// if overflow occurs
							norm_out = 0;
							exp_out = 1'bx;
						end
					end
				
				else if ( product[46])
					begin
						norm_out = product;
						exp_out = bias_exp;
						overflow = 0;
					end
				else 
					begin
						norm_out = product;
						exp_out = bias_exp;
						overflow = 0;
					end
		end
				else 
					begin
					norm_out = 0;
					exp_out = 0;
					overflow = 0;
					end					
	end
end
endmodule
						
							
