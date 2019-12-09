function [ block, DFT_block, result_block, abs_block, num ] = get_block_and_DFT( resized_img, zeroed_img, m )
% block, DFT_block, result_block, abs_block, num 分别为 
% 原图各分块，为DFT补零各分块，DFT后各分块，各分块幅值，分块数

% 计算分块数
if mod(m, 2) == 0
    num = 1 +2*(m-8)/14;
else
    num = 2 + 2*(m-15)/14;
end

block = cell(num, num);
DFT_block = cell(num, num);
result_block = cell(num, num);
abs_block = cell(num, num);

for i=1:num
    for j=1:num
        block{i, j} = resized_img(1+(i-1)*7:8+(i-1)*7, 1+(j-1)*7:8+(j-1)*7);
        DFT_block{i, j} = zeroed_img(1+(i-1)*7:32+(i-1)*7, 1+(j-1)*7:32+(j-1)*7);
        result_block{i, j} = fftshift(fft2(DFT_block{i, j}));
        abs_block{i, j} = abs(result_block{i, j});
    end
end

end

