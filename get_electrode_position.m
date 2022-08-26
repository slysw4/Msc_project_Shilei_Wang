clear all;
close all;
clc;

load('Electrode_position.mat')
load('indy_20160624_03_processed.mat')
% load('raw_spike_temp.mat')

load('binned_data.mat')


for i = 1:length(Electrode_position)
    Electrode_position(i,4) = i;
end 
x = Electrode_position(:,1);
y = (Electrode_position(:,2));

[B_x,I_x] = sort(x);
[B_y,I_y] = sort(y);
position = Electrode_position(I_x,:);

[B_x,I_y] = sort(position(:,2));
position = position(I_y,:);
index = position(:,4)';
channel_map = [0 index(1:8) 0 index(9:88) 0 index(89:96) 0];
channel_map = flipud((reshape(channel_map,10,10))');
for i = 2:2:10
    channel_map(i,:) =  fliplr(channel_map(i,:));
end 
channel_index = reshape(channel_map',[1,100]);

channel_index(find(channel_index==0))=[];


reordered_binned_data = binned_data(:,channel_index);

sum_binned_data = sum(binned_data);
sum_reordered_binned_data = sum(reordered_binned_data);

scatter(x, y);
for k=1:96
text(x(k),y(k),{k});
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get the binned data of 96 channels, BP is 1ms
%  t = temp(:,1);
%  min_t = min(t);
%  max_t = max(t);
%  BP=0.001;
%   time_vector = min_t-BP/2 : BP : max_t+BP/2;
%  channel_ID_vector =  0.5:1:96.5;
% 
%  x = histogram2(temp(:,1),temp(:,2),time_vector, channel_ID_vector); 
%  binned_data = x.Values;
% 
%  for i = 95:-1:1
%   binned_data(:,i+1) = binned_data(:,i+1)-binned_data(:,i);
%  end 
% 
%  sum_spikes = binned_data(:,i+1);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% form the matrix first col is timestamp of spike, second col is channel
% id
% spikes_time = [];
% col = [];
% output = []
% 
%     for i = 1:96
%         for j = 1:5
%              time = cell2mat(spikes(i,j));
%              col = [col;time];
%              temp = [col, ones(length(col),1)*i];
%         end 
%         output = [output;temp];
%     end




% spikes_time(:,1) = temp(:);






