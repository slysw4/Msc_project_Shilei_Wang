% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % predict using the latest data from transmitter 1 order predictor
% 
% close all;
% clear all;
% clc
% 
% % load("Data_BP_1_Rec_1_Subject_1.mat")
% load('reordered_binned_data.mat')
% binned_MUA = reordered_binned_data;
% 
% data1 = binned_MUA(1:50,1:96);
% data1 = sum(data1,1);
% data1(data1(:)>3)=3;
% 
% data2 = binned_MUA(51:100,1:96);
% data2 = sum(data2,1);
% data2(data2(:)>3)=3;
% 
% mu1=0.001;
% mu2=0.001;
% 
% data_square = [0 data2(1:8) 0 data2(9:88) 0 data2(89:96) 0];
% 
% % quantization
% data_square = (reshape(data_square,10,10))';
% 
% 
% %% LMS
% iteration = 100;
%     weight_time_1 = zeros(iteration+1,96);
%     weight_time_2 = ones(iteration+1,96);
% for i=1:iteration
% %     data(i,:) = binned_MUA(1 + 50*(i-1) : 50*i,1:96);
%     data_training(i,:) = sum(binned_MUA(1 + 50*(i-1) : 50*i,1:96),1);
%     data_training(i,data_training(i,:)>3)=3;
% 
%     N=size(data_training,2); 
% 
%     if i >= 2
%         % Estimated x is x(n+1)
%         estimated_x(i,:) =  weight_time_1(i,:).*data_training(i-1,:);
%         
%         % Error calculation
%         error_training(i,:) = data_training(i,:)-(estimated_x(i,:)); 
% 
%         weight_time_1(i+1,:) = weight_time_1(i,:) + mu1*error_training(i,:).*data_training(i-1,:);
%                                
%     end
% 
% end
% 
% weight_time_1 = roundn(weight_time_1,-1);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% generate the transmission coding
% % prediction: generate the error to be sent
% load saved_samples.mat
% iteration2 = 100;
% for i=1:iteration2
%     data(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
%     data(i,data(i,:)>3)=3;
% 
% 
% 
%     if i >=2
% 
%         data_difference(i,:) = data(i,:) - data(i-1,:);
%     
%         data_difference_square = [0 data_difference(i,1:8) 0 data_difference(i,9:88) 0 data_difference(i,89:96) 0];
%     
%         data_difference_table(:,:,i) = (reshape(data_difference_square,10,10))';
%     % Estimated x is x(n+1)
% %     data(i,:) = data(i,:) - data(i-1,:);
% %%%%%%%%%%% by column in time sequence %%%%%%%%%%%%%%%
% %     for j = 1:96
% %          bit_change(i,j) = data(i,j) - data(i-1,j);
% %          
% %     end 
% % 
% %     data(i-1,:) = bit_change(i,:);
% 
% %%%%%%%%%% by row in channel sequence %%%%%%%%%%%%%%%
%     
%     
%     prediction_x(i,:) =  round(weight_time_1(101,:).*data(i-1,:));
%     
%     % Error calculation
%     data_square = [0 data(i,1:8) 0 data(i,9:88) 0 data(i,89:96) 0];
%     data_table(:,:,i) = (reshape(data_square,10,10))';
%     error_raw(i,:) = (data(i,:)-(prediction_x(i,:)));
%     
% %         error_raw_square = [0 error_raw(i,1:8) 0 error_raw(i,9:88) 0 error_raw(i,89:96) 0];
% %     
% %         error_raw_table(:,:,i) = (reshape(error_raw_square,10,10))';
% %     
% %     
% %     bit_change_row(i,1) = error_raw(i,1);
% %     flag = 0;
% %     for j = 2:95
% %     
% %     
% %         if  not (and (and( error_raw(i,j), error_raw(i,j-1) ) , error_raw(i,j+1) ))
% %             bit_change_row(i,j) = error_raw(i,j);
% %     
% %         else 
% %             bit_change_row(i,j) = error_raw(i,j) - error_raw(i,j-1);
% %             bit_change_row(i,j+1) = error_raw(i,j+1) - error_raw(i,j);
% %     %             bit_change(i,j+2) = error_raw(i,j+2) - error_raw(i,j+1);
% %     %             flag = 2;
% %         end 
% %     end 
% %     bit_change_row(i,96) = error_raw(i,96);
% %     
% %     %%%%%%%%%%%%%%%%%%%%%%apply differential in rows%%%%%%%%%%%%%%
% %     bit_change_row_square(:,:,i) = [0 bit_change_row(i,1:8) 0 bit_change_row(i,9:88) 0 bit_change_row(i,89:96) 0];
% %     %     
% %     bit_change_row_table(:,:,i) = (reshape(bit_change_row_square(:,:,i),10,10))';
% %     
% %     bit_change_horizon = bit_change_row_table(:,:,i); 
% %     for index_col = 1:10
% %         for index_row = 2:9
% %             if  not (and (and( bit_change_row_table(index_row,index_col,i), bit_change_row_table(index_row-1,index_col,i) ) , bit_change_row_table(index_row+1,index_col,i) ))
% %                  bit_change_horizon(index_row,index_col) = bit_change_row_table(index_row,index_col,i);
% %             else
% %                  bit_change_horizon(index_row,index_col) = bit_change_row_table(index_row,index_col,i) - bit_change_row_table(index_row-1,index_col,i);
% %                  bit_change_horizon(index_row+1,index_col) = bit_change_row_table(index_row+1,index_col,i) - bit_change_row_table(index_row,index_col,i);
% %             end 
% %         end 
% %     end 
% %     
% %     bit_change_horizon = reshape(bit_change_horizon,1,100);
% %     
% %     error(i,:) = [bit_change_horizon(2:9) bit_change_horizon(11:90) bit_change_horizon(92:99)] ;
% % 
% % 
% %     error = bit_change_row;
% 
%     error = error_raw;
% 
%    
% 
%         error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];
%    
%         error_table(:,:,i) = (reshape(error_square,10,10))';
% 
%     %calculate frequency and its probability for each quantized value
%     [glow,~,intensity_val] = grp2idx(saved_samples(i,:));
%     Frequency = accumarray(glow,1);
%     probability = Frequency./(size(saved_samples,2));
%     T = table(intensity_val ,Frequency,probability);
%     
%     %perform huffman coding
%     dict=huffmandict(intensity_val,probability);
%     encode_I = huffmanenco( saved_samples(i,:) ,dict);
% 
%     transmission_length(i,1)  = length(encode_I);
% 
%     %perform huffman decoding
%     decode_I = huffmandeco(encode_I,dict);
% %     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
%     error_received(i,:) = decode_I;
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reconstruction at the receiver end
% 
% 
% 
% for i = 1:iteration2
% 
%     data_received( i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
%     data_received( i,  data_received(i,:) > 3  ) = 3;
% 
%     if i >=2
%        prediction_x_received(i,:) =  round(weight_time_1(101,:).*data_received(i-1,:));
% 
%        reconstructed_x(i,:) = prediction_x_received(i,:) + error_received(i,:);
%        data_received(i,:) = reconstructed_x(i,:);
%     end
% end
% 
% reconstructed_error = (data-reconstructed_x);
% total_error = sum(sum(reconstructed_error(3:end,:),2))
% mean(transmission_length)
% 
% save error.mat error error_table






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % predict using the latest data from transmitter  2 order predictor
% 
% close all;
% clear all;
% clc
% 
% load("Data_BP_1_Rec_1_Subject_1.mat")
% 
% % load('reordered_binned_data.mat')
% % binned_MUA = reordered_binned_data;
% data1 = binned_MUA(1:50,1:96);
% data1 = sum(data1,1);
% data1(data1(:)>3)=3;
% 
% data2 = binned_MUA(51:100,1:96);
% data2 = sum(data2,1);
% data2(data2(:)>3)=3;
% 
% mu1=0.01;
% mu2=0.01;
% 
% data_square = [0 data2(1:8) 0 data2(9:88) 0 data2(89:96) 0];
% 
% % quantization
% data_square = (reshape(data_square,10,10))';
% 
% 
% %% LMS
% iteration = 100;
%     weight_time_1 = zeros(iteration+1,96);
%     weight_time_2 = zeros(iteration+1,96);
% for i=1:iteration
% %     data(i,:) = binned_MUA(1 + 50*(i-1) : 50*i,1:96);
%     data_training(i,:) = sum(binned_MUA(1 + 50*(i-1) : 50*i,1:96),1);
%     data_training(i,data_training(i,:)>3)=3;
% 
%     N=size(data_training,2); 
% %     estimated_x = zeros(N,1);
% 
% 
%     if i >=3
%                     % Estimated x is x(n+1)
%                     estimated_x(i,:) =  (weight_time_1(i,:).*data_training(i-1,:) + weight_time_2(i,:).*data_training(i-2,:));
%                     
%                     % Error calculation
%                     error(i,:)=data_training(i,:)-(estimated_x(i,:)); 
% 
%                     % LMS update rule
% %                   weight_spatial(:,n) = weight_spatial(:,n) + mu1*error(n)*data(:,n);
% 
%                     weight_time_1(i+1,:) = weight_time_1(i,:) + mu1*error(i,:).*data_training(i-1,:);
%                     weight_time_2(i+1,:) = weight_time_2(i,:) + mu1*error(i,:).*data_training(i-2,:);
% 
% %                     error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];
% % 
% %                     error_table(:,:,i) = (reshape(error_square,10,10))';
% % 
% %     %calculate frequency and its probability for each quantized value
% %     [glow,~,intensity_val] = grp2idx(error_square);
% %     Frequency = accumarray(glow,1);
% %     probability = Frequency./(100);
% %     T = table(intensity_val ,Frequency,probability);
% %     
% %     %perform huffman coding
% %     dict=huffmandict(intensity_val,probability);
% %     encode_I = huffmanenco( error_square ,dict);
% % 
% %     transmission_length(i,1)  = length(encode_I)
% % 
% %     %perform huffman decoding
% %     decode_I = huffmandeco(encode_I,dict);
% %     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
%               
%     end
% %     error_mu1(i,:)=error;
%        
% end
% 
% weight_time_1 = roundn(weight_time_1,-1);
% weight_time_2 = roundn(weight_time_2,-1);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% generate the transmission coding
% % prediction: generate the error to be sent
% for i=1:iteration
%     data(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
%     data(i,data(i,:)>3)=3;
% 
%     if i >=3
%     % Estimated x is x(n+1)
%     prediction_x(i,:) =  round(weight_time_1(101,:).*data(2,:) + weight_time_2(101,:).*data(1,:));
% 
%     % Error calculation
%     error(i,:)=data(i,:)-(prediction_x(i,:));
%     data(1,:) = data(2,:);
%     data(2,:) = prediction_x(i,:);
% 
%                     error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];
% 
%                     error_table(:,:,i) = (reshape(error_square,10,10))';
% 
%     %calculate frequency and its probability for each quantized value
%     [glow,~,intensity_val] = grp2idx(error(i,:));
%     Frequency = accumarray(glow,1);
%     probability = Frequency./(size(error,2));
%     T = table(intensity_val ,Frequency,probability);
%     
%     %perform huffman coding
%     dict=huffmandict(intensity_val,probability);
%     encode_I = huffmanenco( error(i,:) ,dict);
% 
%     transmission_length(i,1)  = length(encode_I);
% 
%     %perform huffman decoding
%     decode_I = huffmandeco(encode_I,dict);
% %     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
%     error_received(i,:) = decode_I;
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reconstruction at the receiver end
% for i = 1:iteration
%     data_received(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
%     data_received(i,data_received(i,:)>3)=3;
% 
%     if i >=3
%        prediction_x_received(i,:) =  round(weight_time_1(101,:).*data_received(2,:) + weight_time_2(101,:).*data_received(1,:));
% 
%        reconstructed_x(i,:) = prediction_x_received(i,:) + error_received(i,:);
%        data_received(1,:) = data_received(2,:);
%        data_received(2,:) = prediction_x_received(i,:);
%     end
% end
% % reconstructed_x(:,66) =0 ;
% reconstructed_error = (data-reconstructed_x);
% total_error = sum(sum(reconstructed_error(3:end,:),2))
% mean(transmission_length)
% save error.mat error error_table



















% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % predict using the latest data from transmitter  2 order predictor
% 
% close all;
% clear all;
% clc
% 
% load("Data_BP_1_Rec_1_Subject_1.mat")
% % load('reordered_binned_data.mat')
% % binned_MUA = reordered_binned_data;
% 
% data1 = binned_MUA(1:50,1:96);
% data1 = sum(data1,1);
% data1(data1(:)>3)=3;
% 
% data2 = binned_MUA(51:100,1:96);
% data2 = sum(data2,1);
% data2(data2(:)>3)=3;
% 
% mu1=0.001;
% mu2=0.001;
% 
% data_square = [0 data2(1:8) 0 data2(9:88) 0 data2(89:96) 0];
% 
% % quantization
% data_square = (reshape(data_square,10,10))';
% 
% 
% %% LMS
% iteration = 100;
%     weight_time_1 = zeros(iteration+1,96);
%     weight_time_2 = zeros(iteration+1,96);
% for i=1:iteration
% %     data(i,:) = binned_MUA(1 + 50*(i-1) : 50*i,1:96);
%     data_training(i,:) = sum(binned_MUA(1 + 50*(i-1) : 50*i,1:96),1);
%     data_training(i,data_training(i,:)>3)=3;
% 
%     N=size(data_training,2); 
% 
%     if i >=3
%                     % Estimated x is x(n+1)
%                     estimated_x(i,:) =  (weight_time_1(i,:).*data_training(i-1,:) + weight_time_2(i,:).*data_training(i-2,:));
%                     
%                     % Error calculation
%                     error_training(i,:)=data_training(i,:)-(estimated_x(i,:)); 
% 
%                     % LMS update rule
% %                   weight_spatial(:,n) = weight_spatial(:,n) + mu1*error(n)*data(:,n);
% 
%                     weight_time_1(i+1,:) = weight_time_1(i,:) + mu1*error_training(i,:).*data_training(i-1,:);
%                     weight_time_2(i+1,:) = weight_time_2(i,:) + mu1*error_training(i,:).*data_training(i-2,:);
% 
% %                     error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];
% % 
% %                     error_table(:,:,i) = (reshape(error_square,10,10))';
% % 
% %     %calculate frequency and its probability for each quantized value
% %     [glow,~,intensity_val] = grp2idx(error_square);
% %     Frequency = accumarray(glow,1);
% %     probability = Frequency./(100);
% %     T = table(intensity_val ,Frequency,probability);
% %     
% %     %perform huffman coding
% %     dict=huffmandict(intensity_val,probability);
% %     encode_I = huffmanenco( error_square ,dict);
% % 
% %     transmission_length(i,1)  = length(encode_I)
% % 
% %     %perform huffman decoding
% %     decode_I = huffmandeco(encode_I,dict);
% %     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
%               
%     end
% %     error_mu1(i,:)=error;
%        
% end
% 
% weight_time_1 = roundn(weight_time_1,-1);
% weight_time_2 = roundn(weight_time_2,-1);
% % weight_time_3 = roundn(weight_time_3,-1);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% generate the transmission coding
% % prediction: generate the error to be sent
% iteration2=100;
% for i=1:iteration2
%     data(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
%     data(i,data(i,:)>3)=3;
% 
%     if i >=3
%     % Estimated x is x(n+1)
%     prediction_x(i,:) =  round(weight_time_1(101,:).*data(i-1,:) + weight_time_2(101,:).*data(i-2,:));
% 
%     % Error calculation
%     error(i,:)= (data(i,:)-(prediction_x(i,:)));
% %     data(i-2,:) = data(i-1,:);
% %     data(i-1,:) = prediction_x(i,:);
% 
%                     error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];
% 
%                     error_table(:,:,i) = (reshape(error_square,10,10))';
% 
%     %calculate frequency and its probability for each quantized value
%     [glow,~,intensity_val] = grp2idx(error(i,:));
%     Frequency = accumarray(glow,1);
%     probability = Frequency./(size(error,2));
%     T = table(intensity_val ,Frequency,probability);
%     
%     %perform huffman coding
%     dict=huffmandict(intensity_val,probability);
%     encode_I = huffmanenco( error(i,:) ,dict);
% 
%     transmission_length(i,1)  = length(encode_I);
% 
%     %perform huffman decoding
%     decode_I = huffmandeco(encode_I,dict);
% %     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
%     error_received(i,:) = decode_I;
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reconstruction at the receiver end
% for i = 1:iteration2
%     data_received(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
%     data_received(i,data_received(i,:)>3)=3;
% 
%     if i >=3
%        prediction_x_received(i,:) =  round(weight_time_1(101,:).*data_received(2,:) + weight_time_2(101,:).*data_received(1,:));
% 
%        reconstructed_x(i,:) = prediction_x_received(i,:) + error_received(i,:);
%        data_received(1,:) = data_received(2,:);
%        data_received(2,:) = reconstructed_x(i,:);
%     end
% end
% % reconstructed_x(:,66) =0 ;
% reconstructed_error = (data-reconstructed_x);
% total_error = sum(sum(reconstructed_error(3:end,:),2))
% mean(transmission_length)
% 
% save error.mat error error_table










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predict using the latest data from transmitter  3 order predictor
% adaptive version

close all;
clear all;
clc

load("Data_BP_1_Rec_1_Subject_1.mat")
% load('reordered_binned_data.mat')
% binned_MUA = reordered_binned_data;
mu1(4)=0.001;
mu2(4)=0.0005;
mu3(4)=0.0001;
phi_1(4) = 0.001;
phi_2(4) = 0.001;
phi_3(4) = 0.001;
rho = 0.00006;

%% LMS

iteration = 100;
    weight_time_1 = zeros(iteration+1,96);
    weight_time_2 = zeros(iteration+1,96);
    weight_time_3 = zeros(iteration+1,96);
for i=1:iteration
%     data(i,:) = binned_MUA(1 + 50*(i-1) : 50*i,1:96);
    data_training(i,:) = sum(binned_MUA(1 + 50*(i-1) : 50*i,1:96),1);
    data_training(i,data_training(i,:)>3)=3;

    N=size(data_training,2); 

    if i >=4
        for ichannel = 1:96
        % Estimated x is x(n+1)
            estimated_x(i,ichannel) =  (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
                + weight_time_3(i,ichannel).*data_training(i-3,ichannel));
            
            % Error calculation
            error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
    
            % LMS update rule
    %                   weight_spatial(:,n) = weight_spatial(:,n) + mu1*error(n)*data(:,n);
    
            weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1(i)*error_training(i,ichannel).*data_training(i-1,ichannel);
            weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2(i)*error_training(i,ichannel).*data_training(i-2,ichannel);
            weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3(i)*error_training(i,ichannel).*data_training(i-3,ichannel);
    
            mu1(i+1) = mu1(i) + rho * error_training(i,ichannel) * data_training(i-1,ichannel)' * phi_1(i);
            mu2(i+1) = mu2(i) + rho * error_training(i,ichannel) * data_training(i-2,ichannel)' * phi_2(i);
            mu3(i+1) = mu3(i) + rho * error_training(i,ichannel) * data_training(i-3,ichannel)' * phi_3(i);
    
            phi_1(i+1) = error_training(i,ichannel) * (data_training(i-1,ichannel))';
            phi_2(i+1) = error_training(i,ichannel) * (data_training(i-2,ichannel))';
            phi_3(i+1) = error_training(i,ichannel) * (data_training(i-3,ichannel))';

        end 
%                     error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];
% 
%                     error_table(:,:,i) = (reshape(error_square,10,10))';
% 
  
    end
