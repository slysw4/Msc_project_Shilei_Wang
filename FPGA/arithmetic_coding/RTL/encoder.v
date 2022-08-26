module encoder
(
	input 		wire [2:0]	symbol_in,  
	input 		wire 		sys_clk,
	input 		wire 		sys_reset,
	// cumulative counts vector for the input symbols
	//input 		wire [6:0]   cumulative_counts[0:5], 		// six different symbols

	
	output  	reg	 [0:0]	 output_bit,
	output 		reg	 [1:0]   terminate_flag, //1: mark the ending of encoding, then output the result
	output		reg	 [0:0] 	 index_ready

	
);

	//Compute the Word Length required.
	parameter 		N = 8;              		// N = ceil(log2(total_count)) + 2. TO avoid the index difference: N = 9-1 = 8
	parameter 		total_bits = 96;



reg [7:0]	 cumulative_counts[5:0];
//Initialize the lower and upper bounds.
reg [9:0]	dec_low;	
reg [9:0]	dec_up; 	

	
reg [6:0]	E3_count; 	

reg [2:0] 	cumulative_index;
reg [1:0]	start_flag; // 2:let next symbol in  1: the current symbol is under encoding 			     0: initial state
reg [0:0]	stop_flag;	// 1: start to terminate the encoding of current symbol. 0: current symbol is under encoding

reg [200:0]	code;

reg  [7:0] 	 total_count;	//96 channels counter
reg  [7:0]	 code_index;

reg  [0:0]	 remaining_flag;
reg  [0:0]	 E3_flag;
reg  [4:0]   terminate_counter;

