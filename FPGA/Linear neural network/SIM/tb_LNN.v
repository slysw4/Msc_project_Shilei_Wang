`timescale 1ns / 1ns

module tb_LNN();

reg 		sys_clk;
reg 		sys_reset;
reg [3:0]	values;
reg [0:0]	data_end;
	
wire  [3:0]	output_symbols;
wire  [0:0] Data_in_flag;

reg	   [9:0]	tb_counter;

initial 
	begin
	
	sys_clk   <= 1'b0;
	sys_reset <= 1'b0;
	
	end
	
always #5 sys_clk = ~sys_clk;

always@(posedge sys_clk or negedge sys_reset) //counter for the get single bit
begin
	if(~sys_reset) 
		begin
			# 5
			sys_reset <= 1'b1;
			tb_counter <= 0;
			data_end <= 1'b0;
		end
		
	else begin
		tb_counter <= tb_counter + 1;
	end
			
			
			
end

always@(tb_counter)
begin 

	case(tb_counter)
  0 : values <= 4'd0;
 1 : values <= 4'd0;
 2 : values <= 4'd0;
 3 : values <= 4'd0;
 4 : values <= 4'd0;
 5 : values <= 4'd0;
 6 : values <= 4'd0;
 7 : values <= 4'd0;
 8 : values <= 4'd1;
 9 : values <= 4'd0;
 10 : values <= 4'd0;
 11 : values <= 4'd0;
 12 : values <= 4'd0;
 13 : values <= 4'd1;
 14 : values <= 4'd0;
 15 : values <= 4'd0;
 16 : values <= 4'd0;
 17 : values <= 4'd0;
 18 : values <= 4'd0;
 19 : values <= 4'd0;
 20 : values <= 4'd0;
 21 : values <= 4'd0;
 22 : values <= 4'd0;
 23 : values <= 4'd1;
 24 : values <= 4'd0;
 25 : values <= 4'd0;
 26 : values <= 4'd1;
 27 : values <= 4'd0;
 28 : values <= 4'd0;
 29 : values <= 4'd1;
 30 : values <= 4'd0;
 31 : values <= 4'd0;
 32 : values <= 4'd0;
 33 : values <= 4'd0;
 34 : values <= 4'd0;
 35 : values <= 4'd0;
 36 : values <= 4'd0;
 37 : values <= 4'd0;
 38 : values <= 4'd0;
 39 : values <= 4'd0;
 40 : values <= 4'd1;
 41 : values <= 4'd0;
 42 : values <= 4'd0;
 43 : values <= 4'd0;
 44 : values <= 4'd0;
 45 : values <= 4'd0;
 46 : values <= 4'd0;
 47 : values <= 4'd0;
 48 : values <= 4'd0;
 49 : values <= 4'd0;
 50 : values <= 4'd0;
 51 : values <= 4'd0;
 52 : values <= 4'd0;
 53 : values <= 4'd0;
 54 : values <= 4'd0;
 55 : values <= 4'd0;
 56 : values <= 4'd0;
 57 : values <= 4'd1;
 58 : values <= 4'd1;
 59 : values <= 4'd1;
 60 : values <= 4'd0;
 61 : values <= 4'd0;
 62 : values <= 4'd0;
 63 : values <= 4'd0;
 64 : values <= 4'd0;
 65 : values <= 4'd0;
 66 : values <= 4'd0;
 67 : values <= 4'd0;
 68 : values <= 4'd0;
 69 : values <= 4'd0;
 70 : values <= 4'd0;
 71 : values <= 4'd0;
 72 : values <= 4'd0;
 73 : values <= 4'd0;
 74 : values <= 4'd0;
 75 : values <= 4'd0;
 76 : values <= 4'd0;
 77 : values <= 4'd1;
 78 : values <= 4'd0;
 79 : values <= 4'd0;
 80 : values <= 4'd0;
 81 : values <= 4'd0;
 82 : values <= 4'd0;
 83 : values <= 4'd0;
 84 : values <= 4'd0;
 85 : values <= 4'd0;
 86 : values <= 4'd0;
 87 : values <= 4'd0;
 88 : values <= 4'd0;
 89 : values <= 4'd0;
 90 : values <= 4'd0;
 91 : values <= 4'd0;
 92 : values <= 4'd0;
 93 : values <= 4'd0;
 94 : values <= 4'd0;
 95 : values <= 4'd0;
 96 : values <= 4'd0;
 97 : values <= 4'd0;
 98 : values <= 4'd0;
 99 : values <= 4'd0;
 100 : values <= 4'd1;
 101 : values <= 4'd0;
 102 : values <= 4'd0;
 103 : values <= 4'd0;
 104 : values <= 4'd0;
 105 : values <= 4'd0;
 106 : values <= 4'd0;
 107 : values <= 4'd0;
 108 : values <= 4'd0;
 109 : values <= 4'd0;
 110 : values <= 4'd2;
 111 : values <= 4'd0;
 112 : values <= 4'd0;
 113 : values <= 4'd0;
 114 : values <= 4'd0;
 115 : values <= 4'd0;
 116 : values <= 4'd0;
 117 : values <= 4'd0;
 118 : values <= 4'd0;
 119 : values <= 4'd1;
 120 : values <= 4'd0;
 121 : values <= 4'd0;
 122 : values <= 4'd0;
 123 : values <= 4'd0;
 124 : values <= 4'd0;
 125 : values <= 4'd0;
 126 : values <= 4'd0;
 127 : values <= 4'd0;
 128 : values <= 4'd0;
 129 : values <= 4'd0;
 130 : values <= 4'd0;
 131 : values <= 4'd0;
 132 : values <= 4'd0;
 133 : values <= 4'd0;
 134 : values <= 4'd0;
 135 : values <= 4'd0;
 136 : values <= 4'd0;
 137 : values <= 4'd0;
 138 : values <= 4'd0;
 139 : values <= 4'd0;
 140 : values <= 4'd0;
 141 : values <= 4'd1;
 142 : values <= 4'd0;
 143 : values <= 4'd0;
 144 : values <= 4'd0;
 145 : values <= 4'd1;
 146 : values <= 4'd0;
 147 : values <= 4'd0;
 148 : values <= 4'd0;
 149 : values <= 4'd0;
 150 : values <= 4'd0;
 151 : values <= 4'd0;
 152 : values <= 4'd0;
 153 : values <= 4'd1;
 154 : values <= 4'd1;
 155 : values <= 4'd0;
 156 : values <= 4'd0;
 157 : values <= 4'd0;
 158 : values <= 4'd0;
 159 : values <= 4'd0;
 160 : values <= 4'd0;
 161 : values <= 4'd0;
 162 : values <= 4'd0;
 163 : values <= 4'd0;
 164 : values <= 4'd0;
 165 : values <= 4'd0;
 166 : values <= 4'd0;
 167 : values <= 4'd0;
 168 : values <= 4'd0;
 169 : values <= 4'd0;
 170 : values <= 4'd0;
 171 : values <= 4'd0;
 172 : values <= 4'd0;
 173 : values <= 4'd1;
 174 : values <= 4'd0;
 175 : values <= 4'd0;
 176 : values <= 4'd0;
 177 : values <= 4'd0;
 178 : values <= 4'd0;
 179 : values <= 4'd0;
 180 : values <= 4'd0;
 181 : values <= 4'd0;
 182 : values <= 4'd0;
 183 : values <= 4'd0;
 184 : values <= 4'd0;
 185 : values <= 4'd0;
 186 : values <= 4'd0;
 187 : values <= 4'd0;
 188 : values <= 4'd0;
 189 : values <= 4'd0;
 190 : values <= 4'd0;
 191 : values <= 4'd0;
 192 : values <= 4'd0;
 193 : values <= 4'd0;
 194 : values <= 4'd0;
 195 : values <= 4'd0;
 196 : values <= 4'd1;
 197 : values <= 4'd0;
 198 : values <= 4'd0;
 199 : values <= 4'd0;
 200 : values <= 4'd0;
 201 : values <= 4'd0;
 202 : values <= 4'd0;
 203 : values <= 4'd0;
 204 : values <= 4'd0;
 205 : values <= 4'd0;
 206 : values <= 4'd0;
 207 : values <= 4'd0;
 208 : values <= 4'd0;
 209 : values <= 4'd0;
 210 : values <= 4'd0;
 211 : values <= 4'd0;
 212 : values <= 4'd0;
 213 : values <= 4'd0;
 214 : values <= 4'd0;
 215 : values <= 4'd1;
 216 : values <= 4'd0;
 217 : values <= 4'd0;
 218 : values <= 4'd0;
 219 : values <= 4'd0;
 220 : values <= 4'd0;
 221 : values <= 4'd0;
 222 : values <= 4'd0;
 223 : values <= 4'd0;
 224 : values <= 4'd0;
 225 : values <= 4'd0;
 226 : values <= 4'd0;
 227 : values <= 4'd0;
 228 : values <= 4'd0;
 229 : values <= 4'd0;
 230 : values <= 4'd0;
 231 : values <= 4'd0;
 232 : values <= 4'd0;
 233 : values <= 4'd0;
 234 : values <= 4'd0;
 235 : values <= 4'd0;
 236 : values <= 4'd0;
 237 : values <= 4'd0;
 238 : values <= 4'd0;
 239 : values <= 4'd0;
 240 : values <= 4'd0;
 241 : values <= 4'd0;
 242 : values <= 4'd0;
 243 : values <= 4'd0;
 244 : values <= 4'd0;
 245 : values <= 4'd0;
 246 : values <= 4'd0;
 247 : values <= 4'd0;
 248 : values <= 4'd0;
 249 : values <= 4'd0;
 250 : values <= 4'd0;
 251 : values <= 4'd0;
 252 : values <= 4'd0;
 253 : values <= 4'd0;
 254 : values <= 4'd0;
 255 : values <= 4'd0;
 256 : values <= 4'd0;
 257 : values <= 4'd0;
 258 : values <= 4'd0;
 259 : values <= 4'd0;
 260 : values <= 4'd0;
 261 : values <= 4'd1;
 262 : values <= 4'd1;
 263 : values <= 4'd0;
 264 : values <= 4'd0;
 265 : values <= 4'd0;
 266 : values <= 4'd0;
 267 : values <= 4'd0;
 268 : values <= 4'd0;
 269 : values <= 4'd0;
 270 : values <= 4'd0;
 271 : values <= 4'd0;
 272 : values <= 4'd0;
 273 : values <= 4'd0;
 274 : values <= 4'd0;
 275 : values <= 4'd0;
 276 : values <= 4'd0;
 277 : values <= 4'd0;
 278 : values <= 4'd0;
 279 : values <= 4'd0;
 280 : values <= 4'd0;
 281 : values <= 4'd0;
 282 : values <= 4'd0;
 283 : values <= 4'd0;
 284 : values <= 4'd0;
 285 : values <= 4'd0;
 286 : values <= 4'd1;
 287 : values <= 4'd0;
 288 : values <= 4'd0;
 289 : values <= 4'd0;
 290 : values <= 4'd0;
 291 : values <= 4'd1;
 292 : values <= 4'd1;
 293 : values <= 4'd0;
 294 : values <= 4'd0;
 295 : values <= 4'd0;
 296 : values <= 4'd0;
 297 : values <= 4'd1;
 298 : values <= 4'd0;
 299 : values <= 4'd0;
 300 : values <= 4'd0;
 301 : values <= 4'd0;
 302 : values <= 4'd0;
 303 : values <= 4'd0;
 304 : values <= 4'd0;
 305 : values <= 4'd0;
 306 : values <= 4'd0;
 307 : values <= 4'd0;
 308 : values <= 4'd0;
 309 : values <= 4'd0;
 310 : values <= 4'd0;
 311 : values <= 4'd0;
 312 : values <= 4'd0;
 313 : values <= 4'd0;
 314 : values <= 4'd0;
 315 : values <= 4'd0;
 316 : values <= 4'd0;
 317 : values <= 4'd0;
 318 : values <= 4'd0;
 319 : values <= 4'd0;
 320 : values <= 4'd1;
 321 : values <= 4'd1;
 322 : values <= 4'd0;
 323 : values <= 4'd0;
 324 : values <= 4'd0;
 325 : values <= 4'd0;
 326 : values <= 4'd0;
 327 : values <= 4'd0;
 328 : values <= 4'd0;
 329 : values <= 4'd0;
 330 : values <= 4'd0;
 331 : values <= 4'd0;
 332 : values <= 4'd1;
 333 : values <= 4'd0;
 334 : values <= 4'd0;
 335 : values <= 4'd0;
 336 : values <= 4'd0;
 337 : values <= 4'd1;
 338 : values <= 4'd0;
 339 : values <= 4'd1;
 340 : values <= 4'd0;
 341 : values <= 4'd0;
 342 : values <= 4'd0;
 343 : values <= 4'd0;
 344 : values <= 4'd0;
 345 : values <= 4'd1;
 346 : values <= 4'd1;
 347 : values <= 4'd0;
 348 : values <= 4'd0;
 349 : values <= 4'd0;
 350 : values <= 4'd0;
 351 : values <= 4'd0;
 352 : values <= 4'd0;
 353 : values <= 4'd0;
 354 : values <= 4'd0;
 355 : values <= 4'd0;
 356 : values <= 4'd0;
 357 : values <= 4'd0;
 358 : values <= 4'd0;
 359 : values <= 4'd0;
 360 : values <= 4'd0;
 361 : values <= 4'd0;
 362 : values <= 4'd0;
 363 : values <= 4'd0;
 364 : values <= 4'd0;
 365 : values <= 4'd1;
 366 : values <= 4'd0;
 367 : values <= 4'd0;
 368 : values <= 4'd0;
 369 : values <= 4'd0;
 370 : values <= 4'd0;
 371 : values <= 4'd0;
 372 : values <= 4'd0;
 373 : values <= 4'd0;
 374 : values <= 4'd0;
 375 : values <= 4'd0;
 376 : values <= 4'd0;
 377 : values <= 4'd0;
 378 : values <= 4'd0;
 379 : values <= 4'd0;
 380 : values <= 4'd0;
 381 : values <= 4'd0;
 382 : values <= 4'd0;
 383 : values <= 4'd0;
 384 : values <= 4'd0;
 385 : values <= 4'd1;
 386 : values <= 4'd1;
 387 : values <= 4'd0;
 388 : values <= 4'd0;
 389 : values <= 4'd0;
 390 : values <= 4'd0;
 391 : values <= 4'd0;
 392 : values <= 4'd1;
 393 : values <= 4'd0;
 394 : values <= 4'd0;
 395 : values <= 4'd0;
 396 : values <= 4'd0;
 397 : values <= 4'd0;
 398 : values <= 4'd0;
 399 : values <= 4'd0;
 400 : values <= 4'd0;
 401 : values <= 4'd0;
 402 : values <= 4'd0;
 403 : values <= 4'd0;
 404 : values <= 4'd0;
 405 : values <= 4'd0;
 406 : values <= 4'd0;
 407 : values <= 4'd1;
 408 : values <= 4'd1;
 409 : values <= 4'd0;
 410 : values <= 4'd1;
 411 : values <= 4'd0;
 412 : values <= 4'd0;
 413 : values <= 4'd0;
 414 : values <= 4'd0;
 415 : values <= 4'd0;
 416 : values <= 4'd0;
 417 : values <= 4'd0;
 418 : values <= 4'd0;
 419 : values <= 4'd0;
 420 : values <= 4'd0;
 421 : values <= 4'd0;
 422 : values <= 4'd0;
 423 : values <= 4'd0;
 424 : values <= 4'd1;
 425 : values <= 4'd0;
 426 : values <= 4'd0;
 427 : values <= 4'd0;
 428 : values <= 4'd0;
 429 : values <= 4'd0;
 430 : values <= 4'd0;
 431 : values <= 4'd0;
 432 : values <= 4'd0;
 433 : values <= 4'd1;
 434 : values <= 4'd0;
 435 : values <= 4'd0;
 436 : values <= 4'd0;
 437 : values <= 4'd0;
 438 : values <= 4'd0;
 439 : values <= 4'd0;
 440 : values <= 4'd0;
 441 : values <= 4'd0;
 442 : values <= 4'd0;
 443 : values <= 4'd0;
 444 : values <= 4'd0;
 445 : values <= 4'd0;
 446 : values <= 4'd0;
 447 : values <= 4'd0;
 448 : values <= 4'd0;
 449 : values <= 4'd0;
 450 : values <= 4'd0;
 451 : values <= 4'd0;
 452 : values <= 4'd0;
 453 : values <= 4'd0;
 454 : values <= 4'd0;
 455 : values <= 4'd0;
 456 : values <= 4'd0;
 457 : values <= 4'd0;
 458 : values <= 4'd0;
 459 : values <= 4'd0;
 460 : values <= 4'd0;
 461 : values <= 4'd0;
 462 : values <= 4'd0;
 463 : values <= 4'd0;
 464 : values <= 4'd0;
 465 : values <= 4'd0;
 466 : values <= 4'd0;
 467 : values <= 4'd0;
 468 : values <= 4'd0;
 469 : values <= 4'd0;
 470 : values <= 4'd0;
 471 : values <= 4'd1;
 472 : values <= 4'd0;
 473 : values <= 4'd0;
 474 : values <= 4'd0;
 475 : values <= 4'd0;
 476 : values <= 4'd0;
 477 : values <= 4'd0;
 478 : values <= 4'd0;
 479 : values <= 4'd0;
 
 
	 

	default:begin 
		values <= 4'dz;
		data_end <= 1'b1;
	end 
	endcase

end 


LNN LNN_inst
(
	.sys_clk(sys_clk),
	.sys_reset(sys_reset),
	.values(values),
	.data_end(data_end),
	
	.output_symbols(output_symbols),
	.Data_in_flag(Data_in_flag)


);

endmodule