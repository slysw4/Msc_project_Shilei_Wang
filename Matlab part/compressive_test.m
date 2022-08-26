clc;
clear; 
close all;

% Choose sparse matrix       2: Identity matrix  1: DCT transform    0: FFT transform  
choice_transform = 2;    

% Choose observation matrix. 1: Partial Hadamard matrix 0: Modification of gaussian random matrix
choice_Phi = 2;         

load error.mat

% save Phi_new.mat Phi

load Phi_new_12.mat


% Sabes dataset
load Data_BP_1_Rec_1_Subject_1.mat

% averaged_error = 2;
% while (averaged_error>1.5)
%     clear; 
% choice_Phi = 2;  
% choice_transform = 2; 
% Flint dataset
% load('reordered_binned_data.mat')
% binned_MUA = reordered_binned_data;

% Reduce the sampling rate 
n = 96;
% choose the a% of the row signal
% This value can be tuned
a = 0.5;            
m = double(int32(a*n));
sum_length = 0;

switch choice_Phi
    case 1
        Phi = PartHadamardMtx(m,n);      

    case 0

        % Generate original gaussian random matrix and keep one decimal place 
        Phi = roundn(sqrt(1/m) * randn(m,n),-1);   

        % Keep the values with abs value equal to 0.1 to reduce the
        % calculation complexity
        Phi(Phi>0.1) = 0;
        Phi(Phi<-0.1) = 0;
        
        % set 80 out of 96 coefficients of observation matrix to 0 randomly
        % This value can be tuned
        Kept_coefficients = 80;
        for j = 1:a*n
            row_index = randperm(96,Kept_coefficients);
            for k = 1:length(row_index)
                Phi(j,row_index(k)) = 0;
            end 
        end 
        % Convert decimals to integers
        Phi = Phi * 10;

    case 2
%         Phi = zeros(48,96);
%         for j = 1:a*n
%              pos_index = randperm(96,8);
%              neg_index = randperm(96,4);
%             for k = 1:length(pos_index)
%                 Phi(j,pos_index(k)) = 1;
% %                 Phi(j,neg_index(k)) = -1;
%             end 
%         end 


end

for k = 1:1

dynamic_range = 2;

for j = 4:-1:1

    bin_period = 5+(j-1)*5;
iteration1 = floor(5000/bin_period);


% for j = 1:1
% 
%     bin_period = 10;
iteration1 = floor(4000/bin_period);
% iteration1 = 1000;
    for i = 1:iteration1
        data(i,:) = sum( binned_MUA( (5001 + bin_period*(i-1)) : 5000 + bin_period*i,1:96) , 1);
        data(i,data(i,:)>dynamic_range)=dynamic_range;
        raw_signal(i,:) = data(i,:);
    
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %Generate observation matrix and sparse matrix%
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        % Use observation matrix to calculate observation values
        observation_values = Phi * raw_signal(i,:)';
        
        compressed_data(i,:) = (observation_values)' ;                
    
        switch choice_transform
            % Fourier transform, sparse orthogonal basis in frequency domain
            case 0
                Psi = inv(fft(eye(n,n)));    
              
            % Orthogonal basis for discrete cosine transform
            case 1
                Psi = dct(eye(n,n)); 
    
            % Choose identity matrix as basis due to the sparsity of raw signal
            case 2
                Psi = eye(n,n);
        end
        % Recovery matrix A = Phi * Psi
        A = Phi * Psi;     
    
    end

    % Arithmetic_coding
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
        [average_length(k,j), decoded_result] = arithmetic_coding_static_version_for_CS(compressed_data); 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
        %% Reconstruction of signal
     for i = 1:iteration1  
            % find the minimum L1 norm
            s2 = A'*(decoded_result(i,:))';
            s1 = l1eq_pd(s2, A, [], (decoded_result(i,:))', 1e-3);
            reconstructed_signal = round(real(s1));
    
    
        
        reconstructed_signal(reconstructed_signal(:)<0)=0;
       
%         raw_signal(i,:) = raw_signal(i,:)';
        each_ite_error(i) = sum(abs((raw_signal(i,:))'-reconstructed_signal),1);
    
    end 
    
        averaged_error = sum(each_ite_error)/i
        
    
    % plot(raw_signal)
    % hold on; 
    % plot(reconstructed_signal)
    % ylabel('Amplitude'); xlabel('Channel ID');
    % legend('Original','Recovery')
         
    
    % save compressive_result.mat compressed_data 
    % save Phi_new.mat Phi
  

end 
end 
%    [average_length, decoded_result] = arithmetic_coding_static_version_for_CS(compressed_data); 
%     average_length;

function [ Phi ] = PartHadamardMtx( M,N )  
% PartHadamardMtx Summary of this function goes here  
%   Generate part Hadamard matrix   
%   M -- RowNumber  
%   N -- ColumnNumber  
%   Phi -- The part Hadamard matrix  

%% parameter initialization  
%Because the MATLAB function hadamard handles only the cases where n, n/12,  
%or n/20 is a power of 2  

    N = 96;
%% Generate part Hadamard matrix     
    Phi = [];  
    Phi_t = hadamard(N);  
    RowIndex = randperm(N);  
    Phi_t_r = Phi_t(RowIndex(1:M),:);  
    ColIndex = randperm(N);  
    Phi = Phi_t_r(:,ColIndex(1:N));  
end  


