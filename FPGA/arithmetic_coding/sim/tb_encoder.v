`timescale 1ns / 1ns

module tb_encoder();

reg 		 sys_clk;
reg 		 sys_reset;

reg  [2:0] 	 symbols;
wire 		output_bit;
wire [0:0]	terminate_flag;

reg  [7:0]	counter;
wire  [0:0] index_ready;



initial 
	begin
	
	// symbol_in <= 0;
	sys_clk   <= 1'b0;
	sys_reset <= 1'b0;
	counter   <= 0;
	

	// $readmemb("symbols.txt",symbol_in); 
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
			counter <= 0;
	else 
		begin
			if (index_ready  == 1'b0)
			
				counter <= counter + 1; 
				
		end 
end 
		


always@(posedge sys_clk or negedge sys_reset)
	begin 

	case(counter)
0  :symbols <=   3'b001   ;
1  :symbols <=   3'b001   ;///原来为1=001
2  :symbols <=   3'b000   ;
3  :symbols <=   3'b010   ;
4  :symbols <=   3'b101   ;
5  :symbols <=   3'b000   ;
6  :symbols <=   3'b000   ;
7  :symbols <=   3'b010   ;
8  :symbols <=   3'b001   ;
9  :symbols <=   3'b101   ;
10 :symbols <=   3'b000   ;
11 :symbols <=   3'b000   ;
12 :symbols <=   3'b000   ;
13 :symbols <=   3'b000   ;
14 :symbols <=   3'b000   ;
15 :symbols <=   3'b001   ;
16 :symbols <=   3'b000   ;
17 :symbols <=   3'b000   ;
18 :symbols <=   3'b000   ;
19 :symbols <=   3'b000   ;
20 :symbols <=   3'b000   ;
21 :symbols <=   3'b000   ;
22 :symbols <=   3'b000   ;
23 :symbols <=   3'b010   ;
24 :symbols <=   3'b000   ;
25 :symbols <=   3'b000   ;
26 :symbols <=   3'b001   ;
27 :symbols <=   3'b000   ;
28 :symbols <=   3'b000   ;
29 :symbols <=   3'b000   ;
30 :symbols <=   3'b000   ;
31 :symbols <=   3'b000   ;
32 :symbols <=   3'b000   ;
33 :symbols <=   3'b000   ;
34 :symbols <=   3'b000   ;
35 :symbols <=   3'b000   ;
36 :symbols <=   3'b011   ;
37 :symbols <=   3'b000   ;
38 :symbols <=   3'b000   ;
39 :symbols <=   3'b000   ;
40 :symbols <=   3'b001   ;
41 :symbols <=   3'b001   ;
42 :symbols <=   3'b000   ;
43 :symbols <=   3'b000   ;
44 :symbols <=   3'b001   ;
45 :symbols <=   3'b000   ;
46 :symbols <=   3'b000   ;
47 :symbols <=   3'b000   ;
48 :symbols <=   3'b000   ;
49 :symbols <=   3'b001   ;
50 :symbols <=   3'b000   ;
51 :symbols <=   3'b001   ;
52 :symbols <=   3'b000   ;
53 :symbols <=   3'b000   ;
54 :symbols <=   3'b000   ;
55 :symbols <=   3'b000   ;
56 :symbols <=   3'b001   ;
57 :symbols <=   3'b000   ;
58 :symbols <=   3'b000   ;
59 :symbols <=   3'b001   ;
60 :symbols <=   3'b000   ;
61 :symbols <=   3'b010   ;
62 :symbols <=   3'b000   ;
63 :symbols <=   3'b000   ;
64 :symbols <=   3'b000   ;
65 :symbols <=   3'b001   ;
66 :symbols <=   3'b000   ;
67 :symbols <=   3'b000   ;
68 :symbols <=   3'b000   ;
69 :symbols <=   3'b011   ;
70 :symbols <=   3'b001   ;
71 :symbols <=   3'b000   ;
72 :symbols <=   3'b000   ;
73 :symbols <=   3'b000   ;
74 :symbols <=   3'b000   ;
75 :symbols <=   3'b000   ;
76 :symbols <=   3'b000   ;
77 :symbols <=   3'b001   ;
78 :symbols <=   3'b000   ;
79 :symbols <=   3'b000   ;
80 :symbols <=   3'b000   ;
81 :symbols <=   3'b001   ;
82 :symbols <=   3'b000   ;
83 :symbols <=   3'b000   ;
84 :symbols <=   3'b000   ;
85 :symbols <=   3'b000   ;
86 :symbols <=   3'b000   ;
87 :symbols <=   3'b000   ;
88 :symbols <=   3'b000   ;
89 :symbols <=   3'b001   ;
90 :symbols <=   3'b000   ;
91 :symbols <=   3'b000   ;
92 :symbols <=   3'b001   ;
93 :symbols <=   3'b000   ;
94 :symbols <=   3'b000   ;
95 :symbols <=   3'b001   ;
  default:;
  endcase

	end 
	

	
encoder
#(
	//Compute the Word Length required.
	.N(8),         		// N = ceil(log2(total_count)) + 2. TO avoid the index difference: N = 9-1 = 8
	.total_bits(96)
)
encoder_instance
(
	.symbol_in	(symbols)	,  
	.sys_clk	(sys_clk)	,
	.sys_reset	(sys_reset)	,
	
	.output_bit	(output_bit),
	.terminate_flag(terminate_flag),
	.index_ready(index_ready)

	
);


endmodule 