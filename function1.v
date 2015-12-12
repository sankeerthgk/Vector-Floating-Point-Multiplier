module func(input Clk,reset,start, output reg full);
reg sign;
reg [8:0]exp,fexp1,fexp2;
reg flag;
reg [32:0]Ain,Bin;
reg [23:0]a,b;
reg [47:0]s,sum;
reg [24:0]sum1,sum2;
reg [31:0]reg_C[0:95];
reg flag7[0:31];
integer read_ptr1=0;
integer write_ptr1=64;
integer write_ptr2=64;
integer i=0;
reg [31:0]C_val;
reg flag_val;

always @(posedge Clk or negedge reset)
begin 
if(!reset) 
begin
Ain<=32'h0000_0000;
Bin<=32'h0000_0000;
read_ptr1<=0;
write_ptr1<=64; 
full<=1'b0; 
write_ptr2<=64; 
end 

else if(write_ptr1==32)
begin 
full<=1'b1;
end
else if(start)
begin
full<=1'b0; 
read_ptr1<=read_ptr1+1; 
Ain<=reg_C[read_ptr1];
Bin<=reg_C[read_ptr1+32];
write_ptr1<=write_ptr2;
i<=i+1;
end
end

always @(*)
    begin
	if(start)
	begin
	exp =Ain[30:23]+Bin[30:23]-8'd127;
	if(exp>= 0 && exp <=255)
          begin
                    a={1'b1,Ain[22:0]};
                    b={1'b1,Bin[22:0]};
                    sign=Ain[31]^Bin[31];
                    flag=1'b0;
               end
	else 
		begin 
 		    a=24'd0;
                    b=24'd0;
                    exp=9'd0;
                    sign=1'b0;
                    flag=1'b1; 
		end 
	end
s=a*b;

if(s[47])

    begin
		sum=s>>1;
		fexp1=exp+1'b1;
		if(fexp1[8])
                    begin

                        flag=1'b1;  

                    end                
		         begin   
			        if(sum[22]==1'b1)
			                begin
				            sum1=sum[47:23]+1'b1;
				        end 
				else
				        begin
				            sum1=sum[47:23];
				        end

		        end
		end
	else 
	    begin
                sum=s;
                fexp1=exp; 
	                if(fexp1[8])
		                    begin
		                        flag=1'b1;     
		                    end
					begin 
						if(sum[22]==1'b1)
					            begin
						            sum1=sum[47:23]+1'b1;
					            end 
						else
					            begin
						            sum1=sum[47:23];
					            end 
					end
	end

	if(sum1[24]==1'b1)
	    begin
		sum2=sum1>>1;
		fexp2=fexp1+1'b1;
			if(fexp2[8])
			    begin
				  flag=1'b1;     
		    		end
	    end
	else
            begin
		sum2=sum1;
                fexp2=fexp1;    
	                if(fexp2[8])
		                    begin
		                        flag=1'b1;        
		                    end
            end

C_val={sign,fexp2[7:0],sum2[22:0]};
flag_val=flag;
if(i>0)
begin
reg_C[write_ptr1]=C_val;
flag7[write_ptr1]=flag_val;
write_ptr2=write_ptr1+1;
end
end
endmodule
