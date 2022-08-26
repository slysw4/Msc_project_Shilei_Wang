`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:04:46 23/06/2022 
// Design Name: 
// Module Name:    Count 
// Project Name:   Hardware efficient MUA compression
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//Count module is used to calculate the number of appearance of different characters 
module Count(
    Clk,
    Reset,
    Wr_en,	//enable signal   使能信号
    Data_in,
    Count0,     
    Count1,
    Count2,   
    Count3,
    Count4,
    Count5,
    Count6,
    Count7,
    Count8,   
    Count9,
    Re 		//indicates if the counting process is finished  		判断数数是否完成
    );
reg [7:0]Num;
input wire Clk;
input wire Reset;
input wire Wr_en;
input wire [2:0]Data_in;//数据流输入
output reg [7:0] Count0;
output reg [7:0] Count1;
output reg [7:0] Count2;
output reg [7:0] Count3;
output reg [7:0] Count4;
output reg [7:0] Count5;
output reg [7:0] Count6;
output reg [7:0] Count7;
output reg [7:0] Count8;
output reg [7:0] Count9;
output reg Re;
//count0-9分别记录0-9出现的次数
//count the range from -3 to 3 
always @(posedge Clk or negedge Reset)
    begin
      if(~Reset)
			begin                 //initialize the count 初始化清零
				Count0 <= 8'd00;  //-3
				Count1 <= 8'd00;  //-2
				Count2 <= 8'd00;  //-1
				Count3 <= 8'd00;  // 0
				Count4 <= 8'd00;  // 1
				Count5 <= 8'd00;  // 2
				Count6 <= 8'd00;  // 3 
				
				Num <= 8'd00;
			end
      else if(Wr_en)
			begin
				if(~&Num)
					begin
						case (Data_in)//出现0 时count0+1 以此类推
							3'b000: Count0<=Count0+1;
							3'b001: Count1<=Count1+1;
							3'b010: Count2<=Count2+1;
							3'b011: Count3<=Count3+1;
							3'b100: Count4<=Count4+1;
							3'b101: Count5<=Count5+1;
							3'b110: Count6<=Count6+1;
			
							default: ;
						endcase
						Num<=Num+1;//记录总数的个数
					end
			end
		  
    end
always @(posedge Clk or negedge Reset)
begin
    if(~Reset)
	 Re<=0;
	 else if(&Num)//当记录完总数之后将Re置1
	 Re<=1;
	 
end
endmodule