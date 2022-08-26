% predict using the latest data from transmitter  based on 3 previous data
% and 1 neighbouring channel
clc;
close all;
clear all;


% load("Data_BP_1_Rec_1_Subject_1.mat")
load('reordered_binned_data.mat')
binned_MUA = reordered_binned_data;
mu1=0.001;
mu2=0.001;
mu3=0.001;

%% LMS
iteration = 100;
    weight_time_1 = zeros(iteration+1,96);
    weight_time_2 = zeros(iteration+1,96);
    weight_time_3 = zeros(iteration+1,96);
    weight_space = zeros(iteration+1,96);

for i = 1:iteration

    data_training(i,:) = sum(binned_MUA(1 + 50*(i-1) : 50*i,1:96),1);
    data_training(i,data_training(i,:)>3)=3;
    if i >= 4
        
        for ichannel = 1:96
            if (ichannel == 1) || (ichannel == 96)
                     estimated_x(i,ichannel) = (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
                                + weight_time_3(i,ichannel).*data_training(i-3,ichannel));
                
                     % Error calculation
                     error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
                
                     weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_training(i,ichannel).*data_training(i-1,ichannel);
                     weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_training(i,ichannel).*data_training(i-2,ichannel);
                     weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i-3,ichannel);
            else
    
              
                    % Estimated x is x(n+1)
                    estimated_x(i,ichannel) = (weight_time_1(i,ichannel).*data_training(i-1,ichannel) + weight_time_2(i,ichannel).*data_training(i-2,ichannel) ...
                        + weight_time_3(i,ichannel).*data_training(i-3,ichannel)) + weight_space(i,ichannel).* data_training(i,ichannel-1);
               
                     % Error calculation
                     error_training(i,ichannel) = data_training(i,ichannel)-(estimated_x(i,ichannel)); 
                
                     weight_time_1(i+1,ichannel) = weight_time_1(i,ichannel) + mu1*error_training(i,ichannel).*data_training(i-1,ichannel);
                     weight_time_2(i+1,ichannel) = weight_time_2(i,ichannel) + mu2*error_training(i,ichannel).*data_training(i-2,ichannel);
                     weight_time_3(i+1,ichannel) = weight_time_3(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i-3,ichannel);
                     weight_space(i+1,ichannel) = weight_space(i,ichannel) + mu3*error_training(i,ichannel).*data_training(i,ichannel+1);
           
            end
        end 
    end
%     error_mu1(i,:)=error;
       
end

weight_time_1 = roundn(weight_time_1,-1);
weight_time_2 = roundn(weight_time_2,-1);
weight_time_3 = roundn(weight_time_3,-1);
weight_space = roundn(weight_space,-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generate the transmission coding
% prediction: generate the error to be sent
iteration2=100;
sum_length = 0;
for i=1:iteration2
    data(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
    data(i,data(i,:)>3)=3;
    if i >= 4
        for ichannel = 1:96
            if (ichannel == 1) || (ichannel == 96)
             prediction_x(i,ichannel) = round ( weight_time_1(101,ichannel).*data(i-1,ichannel) + weight_time_2(101,ichannel).*data(i-2,ichannel) ...
                                        + weight_time_3(101,ichannel).*data(i-3,ichannel) );
            else
    
           
            % Estimated x is x(n+1)
            prediction_x(i,ichannel) =  round( (weight_time_1(101,ichannel).*data(i-1,ichannel) + weight_time_2(101,ichannel).*data(i-2,ichannel) ...
                + weight_time_3(101,ichannel).*data(i-3,ichannel) + weight_space(101,ichannel).* data(i,ichannel-1)) );
            end 

        
            % Error calculation
            error(i,ichannel)= (data(i,ichannel)-(prediction_x(i,ichannel)));
     
        end


% Arithmetic_coding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
       [length, error_received(i,:)] = arithmetic_coding(error(i,:)); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sum_length = sum_length + length;
        

        
    end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruction at the receiver end
for i = 1:iteration2
    data_received(i,:) = sum( binned_MUA( (5001 + 50*(i-1)) : 5000 + 50*i,1:96) , 1);
    data_received(i,data_received(i,:)>3)=3;
    if i >= 4
        for ichannel = 1:96
            if (ichannel == 1) || (ichannel == 96)
               prediction_x_received(i,ichannel) =  round( (weight_time_1(101,ichannel).*data_received(i-1,ichannel) + weight_time_2(101,ichannel).*data_received(i-2,ichannel) ...
                   + weight_time_3(101,ichannel).*data_received(i-3,ichannel)) );
            else 
               prediction_x_received(i,ichannel) =  round( (weight_time_1(101,ichannel).*data_received(i-1,ichannel) + weight_time_2(101,ichannel).*data_received(i-2,ichannel) ...
                   + weight_time_3(101,ichannel).*data_received(i-3,ichannel) + weight_space(101,ichannel).* data_received(i,ichannel-1) ) );
            end 
               reconstructed_x(i,ichannel) = prediction_x_received(i,ichannel) + error_received(i,ichannel);
      
               data_received(i,ichannel) = reconstructed_x(i,ichannel);
        end
    end 
end

reconstructed_error = (data-reconstructed_x);
total_error = sum(sum(reconstructed_error(4:end,:),2))

average_length = sum_length / iteration2 
error = error(4:100,:);

save error.mat error 
