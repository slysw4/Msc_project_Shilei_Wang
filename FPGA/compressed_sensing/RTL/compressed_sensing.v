module compressed_sensing
(
	input 	wire   			sys_clk,
	input 	wire 			sys_reset,
	input 	wire   [3:0]	values,
	
	output 	reg    [3:0] 	output_symbols,			
	output  reg    [7:0]	value_counter,
	output  reg    [0:0]	end_flag
	



);
reg [9:0] addr=10'd0;
reg [9:0] addr_temp=9'd0;
reg    [3:0]	value_vector	[0:95];
reg    [3:0]	data_temp;

wire   [7:0] 	phi_index;

reg    [2:0] current_state;
parameter s0 = 3'd0;
parameter s1 = 3'd1;
parameter s2 = 3'd2;
parameter s3 = 3'd3;

reg 	[7:0] 	row_counter;
reg 	[7:0] 	adder_counter;

			
Rom Rom_inst
(
	 .clk(sys_clk),
	 .addr(addr),
	 .q(phi_index)
);
			


always@(posedge sys_clk or negedge sys_reset)
begin 	
    if(!sys_reset) begin
      
		current_state <= s1;
		row_counter <= 0;
		value_counter <= 0;
		adder_counter <= 0;
		data_temp <= 0;
		addr <= 10'd0;	
		end_flag <= 1'b0;
		
    end
	
	
	else begin 
	
		case (current_state)
			
			
			s1: begin

				value_vector[value_counter] <= values;
				
				value_counter <= value_counter + 1'b1;
				
				if (value_counter == 95) begin
					current_state <= s2;
					value_counter <= 0;
				end 
			end 
			
			// calculation of the each row times the raw signal (the vector)
			s2: begin	
					if (adder_counter <= 7) begin
						adder_counter <= adder_counter + 1'b1;
						addr <= addr + 1'b1;
						data_temp <= data_temp + value_vector[phi_index];
					end 
					
					else if (adder_counter == 8) begin
					adder_counter <= 0;
						data_temp <= data_temp + value_vector[phi_index];
						current_state <= s3;
					end 
						
					if (adder_counter == 7) begin 	
						
						
						addr_temp <= addr;
						addr <=  10'd96;
		
						
					end 
					if(addr > 10'd383)
					begin
						end_flag <= 1'b1;
					end
				
				end 
					
			// output the result in s2, and move to next row		
			s3: begin
					output_symbols <= data_temp; ///output
						data_temp <= 0;
						addr <= addr_temp + 1;
						current_state <= s2;
						
					row_counter <= row_counter + 1'b1;

				end 
			

		endcase

	end 	
 end
	
endmodule 