module LNN
(
	input	wire 		sys_clk,
	input 	wire 		sys_reset,
	input 	wire [3:0]	values,
	input	wire [0:0]  data_end,
		
	output  reg	 [3:0]	output_symbols,
	output  reg  [0:0]  Data_in_flag


);

reg    [2:0] 	 current_state;
reg    [3:0]	past1[0:95];
reg    [3:0]	past2[0:95];
reg    [3:0]	past3[0:95];

reg	   [7:0]	counter;
reg 	[0:0]	output_flag;

parameter s0 = 3'd0;
parameter s1 = 3'd1;
parameter s2 = 3'd2;
parameter s3 = 3'd3;
parameter s4 = 3'd4;

reg	   [9:0]  	addr = 10'd0;

wire   [2:0] 	weight1;	
wire   [2:0] 	weight2;	
wire   [2:0] 	weight3;	

reg    [3:0]	error[0:95];


integer i;
	
Rom Rom_inst
(
	 .clk(sys_clk),
	 .addr(addr),
	 .weight1(weight1),
	 .weight2(weight2),
	 .weight3(weight3)
	 
);


always@ (posedge sys_clk or negedge sys_reset)
begin 
	if (!sys_reset) begin 
		counter <= 0;
		Data_in_flag <= 1'b0;
		
		current_state <= s0;
		
	
	end 
	
	else begin
	if (data_end == 1'b0) begin
		if (Data_in_flag == 1'b0) begin
			Data_in_flag <= 1'b1;
		end 
	
		case(current_state)
			s0: begin 
					past3[counter] <= values;
					counter <= counter + 1'b1;
				if (counter == 8'd95) begin
					Data_in_flag <= 1'b0;				
					current_state <= s1;
					counter <= 0;
				end 
			end 
			
			s1: begin
					past2[counter] <= values;
					counter <= counter + 1'b1;
				if (counter == 8'd95) begin
					Data_in_flag <= 1'b0;				
					current_state <= s2;
					counter <= 0;
				end 
			end 
			
			s2: begin
					past1[counter] <= values;
					counter <= counter + 1'b1;
				if (counter == 8'd95) begin
					Data_in_flag <= 1'b0;				
					current_state <= s3;
					counter <= 0;
				end 
			end 
			
			s3: begin
					
					counter <= counter + 1'b1;
				if (counter == 8'd95) begin
					Data_in_flag <= 1'b0;	
							
					// current_state <= s4;
					Data_in_flag <= 1'b0;
					counter <= 0;			
				end 
				// else if (counter == 8'd96) begin 
					// Data_in_flag <= 1'b0;				
					// current_state <= s4;
					// counter <= 0;
					
				// end 
			end 
			
			
			default: current_state <= s0;
		
	
		endcase
	end 
	end 

end 




always@ (posedge sys_clk or negedge sys_reset)
begin 
	if (!sys_reset) begin 
		output_flag <= 0;
	end 
	
	// predict the next value
	else begin
		
			if (current_state == s3) begin
				addr <= addr + 1'b1;
				
				error[counter] <= values - ( (weight1 * past1[counter]) + (weight2 *  past2[counter]) + (weight3 * past3[counter]) )/10;
				output_flag <= 1'b1;
				
					past3[counter] <= past2[counter];
					past2[counter] <= past1[counter];
					past1[counter] <= values;
					
					
				if (output_flag == 1'b1) 
					output_symbols <= error[counter - 1];

				if (counter == 8'd95)  begin
					output_flag <= 1'b0;
					addr <= 0;
				end 
			end 

					
	end 

end 








endmodule


