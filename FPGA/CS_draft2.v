module compressed_sensing
(
	input 	wire   			sys_clk,
	input 	wire 			sys_reset,
	input 	wire   [3:0]	values,
	
	output 	reg    [3:0] 	output_symbols,			
	output  reg    [8:0]	col_counter



);

reg    [3:0]	compressed_data	[0:47];
reg    [3:0] 	Phi_matrix		[0:47][0:95];

reg    [8:0]	value_counter;


reg [2 : 0] next_state, current_state;
parameter s0 = 3'd0;
parameter s1 = 3'd1;
parameter s2 = 3'd2;
parameter s3 = 3'd3;
parameter s4 = 3'd4;
parameter s5 = 3'd5;
parameter s6 = 3'd6;

integer i,j;


always@(posedge sys_clk or negedge sys_reset)
begin 
	if (!sys_reset)
		begin

		
			
			// Initialize all the matrix register elements to zero.
			for(i=0;i<=47;i=i+1) 
			begin
			
				for(j=0;j<=95;j=j+1) 
				begin
					Phi_matrix[i][j] <= 4'd0000;
				
				end 
				
			
			end 
			
			
			
// use the bit logic and to replace the multiplication operation
Phi_matrix[0][36] <= 4'b1001; Phi_matrix[0][63] <= 4'b1001;
Phi_matrix[0][51] <= 4'b0001; Phi_matrix[0][55] <= 4'b0001;Phi_matrix[0][87] <= 4'b0001; Phi_matrix[0][92] <= 4'b0001;
  
Phi_matrix[1][21] <= 4'b1001;  Phi_matrix[1][66] <= 4'b1001;  Phi_matrix[1][80] <= 4'b1001;
Phi_matrix[1][7] <= 4'b0001;  Phi_matrix[1][14] <= 4'b0001;  Phi_matrix[1][33] <= 4'b0001; Phi_matrix[1][73] <= 4'b0001;  Phi_matrix[1][84] <= 4'b0001;

Phi_matrix[2][70] <= 4'b1001;  Phi_matrix[2][90] <= 4'b1001; 
Phi_matrix[2][77] <= 4'b0001; 

Phi_matrix[3][14] <= 4'b1001;  Phi_matrix[3][39] <= 4'b1001;  Phi_matrix[3][93] <= 4'b1001;
Phi_matrix[3][31] <= 4'b0001;  Phi_matrix[3][41] <= 4'b0001;  Phi_matrix[3][63] <= 4'b0001; Phi_matrix[3][89] <= 4'b0001;

Phi_matrix[4][8] <= 4'b1001;  Phi_matrix[4][13] <= 4'b1001;  Phi_matrix[4][61] <= 4'b1001; Phi_matrix[4][84] <= 4'b1001;  
Phi_matrix[4][0] <= 4'b0001;  Phi_matrix[4][7]  <= 4'b0001;  Phi_matrix[4][60] <= 4'b0001;  Phi_matrix[4][88] <= 4'b0001;

Phi_matrix[5][16] <= 4'b1001;  Phi_matrix[5][35] <= 4'b1001;  Phi_matrix[5][46] <= 4'b1001;  Phi_matrix[5][67] <= 4'b1001;  
Phi_matrix[5][18] <= 4'b0001;  Phi_matrix[5][20]  <= 4'b0001;  Phi_matrix[5][26] <= 4'b0001;  Phi_matrix[5][85] <= 4'b0001; Phi_matrix[5][94] <= 4'b0001;

Phi_matrix[6][17] <= 4'b1001;  Phi_matrix[6][22] <= 4'b1001;  Phi_matrix[6][71] <= 4'b1001; 
Phi_matrix[6][14] <= 4'b0001;  Phi_matrix[6][59]  <= 4'b0001;  

Phi_matrix[7][22] <= 4'b1001;  Phi_matrix[7][32] <= 4'b1001;  Phi_matrix[7][63] <= 4'b1001;
Phi_matrix[7][42] <= 4'b0001;  Phi_matrix[7][66] <= 4'b0001;  Phi_matrix[7][91] <= 4'b0001; 

Phi_matrix[8][4] <= 4'b1001;   Phi_matrix[8][17]  <= 4'b1001;  Phi_matrix[8][49] <= 4'b1001;  Phi_matrix[8][58] <= 4'b1001;  
Phi_matrix[8][23] <= 4'b0001;  Phi_matrix[8][33]  <= 4'b0001;  Phi_matrix[8][40] <= 4'b0001;  Phi_matrix[8][69] <= 4'b0001; Phi_matrix[8][91] <= 4'b0001;

Phi_matrix[9][33] <= 4'b1001; Phi_matrix[9][74] <= 4'b1001;
Phi_matrix[9][61] <= 4'b0001; Phi_matrix[9][73] <= 4'b0001;Phi_matrix[9][88] <= 4'b0001; 

Phi_matrix[10][11] <= 4'b1001;  Phi_matrix[10][22] <= 4'b1001;  Phi_matrix[10][52] <= 4'b1001;  Phi_matrix[10][91] <= 4'b1001;  
Phi_matrix[10][16] <= 4'b0001;  Phi_matrix[10][60]  <= 4'b0001;  Phi_matrix[10][69] <= 4'b0001;  Phi_matrix[10][93] <= 4'b0001;

