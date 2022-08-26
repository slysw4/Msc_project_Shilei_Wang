clc;
clear all;
close all


load flint_CS_result.mat
load sabes_LNN_result.mat
load flint_LNN_result.mat

for i = 1:3
    figure(1)
    subplot(3,1,i)
    x1 = 5:5:20;
    x2 = 5:5:100;
    y1(i,:) = flint_CS(i,:).*(1000./x1)./96;
    y2(i,:) = round(flint_LNN(i,:).*(1000./x2)./96);
    y3(i,:) = round(sabes_LNN(i,:).*(1000./x2)./96);
    
%     plot(x1,y1,LineWidth=2)
%     hold on
%     plot(x2,y2,LineWidth=2)
%     plot(x2,y3,LineWidth=2)
%     grid minor
%     xlabel('Binning period (ms)');
%     ylabel('Bps/channel')
%     legend('Flint CS', 'Flint LNN','Sabes LNN');
%     set(gca,'YLim',[0 180]);
%     title(sprintf('The communication bit rates with dynamic range = %d',i+2))
end 

% % load("Data_BP_1_Rec_1_Subject_1.mat")
% load('reordered_binned_data.mat')
% binned_MUA = reordered_binned_data;
% bin_period = 10;
% binned_MUA = binned_MUA(1:10000,:);
% iteration = size(binned_MUA,1)/bin_period;
% 
% 
% 
% for i = 1:iteration
% 
%     data_training(i,:) = sum(binned_MUA(1 + bin_period*(i-1) : bin_period*i,1:96),1);
% 
% 
% end 
% non_zero = find(data_training(:));