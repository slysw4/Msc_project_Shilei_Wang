%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predict using the latest data from transmitter  3 order predictor
% adaptive version

close all;
clear all;
clc

% load("Data_BP_1_Rec_1_Subject_1.mat")
load('reordered_binned_data.mat')
binned_MUA = reordered_binned_data;
mu1(4)=0.001;
mu2(4)=0.001;
mu3(4)=0.001;
phi_1(4) = 0.001;
phi_2(4) = 0.001;
phi_3(4) = 0.001;
rho = 0.000006;

%% LMS 
for k = 3:3
dynamic_range = 2 + k;
for j = 1:20
    bin_period = 5+(j-1)*5;
    
    iteration = floor(5000/bin_period);;
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

    end
       
end
weight_time_1 = roundn(weight_time_1,-1);
weight_time_2 = roundn(weight_time_2,-1);
weight_time_3 = roundn(weight_time_3,-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generate the transmission coding
% prediction: generate the error to be sent
iteration2=100;
iteration2 = floor(5000/bin_period);
sum_length = 0;
for i=1:iteration2
    data(i,:) = sum( binned_MUA( (5001 + bin_period*(i-1)) : 5000 + bin_period*i,1:96) , 1);
    data(i,data(i,:)>dynamic_range)=dynamic_range;

    if i >= 4
    % Estimated x is x(n+1)
    prediction_x(i,:) =  round((weight_time_1(101,:).*data(i-1,:) + weight_time_2(101,:).*data(i-2,:) + weight_time_3(101,:).*data(i-3,:)));

    % Error calculation
    error_raw(i,:)= (data(i,:)-(prediction_x(i,:)));
    
    error = error_raw;

    error_square = [0 error(i,1:8) 0 error(i,9:88) 0 error(i,89:96) 0];

    error_table(:,:,i) = (reshape(error_square,10,10));

% Arithmetic_coding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
       [length, error_received(i,:)] = arithmetic_coding_static_version_for_LNN(error(i,:)); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sum_length = sum_length + length;
    end
end


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
total_error = sum(sum(reconstructed_error(4:end,:),2));

error = error(4:100,:);
average_length(k,j) = sum_length / iteration2; 
end 
end 
save error.mat error error_table
