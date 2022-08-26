
close all;

% load("Data_BP_1_Rec_1_Subject_1.mat")
% 
% % time of the input samples
% num_histogram = floor(length(binned_MUA)/960);
% num_channel = size(binned_MUA,2);
% binned_per_second = zeros(num_histogram,num_channel);
% 
% for i = 1:num_histogram
%     binned_per_second(i,:) = sum(binned_MUA( (i-1)*960 + 1 : i*960,:),1);
% end 

load("Data_BP_1_Rec_1_Subject_1.mat")
% load('reordered_binned_data.mat')
% binned_MUA = reordered_binned_data;
% img = imread("Cameraman.tif");

sum_bp_data_96ms = zeros(1,96);


arithdeco
    img = binned_MUA(1:50,1:96);
    data = sum(img,1);

    data(data(:)>3)=3;
%     sum_bp_data_96ms = (sum_bp_data_96ms + sum(img,1))./100;
% for i = 101:200
%     img = binned_MUA((1+50*(i-1)):50*i,1:96);
%     sum_bp_data_96ms = (sum_bp_data_96ms + sum(img,1))./100;
% end 
% initialization

data = [0 data(1:8) 0 data(9:88) 0 data(89:96) 0];

b = (data~=0);
num_non_zero = sum(b(:))

% quantization
data = (reshape(data,10,10))'

for i = 1:10
    % odd row
    if mod(i,2) == 0
        data(i,:) = fliplr(data(i,:));
    end
end 

% largest 100 numbers
N_largest = 78;

% test_data = binned_per_second(1:96,1:96);

num_row_block = size(data,1);
num_col_block = size(data,2);

% % divide the image into 8x8 pixels
% N = ones(1,num_col_block/8)*8;
% M = ones(1,num_row_block/8)*8;
% blocks = mat2cell(test_data, M, N );
n = 10;

% DCT coefficients
for i = 1:10
    if i == 1
        constant = sqrt(1/n);
    else
        constant = sqrt(2/n);
    end
        for j = 1:10
            u(i,j) = constant * cos( pi/n*(i-1)*(j-0.5) );
        end
end

Transformed = u*double(data)*u';

integer_Transformed = round(Transformed);
%% Keep the N largest values
values = reshape(Transformed, 1, num_row_block*num_col_block);
[sorted_values, index] = sort(abs(values), 'descend');

N_values = zeros(1,  num_row_block*num_col_block);

for i = 1: N_largest
    N_values(index(i)) = values(index(i));
end 
% kept_values = zeros(10,10);
% kept_values(1:9,1:9) = Transformed_image_new(1:9,1:9);
ordered_transmit_data = N_values(find(N_values));

kept_values = round((ordered_transmit_data));
% kept_values = round(reshape(N_values,num_row_block,num_col_block));
% kept_values = round(sorted_values(1:N_largest));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calculate frequency and its probability for each quantized value
[glow,~,intensity_val] = grp2idx(data(:));
Frequency = accumarray(glow,1);
probability = Frequency./(100);
T = table(intensity_val ,Frequency,probability);

%perform huffman coding
dict=huffmandict(intensity_val,probability);
encode_I = huffmanenco(data(:),dict);

%perform huffman decoding
decode_I = huffmandeco(encode_I,dict);
kept_values_decode = reshape(decode_I,[10 10]); %reshaping the image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    invert_blocks = u' * double(kept_values_decode) * u;

    reconstructed_data = round(invert_blocks);

        % Calculate PSNR
    error_num = sum(sum(xor(round(reconstructed_data),data)));

    MSE = (reconstructed_data - double(data)).^2;
    sum_MSE = sum(sum(MSE)) / (100);
    display(sum_MSE)

% figure(1)
% imagesc(data);
% colormap gray
% 
% figure(3)
% imagesc(reconstructed_data);
% colormap gray