always@(posedge sys_clk or negedge sys_reset)
	begin 
		if(!sys_reset)
			begin
				dec_low 	<= 10'd0;
				dec_up 		<= 10'd511;		  //2^N - 1
			
				E3_count 	<= 7'd0;

				code_index  <= 8'd0;
				stop_flag   <= 1'b0;
				total_count <= 7'd0;
				start_flag  <= 2'b0;
				
				remaining_flag <= 1'b0;
				
				index_ready  <= 1'b0;
				
				cumulative_counts[0] <= 0;
				cumulative_counts[1] <= 2;
				cumulative_counts[2] <= 71;
				cumulative_counts[3] <= 90;
				cumulative_counts[4] <= 94;
				cumulative_counts[5] <= 96;
				
				terminate_counter <= 9;
						
			end
		
			
			
			
		else if ((stop_flag == 1'b0) && (start_flag != 2'b01) )
			begin
				if (index_ready  == 1'b0)
				begin
					case (symbol_in)
						3'b101: cumulative_index <= 0;//-1
						3'b000: cumulative_index <= 1;//0
						3'b001: cumulative_index <= 2;//1
						3'b010: cumulative_index <= 3;//2
						3'b011: cumulative_index <= 4;//3
						3'b111: cumulative_index <= 5;
						
					default: cumulative_index <= 3'b110;
					endcase
					
					index_ready  <= 1'b1;
					
					// counts the number of bits has been compressed
					total_count <= total_count + 1;	
					
					
				end 
				
				else if (index_ready  == 1'b1)
				begin	
			
					// compute the new lower bound
					dec_low <= dec_low + (dec_up - dec_low + 1)*cumulative_counts[cumulative_index]/96;
					
					// compute the new upper bound
					dec_up <= dec_low + (dec_up - dec_low + 1)*cumulative_counts[cumulative_index+1]/96 - 1;
					
					start_flag <= 2'b01;
					
					E3_flag 	<= 1'b0;
					
					//index_ready  <= 1'b0;
				end 
			end
			
		else if (start_flag == 2'b01)
				begin
				
				if (( dec_low[N] == dec_up[N]) || ( (dec_low[N-1] == 1) && (dec_up[N-1] == 0) ))
					begin 
						if (dec_low[N]==dec_up[N])
							begin
								if ( E3_flag == 1'b0 )
									begin
										// get the MSB
										code[code_index] <= dec_low[N];
										// code <= (code + dec_low[N]);
										
										code_index <= code_index + 1;
						
										if (E3_count > 0)
											E3_flag <= 1'b1;
										else 
											begin
												// left shift and complement the new MSB of dec_low and dec_up
												dec_low <= (dec_low << 1) & 10'b01_1111_1111;
												dec_up  <= ((dec_up  << 1) + 1) & 10'b01_1111_1111;
											end 
											
									end 
								// check if E3_count is non-zero and transmit appropriate bits
								// where may takes many cycles to finish the if-loop
								else if ( E3_flag == 1'b1 )
									begin 
										
										// have to transmit complement of b, E3_count times
										E3_count <= E3_count - 1;
										
										code[code_index] <= !dec_low[N];
										
										// code <= {code[199:0], (!dec_low[N])}; 
										code_index <= code_index + 1;
										
										if (E3_count == 1)
											begin	
												E3_flag <= 1'b0;				
												// left shift and complement the new MSB of dec_low and dec_up
												dec_low <= (dec_low << 1) & 10'b01_1111_1111;
												dec_up  <= ((dec_up  << 1) + 1) & 10'b01_1111_1111;
											end
									end

									
							end
							
							// Else if it is an E3 condition
						else if ((dec_low[N-1] == 1) && (dec_up[N-1] == 0))
							begin
								// left shift and complement the new MSB of dec_low and dec_up
								dec_low <= ((dec_low << 1) ^ 10'b01_0000_0000) & 10'b01_1111_1111;
								dec_up  <= (((dec_up  << 1) + 1) ^ 10'b01_0000_0000) & 10'b01_1111_1111;
								
								// Increment E3_count to keep track of number of times E3 condition is hit.
								E3_count <= E3_count + 1;
								
							end
						

					end
						
				else 
					begin
					
					index_ready  <= 1'b0;
					start_flag <= 2'b10;
					
					if (total_count == total_bits)
						begin 
							stop_flag  <= 1'b1;
							
						end
						
					end 
					
				
			end
			
			
			
			
			
		// end of coding
		else if ((stop_flag == 1'b1) && (terminate_counter >=1) )
			begin 
			    // 在获取最后一段编码时，应该有改进余地
				if ((E3_count == 0) && (terminate_counter >=1))
					begin 
						
						code[code_index] <= dec_low[terminate_counter-1] ;
						terminate_counter <= terminate_counter-1;
						code_index <= code_index + 1;
						
						if (terminate_counter == 1)
							terminate_flag <= 1'b1;
						
					end
				else //if (E3_count > 0)
					begin
						terminate_counter <= (terminate_counter - 1);
						// Transmit the MSB of dec_low
						if (remaining_flag == 1'b0)
							begin
								code[code_index] <= dec_low[N];
								code_index <= code_index + 1;
								
								remaining_flag <= 1'b1;
								
							end
						
						
						// Then transmit complement of b (MSB of bin_low), E3_count times
						else if ((E3_count>0))
							begin 
								// have to transmit complement of b, E3_count times
								E3_count <= E3_count - 1;
								
								code[code_index] <= !dec_low[N];
								// code <= {code[199:0], (!dec_low[N])}; 
								code_index <= code_index + 1;
								terminate_counter <= 8;
					
							end
				
						
						// Then transmit the remaining bits of bin_low
						else if (remaining_flag == 1'b1)
							if ( (terminate_counter >= 1))
								begin 
									
									code[code_index] <= dec_low[terminate_counter-1] ;
									code_index <= code_index + 1;
									if (terminate_counter == 1)
										terminate_flag <= 1'b1;
									
								end
					
					end 
				
				
			end 
		
		
			
	end 
	

reg 	[7:0]  output_index; 

// integer j;
always@(posedge sys_clk or negedge sys_reset)
	begin 
		if( !sys_reset )
			begin
				output_index <= 0;
			end 
			
		else if (output_index != code_index)
			begin 
				output_bit <= code[code_index-1];
				output_index <= output_index + 1;
			end 
		else 
			begin
				output_bit <= 1'bx;
				
			end 
		
		
	
		
		// else if (terminate_flag == 1'b1 && terminate_counter!= 0)
			
				//// Output only the filled values
				
				// begin
				
				// for (j = code_index-9; j<=code_index-1; j=j+1)
					// output_bit <= code[code_index - terminate_counter];
					
				//	// end 
		

		
		
	end 


endmodule 