Phi_matrix[11][26] <= 4'b1001;  Phi_matrix[11][50] <= 4'b1001;   Phi_matrix[11][57] <= 4'b1001;  Phi_matrix[11][91] <= 4'b1001;  
Phi_matrix[11][42] <= 4'b0001;  Phi_matrix[11][55]  <= 4'b0001;  Phi_matrix[11][87] <= 4'b0001;  Phi_matrix[11][95] <= 4'b0001;

Phi_matrix[12][6] <= 4'b1001;   Phi_matrix[12][41] <= 4'b1001;  
Phi_matrix[12][14] <= 4'b0001;  Phi_matrix[12][16]  <= 4'b0001;  Phi_matrix[12][51] <= 4'b0001; 

Phi_matrix[13][1] <= 4'b1001;   Phi_matrix[13][28]  <= 4'b1001;  Phi_matrix[13][68] <= 4'b1001;  Phi_matrix[13][73] <= 4'b1001;  
Phi_matrix[13][15] <= 4'b0001;  Phi_matrix[13][24]  <= 4'b0001;  Phi_matrix[13][33] <= 4'b0001;  Phi_matrix[13][41] <= 4'b0001; Phi_matrix[13][84] <= 4'b0001;

Phi_matrix[14][5] <= 4'b1001;   Phi_matrix[14][18]  <= 4'b1001;  Phi_matrix[14][31] <= 4'b1001;  Phi_matrix[14][75] <= 4'b1001;  
Phi_matrix[14][45] <= 4'b0001;  Phi_matrix[14][50]  <= 4'b0001;  Phi_matrix[14][61] <= 4'b0001;  Phi_matrix[14][69] <= 4'b0001; Phi_matrix[14][79] <= 4'b0001;

Phi_matrix[15][3] <= 4'b1001;  Phi_matrix[15][35]  <= 4'b1001;  Phi_matrix[15][60] <= 4'b1001;  Phi_matrix[15][66] <= 4'b1001; Phi_matrix[15][69] <= 4'b1001;Phi_matrix[15][82] <= 4'b1001;
Phi_matrix[15][27] <= 4'b0001;  Phi_matrix[15][41]  <= 4'b0001;  Phi_matrix[15][48] <= 4'b0001;  Phi_matrix[15][52] <= 4'b0001; Phi_matrix[15][65] <= 4'b0001;Phi_matrix[15][70] <= 4'b0001;

Phi_matrix[16][19] <= 4'b1001;   Phi_matrix[16][20] <= 4'b1001;  
Phi_matrix[16][16] <= 4'b0001;   Phi_matrix[16][68]  <= 4'b0001;  Phi_matrix[16][87] <= 4'b0001;  Phi_matrix[16][88] <= 4'b0001; Phi_matrix[16][89] <= 4'b0001;Phi_matrix[16][90] <= 4'b0001;

Phi_matrix[17][8] <= 4'b1001;  Phi_matrix[17][17] <= 4'b1001;   Phi_matrix[17][21] <= 4'b1001;  Phi_matrix[17][22] <= 4'b1001;  
Phi_matrix[17][0] <= 4'b0001;  Phi_matrix[17][13]  <= 4'b0001;  Phi_matrix[17][29] <= 4'b0001;  Phi_matrix[17][48] <= 4'b0001;

Phi_matrix[18][34] <= 4'b1001; Phi_matrix[18][76] <= 4'b1001;
Phi_matrix[18][19] <= 4'b0001; Phi_matrix[18][72] <= 4'b0001;Phi_matrix[18][94] <= 4'b0001; 

Phi_matrix[19][51] <= 4'b1001; Phi_matrix[19][86] <= 4'b1001;
Phi_matrix[19][8] <= 4'b0001; Phi_matrix[19][18] <= 4'b0001;Phi_matrix[19][48] <= 4'b0001; Phi_matrix[19][63] <= 4'b0001;

Phi_matrix[20][9] <= 4'b1001;  Phi_matrix[20][27]  <= 4'b1001;  Phi_matrix[20][45] <= 4'b1001;  Phi_matrix[20][48] <= 4'b1001; Phi_matrix[20][52] <= 4'b1001; Phi_matrix[20][64] <= 4'b1001;
Phi_matrix[20][6] <= 4'b0001;  Phi_matrix[20][23] <= 4'b0001;

Phi_matrix[21][74] <= 4'b1001;  Phi_matrix[21][93]  <= 4'b1001;  Phi_matrix[21][95] <= 4'b1001;
Phi_matrix[21][5] <= 4'b0001; Phi_matrix[21][32]  <= 4'b0001;  Phi_matrix[21][35] <= 4'b0001;  Phi_matrix[21][57] <= 4'b0001; Phi_matrix[21][68] <= 4'b0001;Phi_matrix[21][92] <= 4'b0001;

Phi_matrix[22][2] <= 4'b1001;  Phi_matrix[22][24]  <= 4'b1001;  Phi_matrix[22][67] <= 4'b1001;  Phi_matrix[22][70] <= 4'b1001;
Phi_matrix[22][92] <= 4'b0001;

