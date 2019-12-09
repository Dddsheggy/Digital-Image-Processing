% 读图
% 可以换图
pic_name = '77_8.bmp';
ori_img = imread(pic_name);
ori_img = im2double(ori_img);
figure(1),imshow(ori_img);
[m, n] = size(ori_img);

if strcmp(pic_name ,'23_2.bmp') || strcmp(pic_name , '77_8.bmp')
    % 调整原图尺寸
    % 一开始调到与原图尺寸最接近的满足重叠分割的边长
    % 尝试别的尺寸
    % 这两个尺寸比较合适
    if strcmp(pic_name ,'23_2.bmp')
        s = 358;
    elseif strcmp(pic_name , '77_8.bmp')
        s = 428;
    end
    resized_img = imresize(ori_img, [s, s], 'bicubic');

    % 去除直流分量
    resized_img = resized_img - mean2(resized_img);

    % 补零
    % 要以8*8分块为中心做32*32的DFT，添加一圈边缘
    zeroed_img = padarray(resized_img, [12, 12]);

    % 分块并求DFT
    % 每两个相邻8*8像素块间有一个宽度的重叠
    % 同时得到需做DFT的各像素块
    % 得到DFT结果及其幅度谱
    [block, DFT_block, result_block, abs_block, num] = get_block_and_DFT(resized_img, zeroed_img, s);

    % 估计图像是否属于指纹区域
    % 如果属于估计脊线方向和频率
    [ dir, fre ] = get_dir_and_fre( abs_block, num);
    
    % 显示方向图
    figure(2),show_dir(dir);

    % 对方向图进行平滑并显示
    better_dir = filter_dir( dir );
    figure(3),show_dir(better_dir);

    % 显示频率图
    figure(4),imshow(fre ./ max(max(fre)));
 
    % 对频率图进行平滑并显示
    h = fspecial('average', 5);
    better_fre = imfilter(fre,h,'replicate');
    figure(5),imshow(better_fre ./ max(max(better_fre)));

    % 得到每个像素块的gabor滤波器
    % 窗口大小11
    Wg = 11;
    Gabor_block = get_filter_block(better_fre, dir,Wg, num);

    % 按照论文方法对图像Gabor滤波
    better_img  = Gabor_img( better_fre, zeroed_img, s, Gabor_block);
    figure(6),imshow(better_img);
    
elseif strcmp(pic_name ,'3.bmp')
    
    % 分块并求DFT
    [DFT_img, m1, n1, padded_img ] = get_block_and_DFT1(ori_img);

    % 前景分割mask
    mask = zeros(size(padded_img));

    % 估计脊线方向和频率，得到mask
    [ dir, wav, mask, fre ] = get_dir_and_fre1(DFT_img, m1, n1, mask);
    figure(2),show_dir(dir);
    figure(3),imshow( fre ./ max(max( fre)));
    % 尝试gaussian,average和disk,disk效果最好
    h = fspecial('disk', 5);
    mask = imfilter(mask,h);
    figure(4),imshow(mask);

    % 对方向图和频率图进行平滑
    better_dir = filter_dir( dir );
    h = fspecial('average', 5);
    wav = imfilter(wav, h);
    fre = imfilter(fre, h);
    figure(5),show_dir(better_dir);
    figure(6),imshow(fre ./ max(max(fre)));

    % gabor滤波
    better_img = Gabor_img1(padded_img, wav, better_dir, mask);
    figure(8),imshow(better_img);
    
end
    






        

