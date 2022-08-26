`timescale 1ns / 1ns

module tb_compressed_sensing();

reg   			sys_clk;
reg 			sys_reset;
reg   	[3:0]	values;

wire 	[7:0]   counter;
wire    [3:0] 	output_symbols;
wire    [0:0]	end_flag;

initial 
	begin
	
	sys_clk   <= 1'b0;
	sys_reset <= 1'b0;
	
	end

always #5 sys_clk = ~sys_clk;

initial 
	begin
		$timeformat(-9,0,"ns",6);
		// $monitor("@time %t: symbol_in=%b, sys_reset=%b, output_bit=%b",$time,symbol_in,sys_reset,output_bit);
		
	end 

always@(posedge sys_clk or negedge sys_reset) //counter for the get single bit
begin
	if(~sys_reset) 
		begin
			# 5
			sys_reset <= 1'b1;
		end
		
	else if (counter == 96)
			sys_reset <= 1'b0;

			
			
			
end



always@(counter)
begin 

case(counter)
0  :values <=   4'b000   ;
1  :values <=   4'b000   ;///原来为1=001
2  :values <=   4'b000   ;
3  :values <=   4'b000   ;
4  :values <=   4'b000   ;
5  :values <=   4'b000   ;
6  :values <=   4'b000   ;
7  :values <=   4'b000   ;
8  :values <=   4'b001   ;
9  :values <=   4'b000   ;
10 :values <=   4'b000   ;
11 :values <=   4'b000   ;
12 :values <=   4'b000   ;
13 :values <=   4'b001   ;
14 :values <=   4'b000   ;
15 :values <=   4'b000   ;
16 :values <=   4'b000   ;
17 :values <=   4'b000   ;
18 :values <=   4'b000   ;
19 :values <=   4'b000   ;
20 :values <=   4'b000   ;
21 :values <=   4'b000   ;
22 :values <=   4'b000   ;
23 :values <=   4'b001   ;
24 :values <=   4'b000   ;
25 :values <=   4'b000   ;
26 :values <=   4'b001   ;
27 :values <=   4'b000   ;
28 :values <=   4'b000   ;
29 :values <=   4'b001   ;
30 :values <=   4'b000   ;
31 :values <=   4'b000   ;
32 :values <=   4'b000   ;
33 :values <=   4'b000   ;
34 :values <=   4'b000   ;
35 :values <=   4'b000   ;
36 :values <=   4'b000   ;
37 :values <=   4'b000   ;
38 :values <=   4'b000   ;
39 :values <=   4'b000   ;
40 :values <=   4'b001   ;
41 :values <=   4'b000   ;
42 :values <=   4'b000   ;
43 :values <=   4'b000   ;
44 :values <=   4'b000   ;
45 :values <=   4'b000   ;
46 :values <=   4'b000   ;
47 :values <=   4'b000   ;
48 :values <=   4'b000   ;
49 :values <=   4'b000   ;
50 :values <=   4'b000   ;
51 :values <=   4'b000   ;
52 :values <=   4'b000   ;
53 :values <=   4'b000   ;
54 :values <=   4'b000   ;
55 :values <=   4'b000   ;
56 :values <=   4'b000   ;
57 :values <=   4'b001   ;
58 :values <=   4'b001   ;
59 :values <=   4'b001   ;
60 :values <=   4'b000   ;
61 :values <=   4'b000   ;
62 :values <=   4'b000   ;
63 :values <=   4'b000   ;
64 :values <=   4'b000   ;
65 :values <=   4'b000   ;
66 :values <=   4'b000   ;
67 :values <=   4'b000   ;
68 :values <=   4'b000   ;
69 :values <=   4'b000   ;
70 :values <=   4'b000   ;
71 :values <=   4'b000   ;
72 :values <=   4'b000   ;
73 :values <=   4'b000   ;
74 :values <=   4'b000   ;
75 :values <=   4'b000   ;
76 :values <=   4'b000   ;
77 :values <=   4'b001   ;
78 :values <=   4'b000   ;
79 :values <=   4'b000   ;
80 :values <=   4'b000   ;
81 :values <=   4'b000   ;
82 :values <=   4'b000   ;
83 :values <=   4'b000   ;
84 :values <=   4'b000   ;
85 :values <=   4'b000   ;
86 :values <=   4'b000   ;
87 :values <=   4'b000   ;
88 :values <=   4'b000   ;
89 :values <=   4'b000   ;
90 :values <=   4'b000   ;
91 :values <=   4'b000   ;
92 :values <=   4'b000   ;
93 :values <=   4'b000   ;
94 :values <=   4'b000   ;
95 :values <=   4'b000   ;



96 :values <=   4'b000   ;
default:;
endcase

end 


compressed_sensing compressed_sensing_inst
(
	.sys_clk(sys_clk),
	.sys_reset(sys_reset),
	.values(values),
	
	.output_symbols(output_symbols),
	.value_counter(counter),
	.end_flag(end_flag)



);

endmodule 