Phi_matrix[23][11] <= 4'b1001;  Phi_matrix[23][12]  <= 4'b1001;  Phi_matrix[23][44] <= 4'b1001;  Phi_matrix[23][49] <= 4'b1001; Phi_matrix[23][56] <= 4'b1001;
Phi_matrix[23][3] <= 4'b0001;  Phi_matrix[23][10]  <= 4'b0001;  Phi_matrix[23][33] <= 4'b0001; 

Phi_matrix[24][9] <= 4'b1001;  Phi_matrix[24][56]  <= 4'b1001;  Phi_matrix[24][67] <= 4'b1001;
Phi_matrix[24][16] <= 4'b0001;   Phi_matrix[24][31]  <= 4'b0001;  Phi_matrix[24][75] <= 4'b0001;  Phi_matrix[24][93] <= 4'b0001;

Phi_matrix[25][15] <= 4'b1001;   Phi_matrix[25][62]  <= 4'b1001;  Phi_matrix[25][71] <= 4'b1001;  Phi_matrix[25][72] <= 4'b1001; Phi_matrix[25][77] <= 4'b1001;Phi_matrix[25][78] <= 4'b1001;Phi_matrix[25][94] <= 4'b1001;
Phi_matrix[25][37] <= 4'b0001;  Phi_matrix[25][53]  <= 4'b0001;  Phi_matrix[25][60] <= 4'b0001;  Phi_matrix[25][68] <= 4'b0001; 

Phi_matrix[26][36] <= 4'b1001;  Phi_matrix[26][44]  <= 4'b1001;  Phi_matrix[26][69] <= 4'b1001;
Phi_matrix[26][0] <= 4'b0001;   Phi_matrix[26][1]  <= 4'b0001;  Phi_matrix[26][5] <= 4'b0001;  Phi_matrix[26][37] <= 4'b0001; Phi_matrix[26][47] <= 4'b0001;

Phi_matrix[27][90] <= 4'b1001; 
Phi_matrix[27][16] <= 4'b0001; Phi_matrix[27][25] <= 4'b0001;Phi_matrix[27][85] <= 4'b0001; 

end 

else begin
	next_state <= s0;


end 



	end
		

	


always@(posedge sys_clk or negedge sys_reset)
begin 	
    if(!sys_reset) begin
        next_state <= s0;
			current_state <= s0;
		
    end
	
	
	else begin 
		case (current_state)
			s0:	begin
				current_state <= s1;
				
			end
			
			s1: begin
				if (col_counter == 96)
					current_state <= s2;
				
			end 
			
			s2: begin
				if (value_counter == 47)
					current_state <= s0;
			end 

		endcase

	end
	
end 



reg [8:0] row_counter;

always@(posedge sys_clk or negedge sys_reset)
begin 				
	if(!sys_reset) begin
		row_counter <= 0;
		col_counter <= 0;
			for(i=0;i<=47;i=i+1) 
			begin				
				compressed_data[i] <= 0; 
			end 

    end		
	
	else if (current_state == s1) begin
	  
            if (col_counter <= 95) begin
				
				if (row_counter <= 47) begin 
				
					if ((Phi_matrix[row_counter][col_counter] == 4'b0001) || (Phi_matrix[row_counter][col_counter] == 4'b1001)) begin

						if (Phi_matrix[row_counter][col_counter] == 4'b1001)
							
							compressed_data[row_counter] <= compressed_data[row_counter] - values;
							
						else if (Phi_matrix[row_counter][col_counter] == 4'b0001)
							compressed_data[row_counter] <= compressed_data[row_counter] + values;
						
				
					end
					row_counter   <=  row_counter + 1;
				end 
					
				else if (row_counter == 47) begin
						col_counter   <=  col_counter + 1;
						row_counter	  <= 0;
					end 
				end 
				
            end 
 
	
		// if (row_counter <= 47) begin		 
									//	Phi = 1							   // Phi = -1
			// if ((Phi_matrix[row_counter][col_counter] == 4'b0001) || (Phi_matrix[j][col_counter] == 4'b1001)) begin

				// if (Phi_matrix[row_counter][col_counter] == 4'b1001)
					
					// compressed_data[row_counter] <= compressed_data[j] - values;
					
				// else if (Phi_matrix[row_counter][col_counter] == 4'b0001)
					// compressed_data[row_counter] <= compressed_data[row_counter] + values;
					
			
			// end
			
			// row_counter <= row_counter + 1;
		// end 
		
		
		
		// if (row_counter == 47) begin
			// col_counter   <=  col_counter + 1;
			// row_counter <= 0;
		// end 
		
	
			
			
	end
	

	
always@(posedge sys_clk or negedge sys_reset)
begin 				
	if(!sys_reset) begin
		
		value_counter <= 0;

    end		
	

	else if(current_state == s0) begin
		value_counter <= 0;
	end
		
	else if (current_state == s2) begin
		output_symbols <= compressed_data[value_counter];
		value_counter <= value_counter + 1;
	end 
		
	
end 
	
endmodule 
