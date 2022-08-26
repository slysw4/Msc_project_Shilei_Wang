module code_ending
(
	input 		wire [2:0]	symbol_in,  
	input 		wire 		sys_clk,
	input 		wire 		sys_reset,
	// cumulative counts vector for the input symbols
	//input 		wire [6:0]   cumulative_counts[0:5], 		// six different symbols

	
	output  	reg	 [0:0]	 output_bit,
	output 		reg	 [0:0]   terminate_flag //1: mark the ending of encoding, then output the result

	
);

	//Compute the Word Length required.
	parameter 		N = 8;              		// N = ceil(log2(total_count)) + 2. TO avoid the index difference: N = 9-1 = 8



reg [9:0]	dec_low;	
		
reg [6:0]	E3_count; 	
reg [9:0]	dec_low_new; 

reg [2:0] 	cumulative_index;
reg [1:0]	start_flag; // 2:let next symbol in  1: the current symbol is under encoding 			     0: initial state
reg [0:0]	stop_flag;	// 1: start to terminate the encoding of current symbol. 0: current symbol is under encoding

reg [488:0]	code;

reg [6:0] 	total_count;	//96 channels counter
reg [7:0]	code_index;
reg [0:0] 	MSB_flag;
reg [0:0]	remaining_flag;

reg [0:0]	E3_flag;
reg [0:0]	index_ready;


always@(posedge sys_clk or negedge sys_reset)
	begin 
		if(!sys_reset)		
		
		// end of coding
 if (stop_flag == 1'b1)
			begin 
				
				if (E3_count == 0)
					begin 
						code <= {code[488:9], dec_low};
						code_index <= code_index + 9;
						terminate_flag <= 1'b1;
					end
				else if (E3_count > 0)
					begin
						// Transmit the MSB of dec_low
						if (MSB_flag == 1'b0)
							begin
								code[code_index] <= dec_low[N];
								code_index <= code_index + 1;
								MSB_flag <= 1'b1;
							end 
						
						
						// Then transmit complement of b (MSB of bin_low), E3_count times
						if ((MSB_flag == 1'b1) && (E3_count>0))
							begin 
								// have to transmit complement of b, E3_count times
								E3_count <= E3_count - 1;
								
								code <= {code[487:0], (!dec_low[N])}; 
								code_index <= code_index + 1;
							end
						else
							MSB_flag   	   <= 1'b0;
							remaining_flag <= 1'b1;
						
						
						// Then transmit the remaining bits of bin_low
						if (remaining_flag == 1'b1)
							begin
								code <= {code[488:8], dec_low[7:0]};
								code_index <= code_index + 8;
								remaining_flag <= 1'b0;
								terminate_flag <= 1'b1;
							end
					
					end 
				

			end 
endmodule