function [focusnum] = focusNum(i)
% i: number of the focused bottle (left to right)
% get new picture with No.i bottle as focus

pic = imread('0.jpg');
pic = im2double(pic);
[m,n,c] = size(pic);

% scale, shorten time
m1 = ceil(m / 6);
n1 = ceil(n / 6);
pic = imresize(pic, [floor(m1), floor(n1)],'bicubic');

% get the corresponding mask for No.i bottle
s = ['mask',num2str(i),'.jpg'];
mask = imread(s);
mask = rgb2gray(mask);
mask = im2double(mask);
mask = imresize(mask, [floor(m1), floor(n1)],'bicubic');

% get the index of the focus
% get other pixels' distance from the focus
pic1 = pic .* mask;
K = getWeightMatrix(pic1, m1, n1);

% blur the image 
[picblur, maskblur] = blurImg(pic, mask, K, m1, n1);

% add focus and background together
trans = 1 - maskblur;
picblur = picblur .* trans;
picclear = pic .* maskblur;

% scale, original size
focusnum = imresize((picclear + picblur), [floor(m), floor(n)],'bicubic');

end

