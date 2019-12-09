function [DFT_img, m1, n1, padded_img ] = get_block_and_DFT1( ori_img )
% 分块求DFT
% 不做缩放，仅仅补零
% 用m1和n1来表示两个方向上的块数
%（另外两张图因为做缩放两个方向上分块数相同）
% DFT_img和padded_img 分别为
% 做完DFT的幅度谱图像和补零后的原图
% 四维取代cell

[m, n] = size(ori_img);
mleft = 8 - mod(m, 8);
nleft = 8 - mod(n, 8);
if mleft == 8
    mleft = 0;
end
if nleft == 8
    nleft = 0;
end

padded_img = padarray(ori_img, [mleft, nleft], 'replicate', 'post');
[mpad, npad] = size(padded_img);
m1 = mpad / 8;
n1 = npad / 8;
re = zeros([m1, n1, 32, 32]);
im = zeros([m1, n1, 32, 32]);
DFT_blocks = complex(re, im);

DFT_img = zeros(m1*32, n1*32);
padded_DFT_img = padarray(padded_img, [12, 12], 'replicate', 'both');

for i = 1:m1
        for j = 1:n1
            mmin = 8 * (i - 1) + 1;
            mmax = mmin + 32 - 1;
            nmin = 8 * (j - 1) + 1;
            nmax = nmin + 32 - 1;
            single_block= padded_DFT_img(mmin:mmax, nmin:nmax);
            dft = fftshift(fft2(single_block));
            DFT_blocks(i,j,:,:) = dft(:,:);
            block = abs(squeeze(DFT_blocks(i,j,:,:)));
            blmin = min(block(:));
            blmax = max(block(:));
            block = (block - blmin) / (blmax - blmin);
            DFT_img(1 + 32 * (i - 1):32 * i, 1 + 32 * (j - 1):32 * j) = block;
        end
end


