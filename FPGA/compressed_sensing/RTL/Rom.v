module Rom(
	input wire clk,
	input wire [9:0] addr,
	output reg[7:0] q
);

reg [8:0] rom [384:0];

initial begin 

rom [ 0  ]<=  8'd2;
 rom [ 1  ]<= 8'd4;
 rom [ 2  ]<= 8'd26;
 rom [ 3  ]<= 8'd29;
 rom [ 4  ]<= 8'd47;
 rom [ 5  ]<= 8'd50;
 rom [ 6  ]<= 8'd67;
 rom [ 7  ]<= 8'd81;
 rom [ 8  ]<= 8'd16;
 rom [ 9  ]<= 8'd28;
 rom [ 10  ]<= 8'd44;
 rom [ 11  ]<= 8'd58;
 rom [ 12  ]<= 8'd61;
 rom [ 13  ]<= 8'd66;
 rom [ 14  ]<= 8'd91;
 rom [ 15  ]<= 8'd94;
 rom [ 16  ]<= 8'd20;
 rom [ 17  ]<= 8'd40;
 rom [ 18  ]<= 8'd43;
 rom [ 19  ]<= 8'd49;
 rom [ 20  ]<= 8'd66;
 rom [ 21  ]<= 8'd74;
 rom [ 22  ]<= 8'd86;
 rom [ 23  ]<= 8'd91;
 rom [ 24  ]<= 8'd9;
 rom [ 25  ]<= 8'd32;
 rom [ 26  ]<= 8'd48;
 rom [ 27  ]<= 8'd52;
 rom [ 28  ]<= 8'd59;
 rom [ 29  ]<= 8'd68;
 rom [ 30  ]<= 8'd91;
 rom [ 31  ]<= 8'd92;
 rom [ 32  ]<= 8'd12;
 rom [ 33  ]<= 8'd14;
 rom [ 34  ]<= 8'd34;
 rom [ 35  ]<= 8'd48;
 rom [ 36  ]<= 8'd56;
 rom [ 37  ]<= 8'd58;
 rom [ 38  ]<= 8'd62;
 rom [ 39  ]<= 8'd72;
 rom [ 40  ]<= 8'd25;
 rom [ 41  ]<= 8'd30;
 rom [ 42  ]<= 8'd31;
 rom [ 43  ]<= 8'd50;
 rom [ 44  ]<= 8'd54;
 rom [ 45  ]<= 8'd61;
 rom [ 46  ]<= 8'd71;
 rom [ 47  ]<= 8'd95;
 rom [ 48  ]<= 8'd9;
 rom [ 49  ]<= 8'd16;
 rom [ 50  ]<= 8'd22;
 rom [ 51  ]<= 8'd43;
 rom [ 52  ]<= 8'd51;
 rom [ 53  ]<= 8'd52;
 rom [ 54  ]<= 8'd65;
 rom [ 55  ]<= 8'd95;
 rom [ 56  ]<= 8'd9;
 rom [ 57  ]<= 8'd26;
 rom [ 58  ]<= 8'd59;
 rom [ 59  ]<= 8'd60;
 rom [ 60  ]<= 8'd72;
 rom [ 61  ]<= 8'd74;
 rom [ 62  ]<= 8'd90;
 rom [ 63  ]<= 8'd93;
 rom [ 64  ]<= 8'd7;
 rom [ 65  ]<= 8'd16;
 rom [ 66  ]<= 8'd22;
 rom [ 67  ]<= 8'd32;
 rom [ 68  ]<= 8'd38;
 rom [ 69  ]<= 8'd48;
 rom [ 70  ]<= 8'd66;
 rom [ 71  ]<= 8'd74;
 rom [ 72  ]<= 8'd22;
 rom [ 73  ]<= 8'd25;
 rom [ 74  ]<= 8'd33;
 rom [ 75  ]<= 8'd37;
 rom [ 76  ]<= 8'd46;
 rom [ 77  ]<= 8'd52;
 rom [ 78  ]<= 8'd54;
 rom [ 79  ]<= 8'd87;
 rom [ 80  ]<= 8'd5;
 rom [ 81  ]<= 8'd6;
 rom [ 82  ]<= 8'd7;
 rom [ 83  ]<= 8'd10;
 rom [ 84  ]<= 8'd27;
 rom [ 85  ]<= 8'd31;
 rom [ 86  ]<= 8'd51;
 rom [ 87  ]<= 8'd66;
 rom [ 88  ]<= 8'd8;
 rom [ 89  ]<= 8'd13;
 rom [ 90  ]<= 8'd36;
 rom [ 91  ]<= 8'd39;
 rom [ 92  ]<= 8'd48;
 rom [ 93  ]<= 8'd55;
 rom [ 94  ]<= 8'd69;
 rom [ 95  ]<= 8'd87;
 rom [ 96  ]<= 8'd4;
 rom [ 97  ]<= 8'd6;
 rom [ 98  ]<= 8'd15;
 rom [ 99  ]<= 8'd18;
 rom [ 100  ]<= 8'd19;
 rom [ 101  ]<= 8'd29;
 rom [ 102  ]<= 8'd35;
 rom [ 103  ]<= 8'd62;
 rom [ 104  ]<= 8'd11;
 rom [ 105  ]<= 8'd19;
 rom [ 106  ]<= 8'd21;
 rom [ 107  ]<= 8'd26;
 rom [ 108  ]<= 8'd27;
 rom [ 109  ]<= 8'd30;
 rom [ 110  ]<= 8'd48;
 rom [ 111  ]<= 8'd59;
 rom [ 112  ]<= 8'd6;
 rom [ 113  ]<= 8'd11;
 rom [ 114  ]<= 8'd33;
 rom [ 115  ]<= 8'd35;
 rom [ 116  ]<= 8'd40;
 rom [ 117  ]<= 8'd73;
 rom [ 118  ]<= 8'd75;
 rom [ 119  ]<= 8'd95;
 rom [ 120  ]<= 8'd2;
 rom [ 121  ]<= 8'd7;
 rom [ 122  ]<= 8'd8;
 rom [ 123  ]<= 8'd21;
 rom [ 124  ]<= 8'd62;
 rom [ 125  ]<= 8'd75;
 rom [ 126  ]<= 8'd82;
 rom [ 127  ]<= 8'd95;
 rom [ 128  ]<= 8'd12;
 rom [ 129  ]<= 8'd13;
 rom [ 130  ]<= 8'd19;
 rom [ 131  ]<= 8'd36;
 rom [ 132  ]<= 8'd52;
 rom [ 133  ]<= 8'd68;
 rom [ 134  ]<= 8'd72;
 rom [ 135  ]<= 8'd88;
 rom [ 136  ]<= 8'd1;
 rom [ 137  ]<= 8'd20;
 rom [ 138  ]<= 8'd24;
 rom [ 139  ]<= 8'd45;
 rom [ 140  ]<= 8'd49;
 rom [ 141  ]<= 8'd58;
 rom [ 142  ]<= 8'd60;
 rom [ 143  ]<= 8'd69;
 rom [ 144  ]<= 8'd4;
 rom [ 145  ]<= 8'd18;
 rom [ 146  ]<= 8'd23;
 rom [ 147  ]<= 8'd41;
 rom [ 148  ]<= 8'd51;
 rom [ 149  ]<= 8'd58;
 rom [ 150  ]<= 8'd70;
 rom [ 151  ]<= 8'd93;
 rom [ 152  ]<= 8'd26;
 rom [ 153  ]<= 8'd34;
 rom [ 154  ]<= 8'd49;
 rom [ 155  ]<= 8'd66;
 rom [ 156  ]<= 8'd70;
 rom [ 157  ]<= 8'd76;
 rom [ 158  ]<= 8'd83;
 rom [ 159  ]<= 8'd92;
 rom [ 160  ]<= 8'd25;
 rom [ 161  ]<= 8'd27;
 rom [ 162  ]<= 8'd32;
 rom [ 163  ]<= 8'd39;
 rom [ 164  ]<= 8'd57;
 rom [ 165  ]<= 8'd63;
 rom [ 166  ]<= 8'd73;
 rom [ 167  ]<= 8'd76;
 rom [ 168  ]<= 8'd26;
 rom [ 169  ]<= 8'd31;
 rom [ 170  ]<= 8'd32;
 rom [ 171  ]<= 8'd41;
 rom [ 172  ]<= 8'd48;
 rom [ 173  ]<= 8'd68;
 rom [ 174  ]<= 8'd69;
 rom [ 175  ]<= 8'd71;
 rom [ 176  ]<= 8'd23;
 rom [ 177  ]<= 8'd42;
 rom [ 178  ]<= 8'd57;
 rom [ 179  ]<= 8'd71;
 rom [ 180  ]<= 8'd77;
 rom [ 181  ]<= 8'd82;
 rom [ 182  ]<= 8'd92;
 rom [ 183  ]<= 8'd93;
 rom [ 184  ]<= 8'd8;
 rom [ 185  ]<= 8'd18;
 rom [ 186  ]<= 8'd21;
 rom [ 187  ]<= 8'd26;
 rom [ 188  ]<= 8'd29;
 rom [ 189  ]<= 8'd42;
 rom [ 190  ]<= 8'd44;
 rom [ 191  ]<= 8'd55;
 rom [ 192  ]<= 8'd17;
 rom [ 193  ]<= 8'd21;
 rom [ 194  ]<= 8'd31;
 rom [ 195  ]<= 8'd36;
 rom [ 196  ]<= 8'd51;
 rom [ 197  ]<= 8'd54;
 rom [ 198  ]<= 8'd85;
 rom [ 199  ]<= 8'd89;
 rom [ 200  ]<= 8'd13;
 rom [ 201  ]<= 8'd43;
 rom [ 202  ]<= 8'd56;
 rom [ 203  ]<= 8'd65;
 rom [ 204  ]<= 8'd66;
 rom [ 205  ]<= 8'd75;
 rom [ 206  ]<= 8'd86;
 rom [ 207  ]<= 8'd94;
 rom [ 208  ]<= 8'd1;
 rom [ 209  ]<= 8'd28;
 rom [ 210  ]<= 8'd31;
 rom [ 211  ]<= 8'd44;
 rom [ 212  ]<= 8'd49;
 rom [ 213  ]<= 8'd58;
 rom [ 214  ]<= 8'd64;
 rom [ 215  ]<= 8'd88;
 rom [ 216  ]<= 8'd3;
 rom [ 217  ]<= 8'd13;
 rom [ 218  ]<= 8'd24;
 rom [ 219  ]<= 8'd33;
 rom [ 220  ]<= 8'd35;
 rom [ 221  ]<= 8'd38;
 rom [ 222  ]<= 8'd40;
 rom [ 223  ]<= 8'd45;
 rom [ 224  ]<= 8'd5;
 rom [ 225  ]<= 8'd7;
 rom [ 226  ]<= 8'd8;
 rom [ 227  ]<= 8'd23;
 rom [ 228  ]<= 8'd34;
 rom [ 229  ]<= 8'd41;
 rom [ 230  ]<= 8'd43;
 rom [ 231  ]<= 8'd93;
 rom [ 232  ]<= 8'd1;
 rom [ 233  ]<= 8'd7;
 rom [ 234  ]<= 8'd39;
 rom [ 235  ]<= 8'd42;
 rom [ 236  ]<= 8'd58;
 rom [ 237  ]<= 8'd71;
 rom [ 238  ]<= 8'd72;
 rom [ 239  ]<= 8'd92;
 rom [ 240  ]<= 8'd13;
 rom [ 241  ]<= 8'd23;
 rom [ 242  ]<= 8'd29;
 rom [ 243  ]<= 8'd42;
 rom [ 244  ]<= 8'd47;
 rom [ 245  ]<= 8'd51;
 rom [ 246  ]<= 8'd63;
 rom [ 247  ]<= 8'd73;
 rom [ 248  ]<= 8'd1;
 rom [ 249  ]<= 8'd2;
 rom [ 250  ]<= 8'd22;
 rom [ 251  ]<= 8'd80;
 rom [ 252  ]<= 8'd81;
 rom [ 253  ]<= 8'd82;
 rom [ 254  ]<= 8'd86;
 rom [ 255  ]<= 8'd90;
 rom [ 256  ]<= 8'd2;
 rom [ 257  ]<= 8'd14;
 rom [ 258  ]<= 8'd16;
 rom [ 259  ]<= 8'd28;
 rom [ 260  ]<= 8'd34;
 rom [ 261  ]<= 8'd40;
 rom [ 262  ]<= 8'd46;
 rom [ 263  ]<= 8'd78;
 rom [ 264  ]<= 8'd9;
 rom [ 265  ]<= 8'd12;
 rom [ 266  ]<= 8'd32;
 rom [ 267  ]<= 8'd33;
 rom [ 268  ]<= 8'd43;
 rom [ 269  ]<= 8'd49;
 rom [ 270  ]<= 8'd60;
 rom [ 271  ]<= 8'd92;
 rom [ 272  ]<= 8'd0;
 rom [ 273  ]<= 8'd9;
 rom [ 274  ]<= 8'd10;
 rom [ 275  ]<= 8'd12;
 rom [ 276  ]<= 8'd31;
 rom [ 277  ]<= 8'd47;
 rom [ 278  ]<= 8'd63;
 rom [ 279  ]<= 8'd86;
 rom [ 280  ]<= 8'd12;
 rom [ 281  ]<= 8'd22;
 rom [ 282  ]<= 8'd31;
 rom [ 283  ]<= 8'd43;
 rom [ 284  ]<= 8'd50;
 rom [ 285  ]<= 8'd70;
 rom [ 286  ]<= 8'd77;
 rom [ 287  ]<= 8'd91;
 rom [ 288  ]<= 8'd8;
 rom [ 289  ]<= 8'd42;
 rom [ 290  ]<= 8'd45;
 rom [ 291  ]<= 8'd48;
 rom [ 292  ]<= 8'd76;
 rom [ 293  ]<= 8'd82;
 rom [ 294  ]<= 8'd85;
 rom [ 295  ]<= 8'd92;
 rom [ 296  ]<= 8'd2;
 rom [ 297  ]<= 8'd12;
 rom [ 298  ]<= 8'd17;
 rom [ 299  ]<= 8'd38;
 rom [ 300  ]<= 8'd48;
 rom [ 301  ]<= 8'd53;
 rom [ 302  ]<= 8'd62;
 rom [ 303  ]<= 8'd73;
 rom [ 304  ]<= 8'd11;
 rom [ 305  ]<= 8'd32;
 rom [ 306  ]<= 8'd34;
 rom [ 307  ]<= 8'd36;
 rom [ 308  ]<= 8'd55;
 rom [ 309  ]<= 8'd60;
 rom [ 310  ]<= 8'd88;
 rom [ 311  ]<= 8'd91;
 rom [ 312  ]<= 8'd14;
 rom [ 313  ]<= 8'd15;
 rom [ 314  ]<= 8'd30;
 rom [ 315  ]<= 8'd40;
 rom [ 316  ]<= 8'd42;
 rom [ 317  ]<= 8'd44;
 rom [ 318  ]<= 8'd70;
 rom [ 319  ]<= 8'd75;
 rom [ 320  ]<= 8'd1;
 rom [ 321  ]<= 8'd4;
 rom [ 322  ]<= 8'd6;
 rom [ 323  ]<= 8'd18;
 rom [ 324  ]<= 8'd32;
 rom [ 325  ]<= 8'd74;
 rom [ 326  ]<= 8'd78;
 rom [ 327  ]<= 8'd84;
 rom [ 328  ]<= 8'd18;
 rom [ 329  ]<= 8'd20;
 rom [ 330  ]<= 8'd37;
 rom [ 331  ]<= 8'd42;
 rom [ 332  ]<= 8'd45;
 rom [ 333  ]<= 8'd69;
 rom [ 334  ]<= 8'd86;
 rom [ 335  ]<= 8'd95;
 rom [ 336  ]<= 8'd2;
 rom [ 337  ]<= 8'd6;
 rom [ 338  ]<= 8'd8;
 rom [ 339  ]<= 8'd15;
 rom [ 340  ]<= 8'd36;
 rom [ 341  ]<= 8'd52;
 rom [ 342  ]<= 8'd74;
 rom [ 343  ]<= 8'd80;
 rom [ 344  ]<= 8'd15;
 rom [ 345  ]<= 8'd17;
 rom [ 346  ]<= 8'd32;
 rom [ 347  ]<= 8'd33;
 rom [ 348  ]<= 8'd37;
 rom [ 349  ]<= 8'd54;
 rom [ 350  ]<= 8'd84;
 rom [ 351  ]<= 8'd86;
 rom [ 352  ]<= 8'd12;
 rom [ 353  ]<= 8'd25;
 rom [ 354  ]<= 8'd37;
 rom [ 355  ]<= 8'd42;
 rom [ 356  ]<= 8'd79;
 rom [ 357  ]<= 8'd81;
 rom [ 358  ]<= 8'd83;
 rom [ 359  ]<= 8'd90;
 rom [ 360  ]<= 8'd16;
 rom [ 361  ]<= 8'd23;
 rom [ 362  ]<= 8'd27;
 rom [ 363  ]<= 8'd35;
 rom [ 364  ]<= 8'd55;
 rom [ 365  ]<= 8'd82;
 rom [ 366  ]<= 8'd94;
 rom [ 367  ]<= 8'd95;
 rom [ 368  ]<= 8'd2;
 rom [ 369  ]<= 8'd3;
 rom [ 370  ]<= 8'd8;
 rom [ 371  ]<= 8'd16;
 rom [ 372  ]<= 8'd20;
 rom [ 373  ]<= 8'd39;
 rom [ 374  ]<= 8'd51;
 rom [ 375  ]<= 8'd86;
 rom [ 376  ]<= 8'd5;
 rom [ 377  ]<= 8'd14;
 rom [ 378  ]<= 8'd37;
 rom [ 379  ]<= 8'd39;
 rom [ 380  ]<= 8'd50;
 rom [ 381  ]<= 8'd54;
 rom [ 382  ]<= 8'd70;
 rom [ 383  ]<= 8'd77;
 
 
 
 rom [ 384  ]<= 8'd96;
 
 
end


always@(posedge clk)
begin 
	q<=rom[addr];
	end 
endmodule
