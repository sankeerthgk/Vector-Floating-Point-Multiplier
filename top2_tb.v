`include "top1.v"
`include "function1.v"

module test_fixture;
reg clk,start,reset;
reg [31:0]a[0:31];
reg [31:0]b[0:31];
reg flag6;
integer i;
integer j=32;
wire full,done;

top A6(clk,reset,start,full);
func A8(clk,reset,start,done);
initial
begin
$readmemh("rega.dat",a);
$readmemh("regb.dat",b);
end
initial
begin
clk=1'b0;
forever #10  clk=~clk;
end
initial
begin
for(i=0;i<32;i=i+1)
begin
A6.reg_file[i]=a[i];
A6.reg_file[j]=b[i];
A8.reg_C[i]=a[i];
A8.reg_C[j]=b[i];
j=j+1;
end
reset=1'b0;
start=1'b0;
A6.flag6[i]=0;
#10 reset=1'b1;
 start=1'b1;
#760
for(i=64;i<96;i=i+1)
begin
if(A6.reg_file[i]==A8.reg_C[i])
begin
$display("A=%b  B=%b  C=%b  C_validate=%b exception=%b\n",A6.reg_file[i-64],A6.reg_file[i-32],A6.reg_file[i],A8.reg_C[i],A6.flag6[i-2]);

$display("PASS");
end
else
begin
$display("A=%b  B=%b  C=%b  C_validate=%b\n,exception=%b,full=%b",A6.reg_file[i-64],A6.reg_file[i-32],A6.reg_file[i],A8.reg_C[i],A6.flag6[i-2],done);

$display("FAIL");
end
end

#800 $finish;
end
endmodule
