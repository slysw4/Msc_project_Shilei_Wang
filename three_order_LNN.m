% predict using the latest data from transmitter  based on 3 previous data
% and 1 neighbouring channel
clc;
close all;
clear all;


load("Data_BP_1_Rec_1_Subject_1.mat")
% load('reordered_binned_data.mat')
% binned_MUA = reordered_binned_data;
mu1=0.001;
mu2=0.0005;
mu3=0.0001;

%% LMS
 k = 1;
dynamic_range = 1 + k;
for j = 20:-1:1


    bin_period = 5+(j-1)*5;
    
iteration = 100;
    weight_time_1 = zeros(iteration+1,96);
    weight_time_2 = zeros(iteration+1,96);
    weight_time_3 = zeros(iteration+1,96);
   
   
iteration1 = floor(5000/bin_period);
for i_training = 1:iteration1

    data_training(i_training,:) = sum(binned_MUA(1 + bin_period*(i_training-1) : bin_period*i_training,1:96),1);
    data_training(i_training,data_training(i_training,:)>dynamic_range)=dynamic_range;
    if i_training >= 4
        
        for ichannel = 1:96
            
                     estimated_x(i_training,ichannel) = (weight_time_1(i_training,ichannel).*data_training(i_training-1,ichannel) + weight_time_2(i_training,ichannel).*data_training(i_training-2,ichannel) ...
                                + weight_time_3(i_training,ichannel).*data_training(i_training-3,ichannel));
                
                     % Error calculation
                     error_training(i_training,ichannel) = data_training(i_training,ichannel)-(estimated_x(i_training,ichannel)); 
                
                     weight_time_1(i_training+1,ichannel) = weight_time_1(i_training,ichannel) + mu1*error_training(i_training,ichannel).*data_training(i_training-1,ichannel);
                     weight_time_2(i_training+1,ichannel) = weight_time_2(i_training,ichannel) + mu2*error_training(i_training,ichannel).*data_training(i_training-2,ichannel);
                     weight_time_3(i_training+1,ichannel) = weight_time_3(i_training,ichannel) + mu3*error_training(i_training,ichannel).*data_training(i_training-3,ichannel);

            
        end 
    end
%     error_mu1(i,:)=error;
       
end

weight_time_1 = roundn(weight_time_1,-1);
weight_time_2 = roundn(weight_time_2,-1);
weight_time_3 = roundn(weight_time_3,-1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generate the transmission coding
% prediction: generate the error to be sent
% iteration2=100;
iteration2 = floor(5000/bin_period);

sum_length = 0;
for i_generate=1:iteration2
    data(i_generate,:) = sum( binned_MUA( (5001 + bin_period*(i_generate-1)) : 5000 + bin_period*i_generate,1:96) , 1);

    data(i_generate,data(i_generate,:)>dynamic_range)=dynamic_range;
    if i_generate >= 4
        for ichannel = 1:96
            
             prediction_x(i_generate,ichannel) = round ( weight_time_1(i_training+1,ichannel).*data(i_generate-1,ichannel) + weight_time_2(i_training+1,ichannel).*data(i_generate-2,ichannel) ...
                                        + weight_time_3(i_training+1,ichannel).*data(i_generate-3,ichannel) );
  

        
            % Error calculation
            error(i_generate,ichannel)= (data(i_generate,ichannel)-(prediction_x(i_generate,ichannel)));
     
        end


% % Arithmetic_coding
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%        [length, error_received] = arithmetic_coding_static_version_for_CS(error); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         sum_length = sum_length + length;
        

        
    end 
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
       [average_length(k,j), error_received] = arithmetic_coding_static_version_for_LNN(error); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         sum_length = sum_length + length;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruction at the receiver end
for i = 1:iteration2
    data_received(i,:) = sum( binned_MUA( (5001 + bin_period*(i-1)) : 5000 + bin_period*i,1:96) , 1);
    data_received(i,data_received(i,:)>dynamic_range)=dynamic_range;
    if i >= 4
        for ichannel = 1:96
           
               prediction_x_received(i,ichannel) =  round( (weight_time_1(i_training+1,ichannel).*data_received(i-1,ichannel) + weight_time_2(i_training+1,ichannel).*data_received(i-2,ichannel) ...
                   + weight_time_3(i_training+1,ichannel).*data_received(i-3,ichannel)) );
           
               reconstructed_x(i,ichannel) = prediction_x_received(i,ichannel) + error_received(i,ichannel);
      
               data_received(i,ichannel) = reconstructed_x(i,ichannel);
        end
    end 
end

reconstructed_error = (data-reconstructed_x);
total_error(k,j) = sum(sum(reconstructed_error(4:end,:),2));


% error = error(4:iteration2,:);
end 
 
save error.mat error 
