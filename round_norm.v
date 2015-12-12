// module for rounding off and then normalizing the result
module round_norm (start,sign,norm, exp, ov1,exception,reset,c,e);
input [47:0] norm;
input reset,sign;
input [8:0] exp;
input ov1,start,exception;
output reg[31:0] c;
output reg e;
reg [22:0] mantissa_out;
reg [7:0] exp_out;
reg [25:0] round;
reg ov2,ex;
reg [47:0]norm1,n1,n2,n3;
reg [24:0] round2;
reg [24:0] norm2;
reg [8:0] exp_r,exp_s;

always@ (*)
begin
		if (!reset)
		begin
				c=0;
				e=0;

		end
		
	else
		begin
		if(start)
		begin
			if (norm[22])
			begin
				round = norm[45:23] + 1'b1;
				if(round[23])
				begin
					round2 = round >>1;			
					exp_r = exp + 1;
					norm2 = round2 [22:0];
					if (exp_r[8])
					begin
						ov2 = 1;
						//ex = ();
						assign e = (ov1 || ov2 || exception);
						exp_out = 8'b0;
						norm2 = round2 [22:0];
						mantissa_out=norm2;
						c = {sign,exp_out,mantissa_out};
						
					end
					else
					begin
						ov2 = 0;
						//ex = (ov1 || ov2);
						assign e = (ov1 || ov2 || exception);
						exp_out= exp_r[7:0];
						norm2 = round2 [22:0];
						mantissa_out=norm2;
						c={sign,exp_out,mantissa_out};
					end
				end				
				else
				begin					
					mantissa_out = round[22:0];
					exp_out = exp[7:0];
					ov2 = 0;
					//ex = (ov1 || ov2);
					assign e = (ov1 || ov2 || exception);
					c={sign,exp_out,mantissa_out};
				end 
			end
			else
			begin
				mantissa_out = norm[45:23];
				//mantissa_out <= norm2;
				exp_out = exp[7:0];
				ov2 = 0;
				//ex = (ov1 || ov2);
				assign e = (ov1 || ov2 || exception);
				c={sign,exp_out,mantissa_out};
			end
		end	
		else 
			c=0;
			e = 0;	//mantissa_out <= norm2;
			//exp_out <= exp_r[7:0];
	end
		
end
endmodule



					
							
