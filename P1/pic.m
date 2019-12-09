% ��ͼ
% ���Ի�ͼ
pic_name = '77_8.bmp';
ori_img = imread(pic_name);
ori_img = im2double(ori_img);
figure(1),imshow(ori_img);
[m, n] = size(ori_img);

if strcmp(pic_name ,'23_2.bmp') || strcmp(pic_name , '77_8.bmp')
    % ����ԭͼ�ߴ�
    % һ��ʼ������ԭͼ�ߴ���ӽ��������ص��ָ�ı߳�
    % ���Ա�ĳߴ�
    % �������ߴ�ȽϺ���
    if strcmp(pic_name ,'23_2.bmp')
        s = 358;
    elseif strcmp(pic_name , '77_8.bmp')
        s = 428;
    end
    resized_img = imresize(ori_img, [s, s], 'bicubic');

    % ȥ��ֱ������
    resized_img = resized_img - mean2(resized_img);

    % ����
    % Ҫ��8*8�ֿ�Ϊ������32*32��DFT�����һȦ��Ե
    zeroed_img = padarray(resized_img, [12, 12]);

    % �ֿ鲢��DFT
    % ÿ��������8*8���ؿ����һ����ȵ��ص�
    % ͬʱ�õ�����DFT�ĸ����ؿ�
    % �õ�DFT������������
    [block, DFT_block, result_block, abs_block, num] = get_block_and_DFT(resized_img, zeroed_img, s);

    % ����ͼ���Ƿ�����ָ������
    % ������ڹ��Ƽ��߷����Ƶ��
    [ dir, fre ] = get_dir_and_fre( abs_block, num);
    
    % ��ʾ����ͼ
    figure(2),show_dir(dir);

    % �Է���ͼ����ƽ������ʾ
    better_dir = filter_dir( dir );
    figure(3),show_dir(better_dir);

    % ��ʾƵ��ͼ
    figure(4),imshow(fre ./ max(max(fre)));
 
    % ��Ƶ��ͼ����ƽ������ʾ
    h = fspecial('average', 5);
    better_fre = imfilter(fre,h,'replicate');
    figure(5),imshow(better_fre ./ max(max(better_fre)));

    % �õ�ÿ�����ؿ��gabor�˲���
    % ���ڴ�С11
    Wg = 11;
    Gabor_block = get_filter_block(better_fre, dir,Wg, num);

    % �������ķ�����ͼ��Gabor�˲�
    better_img  = Gabor_img( better_fre, zeroed_img, s, Gabor_block);
    figure(6),imshow(better_img);
    
elseif strcmp(pic_name ,'3.bmp')
    
    % �ֿ鲢��DFT
    [DFT_img, m1, n1, padded_img ] = get_block_and_DFT1(ori_img);

    % ǰ���ָ�mask
    mask = zeros(size(padded_img));

    % ���Ƽ��߷����Ƶ�ʣ��õ�mask
    [ dir, wav, mask, fre ] = get_dir_and_fre1(DFT_img, m1, n1, mask);
    figure(2),show_dir(dir);
    figure(3),imshow( fre ./ max(max( fre)));
    % ����gaussian,average��disk,diskЧ�����
    h = fspecial('disk', 5);
    mask = imfilter(mask,h);
    figure(4),imshow(mask);

    % �Է���ͼ��Ƶ��ͼ����ƽ��
    better_dir = filter_dir( dir );
    h = fspecial('average', 5);
    wav = imfilter(wav, h);
    fre = imfilter(fre, h);
    figure(5),show_dir(better_dir);
    figure(6),imshow(fre ./ max(max(fre)));

    % gabor�˲�
    better_img = Gabor_img1(padded_img, wav, better_dir, mask);
    figure(8),imshow(better_img);
    
end
    






        

