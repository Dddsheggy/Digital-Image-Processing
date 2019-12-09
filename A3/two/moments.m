function [ mix ] = moments( fullpath )
pic = imread(fullpath);
mask = imread('mask.png');

% change into the same size
[m,n,c] = size(mask);
pic = imresize(pic, [floor(m), floor(n)], 'bicubic');

% transfer mask
mask1 = mask(:,:,1);
mask2 = mask(:,:,2);
mask3 = mask(:,:,3);
index1 = find(mask1==0 & mask2==0 & mask3==0);
index2 = find(mask1==255 & mask2==255 & mask3==255);
mask1(index1) = 255;
mask2(index1) = 255;
mask3(index1) = 255;
mask1(index2) = 0;
mask2(index2) = 0;
mask3(index2) = 0;

mask(:,:,1) = mask1;
mask(:,:,2) = mask2;
mask(:,:,3) = mask3;

% add
mix = imlincomb(1,pic,1,mask);

% cut
mx = max([m n]);
mix = imresize(mix, [floor(mx), floor(mx)], 'bicubic');
temp = floor(mx/3);


imwrite(mix(1:temp,1:temp,1:3),'1.jpg');
imwrite(mix(1:temp,temp:temp*2,1:3),'2.jpg');
imwrite(mix(1:temp,temp*2:temp*3,1:3),'3.jpg');
imwrite(mix(temp:temp*2,1:temp,1:3),'4.jpg'); 
imwrite(mix(temp:temp*2,temp:temp*2,1:3),'5.jpg');
imwrite(mix(temp:temp*2,temp*2:temp*3,1:3),'6.jpg');
imwrite(mix(temp*2:temp*3,1:temp,1:3),'7.jpg');
imwrite(mix(temp*2:temp*3,temp:temp*2,1:3),'8.jpg');
imwrite(mix(temp*2:temp*3,temp*2:temp*3,1:3),'9.jpg');

figure
subplot(3,3,1),imshow('1.jpg');
subplot(3,3,2),imshow('2.jpg');
subplot(3,3,3),imshow('3.jpg');
subplot(3,3,4),imshow('4.jpg');
subplot(3,3,5),imshow('5.jpg');
subplot(3,3,6),imshow('6.jpg');
subplot(3,3,7),imshow('7.jpg');
subplot(3,3,8),imshow('8.jpg');
subplot(3,3,9),imshow('9.jpg');

end

