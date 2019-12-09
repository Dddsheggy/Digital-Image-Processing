function I4 = AddNoiseBatch(fullpath)
f = fullfile(fullpath);
d = dir(fullfile(f,'*.jpg'));
all_img = {d.name};
for i=1:length(all_img)
    pic = all_img{i};
    I1 = imread(pic);

    % judge gray or colorful
    % rgb2gray(colorful picture)
    pic_size = size(I1);
    pic_di = numel(pic_size);
    if pic_di == 3
        I2 = rgb2gray(I1);
    else
        I2 = I1;
    end

    % scale
    [m,n,c] = size(I2);
    I3 = imresize(I2, [floor(1000*m/n), floor(1000)], 'bicubic');

    % change datatype of I3
    I3 = im2double(I3);

    % gaussian noise
    [m,n,c] = size(I3);
    I_noise = randn(m,n);

    % add noise
    I4 = I3 + I_noise;

    % adjust gray value
    I4 = imadjust(I4, [], [0 1]);

    % show
    figure(i);
    s1 = subplot(1,3,1);
    imshow(I3);
    title('I3');
    s2 = subplot(1,3,2);
    imshow(I_noise);
    title('noise image');
    s3 = subplot(1,3,3);
    imshow(I4);
    title('I4');
    linkaxes([s1,s2,s3],'xy');

    % save I4
    imwrite(I4, [fullpath,'I4.bmp']);

end
end