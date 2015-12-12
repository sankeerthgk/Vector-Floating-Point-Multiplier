module reg3 (c,e,clk,reset,c1,e1);
input e,clk,reset;
input [31:0]c;
output reg e1;
output reg [31:0]c1;

always@ (posedge clk or negedge reset)
begin
		if (!reset)
		begin
				e1 <= 0;
				c1 <= 0;
				//norm1 <= 0;
		end
		
	else
		begin
				e1 <= e;
				c1 <= c;

		end
end
endmodule
