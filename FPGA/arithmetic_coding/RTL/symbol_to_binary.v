module symbol_to_binary
(
	input 	wire  [3:0]		symbol,
	input 	wire 			sys_clk,
	input 	wire 			sys_reset,
	
	output 	reg 			binary
	


);

always@(posedge sys_clk or negedge sys_reset)
	begin 
	if(!sys_reset)
		case (symbol)
			// transform the symbols to binary 
			2'b00: binary <= 1'b0;
			2'b01: binary <= 2'b10;
			2'b10: binary <= 3'b110;
			2'b11: binary <= 4'b1110;
		default: binary <= 1'b0;
		endcase
	else 
		binary <= 4'b1111; // if binary is equal to 0b'1111, marking some additional symbols appear.
	end 
	
	
	
	
	
	
endmodule 
