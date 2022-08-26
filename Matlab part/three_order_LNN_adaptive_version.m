%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predict using the latest data from transmitter  3 order predictor
% adaptive version

close all;
clear all;
clc

% load("Data_BP_1_Rec_1_Subject_1.mat")
load('reordered_binned_data.mat')
binned_MUA = reordered_binned_data;
mu1=0.001;
mu2=0.0005;
mu3=0.0001;

bin_period = 50;
dynamic_range = 5;
%% LMS
    iteration = 100;
    weight_time_1 = zeros(iteration+1,96);
    weight_time_2 = zeros(iteration+1,96);
    weight_time_3 = zeros(iteration+1,96);
for i=1:iteration

    data_training(i,:) = sum(binned_MUA(1 + bin_period*(i-1) : bin_period*i,1:96),1);
    data_training(i,data_training(i,:)>dynamic_range)=dynamic_range;

    N=size(data_training,2); 

    if i >=4
        for ichannel = 1:96
        
            estimated_x(i,ichannel) =  (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
                + weight_time_3(i,ichannel).*data_training(i-3,ichannel));
            
            % Error calculation
            error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
    
            % LMS update rule
            weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_training(i,ichannel).*data_training(i-1,ichannel);
            weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_training(i,ichannel).*data_training(i-2,ichannel);
            weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i-3,ichannel);
    

        end 

    end
       
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generate the transmission coding
% prediction: generate the error to be sent
iteration2=100;

sum_length = 0;
for i=1:iteration2
    data(i,:) = sum( binned_MUA( (5001 + bin_period*(i-1)) : 5000 + bin_period*i,1:96) , 1);
    data(i,data(i,:)>3)=3;

    if i >= 4
    % Estimated x is x(n+1)
    prediction_x(i,:) =  round((weight_time_1(101,:).*data(i-1,:) + weight_time_2(101,:).*data(i-2,:) + weight_time_3(101,:).*data(i-3,:)));

    % Error calculation
    error_raw(i,:)= (data(i,:)-(prediction_x(i,:)));
    
    error = error_raw;

    error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];

    error_table(:,:,i) = (reshape(error_square,10,10));

% % Arithmetic_coding
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%        [length, error_received(i,:)] = arithmetic_coding_static_version_for_LNN(error(i,:)); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         sum_length = sum_length + length;
    end
end

% Arithmetic_coding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
       [length, error_received] = arithmetic_coding_static_version_for_LNN(error); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sum_length = sum_length + length;


% Reconstruction at the receiver end
for i = 1:iteration2
    if i <4
    data_received(i,:) = sum( binned_MUA( (5001 + bin_period*(i-1)) : 5000 + bin_period*i,1:96) , 1);
    data_received(i,data_received(i,:)>dynamic_range)=dynamic_range;
    end 

    if i >= 4
       prediction_x_received(i,:) =  round((weight_time_1(101,:).*data_received(i-1,:) + weight_time_2(101,:).*data_received(i-2,:) + weight_time_3(101,:).*data_received(i-3,:)));

       reconstructed_x(i,:) = prediction_x_received(i,:) + error_received(i,:);
       data_received(i,:) = reconstructed_x(i,:);

    end
end

reconstructed_error = (data-reconstructed_x);
total_error = sum(sum(reconstructed_error(4:end,:),2))

error = error(4:100,:);
average_length = sum(length) / size(error,1) 

save error.mat error error_table
