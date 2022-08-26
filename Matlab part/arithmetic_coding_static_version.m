

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %encoding part%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [average_length, decoded_result] = arithmetic_coding_static_version(input_data) 
% choose error or compresssed_data
% input_data = compressed_data;

[symbols, ~, input] = unique( (input_data(:))' );

% counts the apperance of values in error sequence
counts = (accumarray(input, 1 ))';

input = input';

% Compute the cumulative counts vector from the counts 
% cum_counts = [0, (cumsum(counts)/size(input_data,1)) ];
cum_counts = [0,1,2,72,90,95,96];
% Compute the Word Length required.
total_count = cum_counts(end);

% The smallest the code range can be one-quarter of the total available range of 2^N values
N = ceil(log2(total_count)) + 2;

% repeat the compression for 100 times to get the average compressed value
for iteration = 1:size(input_data,1) 


        input_values = input_data(iteration, :)';

        % Initialize the lower and upper bounds.
        lower_bound = 0;
        upper_bound = 2^N-1;
        E3_counter = 0;
        code_index = 1;
        
        % Loop for each symbol in SEQ
        for k = 1:length(input_values)
        
           

                switch input_values(k)
                case 0
                    symbol = 1;
                case 1
                    symbol = 2;
                case 2
                    symbol = 3;
                case 3
                    symbol = 4;
                case 4
                    symbol = 5;
                case 5
                    symbol = 6;
                end 
            code_range = upper_bound-lower_bound+1;
        
            % Compute the new upper bound
            upper_bound = lower_bound + floor( code_range*cum_counts(symbol+1)/total_count )-1;
        
            % Compute the new lower bound
            lower_bound = lower_bound + floor( code_range*cum_counts(symbol+1-1)/total_count );
            
            %E1 mapping: [0,0.5) -> [0,1) E1(x) = 2x;      
            %E2 mapping: [0.5,1) -> [0,1) E2(x) = 2(x-0.5);
            %E3 mapping: [0.25,0.75) -> [0,1) E3(x) = 2(x-0.25);
            
            % decide E1, E2 or E3 mapping
            while( (bitget(lower_bound, N) == bitget(upper_bound, N)) || ...
                ((bitget(lower_bound, N-1) == 1) && (bitget(upper_bound, N-1) == 0) ) )
                
                %If MSBs of upper and lower boundS are the same, it is E1 or E2 mapping
                if (bitget(lower_bound, N) == bitget(upper_bound, N))
        
                    % Get the MSB
                    b = bitget(lower_bound, N);
                    code(code_index) = b;
                    code_index = code_index + 1;
                
                    % Left shifts
                    lower_bound = bitshift(lower_bound, 1) + 0;
                    upper_bound = bitshift(upper_bound, 1) + 1;
                    
                    % Check if E3_counter is non-zero and transmit appropriate bits
                    if (E3_counter > 0)
                        % Have to transmit complement of b, E3_count times.
                        code(code_index:code_index+E3_counter-1) = (~b).*ones(1, E3_counter);
                        code_index = code_index + E3_counter;
                        E3_counter = 0;
                    end
                    
                %If the second MSB of upper bound is 0 and the second MSB of lower bound is 1, it is E3    
                elseif ( (bitget(lower_bound, N-1) == 1) && (bitget(upper_bound, N-1) == 0) )
                    
                    % Left shifts
                    lower_bound = bitshift(lower_bound, 1) + 0;
                    upper_bound  = bitshift(upper_bound, 1) + 1;
        
                    % Complement the new MSB of lower_bound and upper_bound
                    lower_bound = bitxor(lower_bound, 2^(N-1) );
                    upper_bound  = bitxor(upper_bound, 2^(N-1) );
                    
                    % Increment E3 mapping counter
                    E3_counter = E3_counter+1;
                end
        
                    % This step will not be implemented on verilog, the first bit will be abandoned automatically after bit shift.
                    % Reduce to N for next loop, 2^N-1 = 511 = binary(01_1111_1111),
                    % abandon the 10th bit
                     lower_bound = bitand(lower_bound,2^N-1);
                     upper_bound = bitand(upper_bound,2^N-1);
        
            end
        end
         
        % Ending of encoding
        bin_low = int2bit(lower_bound, N, true);
        if E3_counter==0
            % Transmit the final value of the lower bound bin_low       
            code(code_index:code_index + N - 1) = bin_low;
            code_index = code_index + N;
        else
           % Transmit the MSB of bin_low. 
           b = bin_low(1);
           code(code_index) = b;
           code_index = code_index + 1;
           
           % Then transmit complement of b (MSB of bin_low), E3_counter times. 
           code(code_index:code_index+E3_counter-1) = (~b).*ones(1, E3_counter);
           code_index = code_index + E3_counter;
        
           % Then transmit the remaining bits of bin_low
           code(code_index:code_index+N-2) = bin_low(2:N);
           code_index = code_index + N - 1;
        end          
        
        % Output the filled values
        code = code(1:code_index-1);
        
        
             
        
        
        
        
%%        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                    %decoding part%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Initialize the lower and upper bounds for decoding part.
        lower_bound = 0;
        upper_bound = 2^N-1;
        
        % Read in the first N number of bits 
        bitstream = code(1:N);
        decode_tag = bit2int(bitstream', N, true);
        
        len = size(input_data,2);
        % Initialize decode
        decode = zeros(1,len);
        decode_index = 1;
        
        k = N;
        
        % This loop runs until all the symbols are decoded into decode
        while (decode_index <= len)
            
            % Compute decode_tag_new
            decode_tag_new = floor( ((decode_tag-lower_bound+1)*total_count-1)/(upper_bound-lower_bound+1) );
            
            % Find where value is positioned
            if decode_tag_new == cum_counts(end)
                position = length(cum_counts)-1;       
            else
                c = find(cum_counts <= decode_tag_new);
                position = c(end);
            end
        
            
            % Update decode by adding the decoded symbol
            decode(decode_index) = position;
            decode_index = decode_index + 1;
            
            code_range = upper_bound-lower_bound+1;
        
            % Compute the new upper bound
            upper_bound = lower_bound + floor( code_range*cum_counts(position+1)/total_count )-1;
        
            % Compute the new lower bound
            lower_bound = lower_bound + floor( code_range*cum_counts(position+1-1)/total_count );
        
            % decide E1, E2 or E3 mapping
             while ( (bitget(lower_bound, N) == bitget(upper_bound, N)) || ...
                     ( (bitget(lower_bound, N-1) == 1) && (bitget(upper_bound, N-1) == 0) ) )
                
                % Break out if all the bits in code are decoded
                if ( k==length(code) )
                    break
                end
                k = k + 1;
        
                % If MSBs of upper and lower boundS are the same, it is E1 or E2 mapping
                if ( bitget(lower_bound, N) == bitget(upper_bound, N) )
        
                    % Left shifts
                    lower_bound = bitshift(lower_bound, 1) + 0;
                    upper_bound  = bitshift(upper_bound,  1) + 1;
        
                    % Left shift and read in new bit of code
                    decode_tag = bitshift(decode_tag, 1) + code(k);
        
                    % Reduce to N for next loop
                    decode_tag = bitand(decode_tag,2^N-1);
                
                % If the second MSB of upper bound is 0 and the second MSB of lower bound is 1, it is E3      
                elseif ( (bitget(lower_bound, N-1) == 1) && (bitget(upper_bound, N-1) == 0) )
        
                    % Left shifts and update
                    lower_bound = bitshift(lower_bound, 1) + 0;
                    upper_bound  = bitshift(upper_bound,  1) + 1;
        
                    % Left shift and read in code
                    decode_tag = bitshift(decode_tag, 1) + code(k);
        
                    % Reduce to N for next loop
                    decode_tag = bitand(decode_tag,2^N-1);
                    
                    % Complement the new MSB of lower_bound, upper_bound and decode_tag
                    lower_bound = bitxor(lower_bound, 2^(N-1) );
                    upper_bound  = bitxor(upper_bound,  2^(N-1) );
                    decode_tag = bitxor(decode_tag, 2^(N-1) );
        
                end
        
                    % Reduce to N for next loop, 2^N-1 = 511 = binary(01_1111_1111),
                    % abandon the 10th bit
                     lower_bound = bitand(lower_bound,2^N-1);
                     upper_bound = bitand(upper_bound,2^N-1);
             end
        end 
        
        decoded_result(iteration,:) = symbols(decode);
        
        transmission_length(iteration,:) = length(code); 
end



average_length = sum(transmission_length)/size(input_data,1);


end 