%     error_mu1(i,:)=error;
       
end

% weight_time_1 = roundn(weight_time_1,-1);
% weight_time_2 = roundn(weight_time_2,-1);
% weight_time_3 = roundn(weight_time_3,-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generate the transmission coding
% prediction: generate the error to be sent
iteration2=100;
for i=1:iteration2
    data(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
    data(i,data(i,:)>3)=3;

    if i >= 4
    % Estimated x is x(n+1)
    prediction_x(i,:) =  round((weight_time_1(101,:).*data(i-1,:) + weight_time_2(101,:).*data(i-2,:) + weight_time_3(101,:).*data(i-3,:)));

    % Error calculation
    error_raw(i,:)= (data(i,:)-(prediction_x(i,:)));

% 
% %%%%%%%%%% by row in channel sequence %%%%%%%%%%%%%%%
% %     
% %     
% %     prediction_x(i,:) =  round(weight_time_1(101,:).*data(i-1,:));
% %     
% %     % Error calculation
% %     data_square = [0 data(i,1:8) 0 data(i,9:88) 0 data(i,89:96) 0];
% %     data_table(:,:,i) = (reshape(data_square,10,10))';
% %     error_raw(i,:) = (data(i,:)-(prediction_x(i,:)));
% %     
        error_raw_square = [0 error_raw(i,1:8) 0 error_raw(i,9:88) 0 error_raw(i,89:96) 0];
    
        error_raw_table(:,:,i) = (reshape(error_raw_square,10,10))';
    
    
    bit_change_row(i,1) = error_raw(i,1);
    flag = 0;
    for j = 2:95
    
    
        if  not (and (and( error_raw(i,j), error_raw(i,j-1) ) , error_raw(i,j+1) ))
            bit_change_row(i,j) = error_raw(i,j);
    
        else 
            bit_change_row(i,j) = error_raw(i,j) - error_raw(i,j-1);
            bit_change_row(i,j+1) = error_raw(i,j+1) - error_raw(i,j);
    %             bit_change(i,j+2) = error_raw(i,j+2) - error_raw(i,j+1);
    %             flag = 2;
        end 
    end 
    bit_change_row(i,96) = error_raw(i,96);
    
    %%%%%%%%%%%%%%%%%%%%%%apply differential in rows%%%%%%%%%%%%%%
    bit_change_row_square(:,:,i) = [0 bit_change_row(i,1:8) 0 bit_change_row(i,9:88) 0 bit_change_row(i,89:96) 0];
    %     
    bit_change_row_table(:,:,i) = (reshape(bit_change_row_square(:,:,i),10,10))';
    
    bit_change_horizon = bit_change_row_table(:,:,i); 
    for index_col = 1:10
        for index_row = 2:9
            if  not (and (and( bit_change_row_table(index_row,index_col,i), bit_change_row_table(index_row-1,index_col,i) ) , bit_change_row_table(index_row+1,index_col,i) ))
                 bit_change_horizon(index_row,index_col) = bit_change_row_table(index_row,index_col,i);
            else
                 bit_change_horizon(index_row,index_col) = bit_change_row_table(index_row,index_col,i) - bit_change_row_table(index_row-1,index_col,i);
                 bit_change_horizon(index_row+1,index_col) = bit_change_row_table(index_row+1,index_col,i) - bit_change_row_table(index_row,index_col,i);
            end 
        end 
    end 
    
    bit_change_horizon = reshape(bit_change_horizon,1,100);
    
    error(i,:) = [bit_change_horizon(2:9) bit_change_horizon(11:90) bit_change_horizon(92:99)] ;


%     error = bit_change_row;
% 
    error = error_raw;




                    error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];

                    error_table(:,:,i) = (reshape(error_square,10,10));

%     error = data;

    %calculate frequency and its probability for each quantized value
    [glow,~,intensity_val] = grp2idx(error(i,:));
    Frequency = accumarray(glow,1);
    probability = Frequency./(size(error,2));
    T = table(intensity_val ,Frequency,probability);
    
    %perform huffman coding
    dict=huffmandict(intensity_val,probability);
    encode_I = huffmanenco( error(i,:) ,dict);

    transmission_length(i,1)  = length(encode_I);

    %perform huffman decoding
    decode_I = huffmandeco(encode_I,dict);
%     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
    error_received(i,:) = decode_I;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
       [average_length, error_received] = arithmetic_coding_static_version_for_LNN(error); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         sum_length = sum_length + length;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruction at the receiver end
for i = 1:iteration2
    data_received(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
    data_received(i,data_received(i,:)>3)=3;

    if i >= 4
       prediction_x_received(i,:) =  round((weight_time_1(101,:).*data_received(i-1,:) + weight_time_2(101,:).*data_received(i-2,:) + weight_time_3(101,:).*data_received(i-3,:)));

       reconstructed_x(i,:) = prediction_x_received(i,:) + error_received(i,:);
       data_received(i,:) = reconstructed_x(i,:);

    end
end
% reconstructed_x(:,66) =0 ;
reconstructed_error = (data-reconstructed_x);
total_error = sum(sum(reconstructed_error(4:end,:),2))
mean(transmission_length)

save error.mat error error_table











% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % predict using the latest data from transmitter  based on 3 previous data
% % with updating weights on both sides
% 
% close all;
% clear all;
% 
% 
% % load("Data_BP_1_Rec_1_Subject_1.mat")
% load('reordered_binned_data.mat')
% binned_MUA = reordered_binned_data;
% mu1=0.001;
% mu2=0.0005;
% mu3=0.0001;
% 
% %% LMS
% iteration = 100;
%     weight_time_1 = zeros(iteration+1,96);
%     weight_time_2 = zeros(iteration+1,96);
%     weight_time_3 = zeros(iteration+1,96);
% 
% for i = 1:iteration
% %     data(i,:) = binned_MUA(1 + 50*(i-1) : 50*i,1:96);
%     data_training(i,:) = sum(binned_MUA(1 + 50*(i-1) : 50*i,1:96),1);
%     data_training(i,data_training(i,:)>3)=3;
%     if i >= 4
%         
%         for ichannel = 1:96
%            
%                      estimated_x(i,ichannel) = (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
%                                 + weight_time_3(i,ichannel).*data_training(i-3,ichannel));
%                 
%              
%                
%                      % Error calculation
%                      error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
%                 
%                      weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_training(i,ichannel).*data_training(i-1,ichannel);
%                      weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_training(i,ichannel).*data_training(i-2,ichannel);
%                      weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i-3,ichannel);
%      
%            
%             
%         end 
%     end
% %     error_mu1(i,:)=error;
%        
% end
% 
%             weight_time_1(3,:) = weight_time_1(101,:);
%             weight_time_2(3,:) = weight_time_2(101,:);
%             weight_time_3(3,:) = weight_time_3(101,:);
% 
%             weight_time_1_cal = roundn(weight_time_1(3,:),-1);
%             weight_time_2_cal = roundn(weight_time_2(3,:),-1);
%             weight_time_3_cal = roundn(weight_time_3(3,:),-1);
% 
% 
%            % load the initial weights for weight update
%             weight_time_1(4,:) = weight_time_1_cal(:);
%             weight_time_2(4,:) = weight_time_1_cal(:);
%             weight_time_3(4,:) = weight_time_1_cal(:);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% generate the transmission coding
% % prediction: generate the error to be sent
% iteration2=100;
% sum_length = 0;
% for i=1:iteration2
%     data(i,:) = sum( binned_MUA( (5901 + 50*(i-1)) : 5900 + 50*i,1:96) , 1);
%     data(i,data(i,:)>3)=3;
%     if i >= 4
%         for ichannel = 1:96
% 
%             
% %              prediction_x(i,ichannel) = round ( weight_time_1(101,ichannel).*data(i-1,ichannel) + weight_time_2(101,ichannel).*data(i-2,ichannel) ...
% %                                         + weight_time_3(101,ichannel).*data(i-3,ichannel) );
%      
%              prediction_x(i,ichannel) = round ( weight_time_1_cal(ichannel).*data(i-1,ichannel) + weight_time_2_cal(ichannel).*data(i-2,ichannel) ...
%                             + weight_time_3_cal(ichannel).*data(i-3,ichannel) );
% 
%             % Error calculation
%             error(i,ichannel)= (data(i,ichannel)-(prediction_x(i,ichannel)));
% 
%              weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error(i,ichannel).*data(i-1,ichannel);
%              weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error(i,ichannel).*data(i-2,ichannel);
%              weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error(i,ichannel).*data(i-3,ichannel);
% 
%      
% %                             error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];
% %         
% %                             error_table(:,:,i) = (reshape(error_square,10,10))';
%         end
% 
%         
%             weight_time_1_cal(:) = roundn(weight_time_1(i+1,:),-1);
%             weight_time_2_cal(:) = roundn(weight_time_2(i+1,:),-1);
%             weight_time_3_cal(:) = roundn(weight_time_3(i+1,:),-1);
% 
% %             error = data;
% 
%             %calculate frequency and its probability for each quantized value
%             [glow,~,intensity_val] = grp2idx(error(i,:));
%             Frequency = accumarray(glow,1);
%             probability = Frequency./(size(error,2));
%             T = table(intensity_val ,Frequency,probability);
%             
%             %perform huffman coding
%             dict=huffmandict(intensity_val,probability);
%             encode_I = huffmanenco( error(i,:) ,dict);
%         
%             transmission_length(i,1)  = length(encode_I);
%         
%             %perform huffman decoding
%             decode_I = huffmandeco(encode_I,dict);
%         %     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
%             error_received(i,:) = decode_I;
% 
% 
% %                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
% %        [avg_arith_length, error_received(i,:)] = arithmetic_coding(error(i,:)); 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %        sum_length = avg_arith_length + sum_length;
%         
%     end 
% end
% 
%                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%        [avg_arith_length, error_received] = arithmetic_coding_static_version_for_LNN(error); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %        sum_length = avg_arith_length + sum_length;
% avg_arith_length
% % average_arith = sum_length/97
% 
%             weight_time_1_cal = roundn(weight_time_1(3,:),-1);
%             weight_time_2_cal = roundn(weight_time_2(3,:),-1);
%             weight_time_3_cal = roundn(weight_time_3(3,:),-1);
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reconstruction at the receiver end
% for i = 1:iteration2
%     data_received(i,:) = sum( binned_MUA( (5901 + 50*(i-1)) : 5900 + 50*i,1:96) , 1);
%     data_received(i,data_received(i,:)>3)=3;
%     if i >= 4
%         for ichannel = 1:96
%            
%                prediction_x_received(i,ichannel) =  round( (weight_time_1_cal(ichannel).*data_received(i-1,ichannel) + weight_time_2_cal(ichannel).*data_received(i-2,ichannel) ...
%                    + weight_time_3_cal(ichannel).*data_received(i-3,ichannel)) );
%            
%                reconstructed_x(i,ichannel) = prediction_x_received(i,ichannel) + error_received(i,ichannel);
%       
%                data_received(i,ichannel) = reconstructed_x(i,ichannel);
% 
% 
% 
%              weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_received(i,ichannel).*data(i-1,ichannel);
%              weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_received(i,ichannel).*data(i-2,ichannel);
%              weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_received(i,ichannel).*data(i-3,ichannel);
% 
%         end
% 
%             weight_time_1_cal(:) = roundn(weight_time_1(i+1,:),-1);
%             weight_time_2_cal(:) = roundn(weight_time_2(i+1,:),-1);
%             weight_time_3_cal(:) = roundn(weight_time_3(i+1,:),-1);
% 
%     end 
% end
% 
% reconstructed_error = (data-reconstructed_x);
% total_error = sum(sum(reconstructed_error(4:end,:),2))
% mean(transmission_length)
% 
% save error.mat error 







% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % predict using the latest data from transmitter  based on 3 previous data
% % % and 1 neighbouring channel
% % 
% % close all;
% % clear all;
% % 
% % 
% % % load("Data_BP_1_Rec_1_Subject_1.mat")
% % load('reordered_binned_data.mat')
% % binned_MUA = reordered_binned_data;
% % mu1=0.001;
% % mu2=0.001;
% % mu3=0.001;
% % 
% % %% LMS
% % iteration = 100;
% %     weight_time_1 = zeros(iteration+1,96);
% %     weight_time_2 = zeros(iteration+1,96);
% %     weight_time_3 = zeros(iteration+1,96);
% %     weight_space = zeros(iteration+1,96);
% % 
% % for i = 1:iteration
% % %     data(i,:) = binned_MUA(1 + 50*(i-1) : 50*i,1:96);
% %     data_training(i,:) = sum(binned_MUA(1 + 50*(i-1) : 50*i,1:96),1);
% %     data_training(i,data_training(i,:)>3)=3;
% %     if i >= 4
% %         
% %         for ichannel = 1:96
% %             if (ichannel == 1) || (ichannel == 96)
% %                      estimated_x(i,ichannel) = (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
% %                                 + weight_time_3(i,ichannel).*data_training(i-3,ichannel));
% %                 
% %                      % Error calculation
% %                      error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
% %                 
% %                      weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_training(i,ichannel).*data_training(i-1,ichannel);
% %                      weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_training(i,ichannel).*data_training(i-2,ichannel);
% %                      weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i-3,ichannel);
% %             else
% %     
% %               
% %                     % Estimated x is x(n+1)
% %                     estimated_x(i,ichannel) = (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
% %                         + weight_time_3(i,ichannel).*data_training(i-3,ichannel)) + weight_space(i,ichannel).* data_training(i,ichannel-1);
% %                
% %                      % Error calculation
% %                      error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
% %                 
% %                      weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_training(i,ichannel).*data_training(i-1,ichannel);
% %                      weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_training(i,ichannel).*data_training(i-2,ichannel);
% %                      weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i-3,ichannel);
% %                      weight_space(i+1,ichannel) = weight_space(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i,ichannel+1);
% %            
% %             end
% %         end 
% %     end
% % %     error_mu1(i,:)=error;
% %        
% % end
% % 
% % weight_time_1 = roundn(weight_time_1,-1);
% % weight_time_2 = roundn(weight_time_2,-1);
% % weight_time_3 = roundn(weight_time_3,-1);
% % weight_space = roundn(weight_space,-1);
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %% generate the transmission coding
% % % prediction: generate the error to be sent
% % iteration2=1000;
% % for i=1:iteration2
% %     
% %         data(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
% %         data(i,data(i,:)>3)=3;
% %     
% %     if i >= 4
% %         for ichannel = 1:96
% %             if (ichannel == 1) || (ichannel == 96)
% %              prediction_x(i,ichannel) = round ( weight_time_1(101,ichannel).*data(i-1,ichannel) + weight_time_2(101,ichannel).*data(i-2,ichannel) ...
% %                                         + weight_time_3(101,ichannel).*data(i-3,ichannel) );
% %             else
% %     
% %            
% %             % Estimated x is x(n+1)
% %             prediction_x(i,ichannel) =  round( (weight_time_1(101,ichannel).*data(i-1,ichannel) + weight_time_2(101,ichannel).*data(i-2,ichannel) ...
% %                 + weight_time_3(101,ichannel).*data(i-3,ichannel) + weight_space(101,ichannel).* data(i,ichannel-1)) );
% %             end 
% % 
% %         
% %             % Error calculation
% %             error(i,ichannel)= (data(i,ichannel)-(prediction_x(i,ichannel)));
% %      
% % %                             error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];
% % %         
% % %                             error_table(:,:,i) = (reshape(error_square,10,10))';
% %         end
% %             %calculate frequency and its probability for each quantized value
% %             [glow,~,intensity_val] = grp2idx(error(i,:));
% %             Frequency = accumarray(glow,1);
% %             probability = Frequency./(size(error,2));
% %             T = table(intensity_val ,Frequency,probability);
% %             
% %             %perform huffman coding
% %             dict=huffmandict(intensity_val,probability);
% %             encode_I = huffmanenco( error(i,:) ,dict);
% %         
% %             transmission_length(i,1)  = length(encode_I);
% %         
% %             %perform huffman decoding
% %             decode_I = huffmandeco(encode_I,dict);
% %         %     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
% %             error_received(i,:) = decode_I;
% %         
% %     end 
% % end
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % Reconstruction at the receiver end
% % for i = 1:iteration2
% %     if (i<=3)
% %         data_received(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
% %         data_received(i,data_received(i,:)>3)=3;
% %     end 
% %     if i >= 4
% %         for ichannel = 1:96
% %             if (ichannel == 1) || (ichannel == 96)
% %                prediction_x_received(i,ichannel) =  round( (weight_time_1(101,ichannel).*data_received(i-1,ichannel) + weight_time_2(101,ichannel).*data_received(i-2,ichannel) ...
% %                    + weight_time_3(101,ichannel).*data_received(i-3,ichannel)) );
% %             else 
% %                prediction_x_received(i,ichannel) =  round( (weight_time_1(101,ichannel).*data_received(i-1,ichannel) + weight_time_2(101,ichannel).*data_received(i-2,ichannel) ...
% %                    + weight_time_3(101,ichannel).*data_received(i-3,ichannel) + weight_space(101,ichannel).* data_received(i,ichannel-1) ) );
% %             end
% % 
% % 
% %                reconstructed_x(i,ichannel) = prediction_x_received(i,ichannel) + error_received(i,ichannel);
% %       
% %                data_received(i,ichannel) = reconstructed_x(i,ichannel);
% %         end
% %     end 
% % end
% % 
% % reconstructed_error = (data-reconstructed_x);
% % total_error = sum(sum(reconstructed_error(4:end,:),2))
% % sum(transmission_length)/(i-3)
% % 
% % save error.mat error 
















% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % predict using the latest data from transmitter  based on 3 previous data
% % and 1 neighbouring channel
% 
% close all;
% clear all;
% 
% 
% % load("Data_BP_1_Rec_1_Subject_1.mat")
% load('reordered_binned_data.mat')
% binned_MUA = reordered_binned_data;
% mu1=0.001;
% mu2=0.001;
% mu3=0.001;
% 
% %% LMS
% iteration = 100;
%     weight_time_1 = zeros(iteration+1,96);
%     weight_time_2 = zeros(iteration+1,96);
%     weight_time_3 = zeros(iteration+1,96);
%     weight_space = zeros(iteration+1,96);
% 
% for i = 1:iteration
% %     data(i,:) = binned_MUA(1 + 50*(i-1) : 50*i,1:96);
%     data_training(i,:) = sum(binned_MUA(1 + 50*(i-1) : 50*i,1:96),1);
%     data_training(i,data_training(i,:)>3)=3;
%     if i >= 4
%         
%         for ichannel = 1:96
%             if (ichannel == 1) || (ichannel == 96)
%                      estimated_x(i,ichannel) = (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
%                                 + weight_time_3(i,ichannel).*data_training(i-3,ichannel));
%                 
%                      % Error calculation
%                      error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
%                 
%                      weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_training(i,ichannel).*data_training(i-1,ichannel);
%                      weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_training(i,ichannel).*data_training(i-2,ichannel);
%                      weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i-3,ichannel);
%             else
%     
%               
%                     % Estimated x is x(n+1)
%                     estimated_x(i,ichannel) = (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
%                         + weight_time_3(i,ichannel).*data_training(i-3,ichannel)) + weight_space(i,ichannel).* data_training(i,ichannel-1);
%                
%                      % Error calculation
%                      error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
%                 
%                      weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_training(i,ichannel).*data_training(i-1,ichannel);
%                      weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_training(i,ichannel).*data_training(i-2,ichannel);
%                      weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i-3,ichannel);
%                      weight_space(i+1,ichannel) = weight_space(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i,ichannel+1);
%            
%             end
%         end 
%     end
% %     error_mu1(i,:)=error;
%        
% end
% 
% weight_time_1 = roundn(weight_time_1,-1);
% weight_time_2 = roundn(weight_time_2,-1);
% weight_time_3 = roundn(weight_time_3,-1);
% weight_space = roundn(weight_space,-1);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% generate the transmission coding
% % prediction: generate the error to be sent
% iteration2=100;
% for i=1:iteration2
%     data(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
%     data(i,data(i,:)>3)=3;
%     if i >= 4
%         for ichannel = 1:96
%             if (ichannel == 1) || (ichannel == 96)
%              prediction_x(i,ichannel) = round ( weight_time_1(101,ichannel).*data(i-1,ichannel) + weight_time_2(101,ichannel).*data(i-2,ichannel) ...
%                                         + weight_time_3(101,ichannel).*data(i-3,ichannel) );
%             else
%     
%            
%             % Estimated x is x(n+1)
%             prediction_x(i,ichannel) =  round( (weight_time_1(101,ichannel).*data(i-1,ichannel) + weight_time_2(101,ichannel).*data(i-2,ichannel) ...
%                 + weight_time_3(101,ichannel).*data(i-3,ichannel) + weight_space(101,ichannel).* data(i,ichannel-1)) );
%             end 
% 
%         
%             % Error calculation
%             error(i,ichannel)= (data(i,ichannel)-(prediction_x(i,ichannel)));
%      
%         end
%             % calculate frequency and its probability for each quantized value
%             [glow,~,intensity_val] = grp2idx(error(i,:));
%             Frequency = accumarray(glow,1);
%             probability = Frequency./(size(error,2));
%             T = table(intensity_val ,Frequency,probability);
%             
%             % perform huffman coding
%             dict=huffmandict(intensity_val,probability);
%             encode_I = huffmanenco( error(i,:) ,dict);
%         
%             transmission_length(i,1)  = length(encode_I);
%         
%             %perform huffman decoding
%             decode_I = huffmandeco(encode_I,dict);
%         %     kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image
%             error_received(i,:) = decode_I;
%         
%     end 
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reconstruction at the receiver end
% for i = 1:iteration2
%     data_received(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
%     data_received(i,data_received(i,:)>3)=3;
%     if i >= 4
%         for ichannel = 1:96
%             if (ichannel == 1) || (ichannel == 96)
%                prediction_x_received(i,ichannel) =  round( (weight_time_1(101,ichannel).*data_received(i-1,ichannel) + weight_time_2(101,ichannel).*data_received(i-2,ichannel) ...
%                    + weight_time_3(101,ichannel).*data_received(i-3,ichannel)) );
%             else 
%                prediction_x_received(i,ichannel) =  round( (weight_time_1(101,ichannel).*data_received(i-1,ichannel) + weight_time_2(101,ichannel).*data_received(i-2,ichannel) ...
%                    + weight_time_3(101,ichannel).*data_received(i-3,ichannel) + weight_space(101,ichannel).* data_received(i,ichannel-1) ) );
%             end 
%                reconstructed_x(i,ichannel) = prediction_x_received(i,ichannel) + error_received(i,ichannel);
%       
%                data_received(i,ichannel) = reconstructed_x(i,ichannel);
%         end
%     end 
% end
% 
% reconstructed_error = (data-reconstructed_x);
% total_error = sum(sum(reconstructed_error(4:end,:),2))
% mean(transmission_length)
% error = error(4:100,:);
% 
% save error.mat error 

