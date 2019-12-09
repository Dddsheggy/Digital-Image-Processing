close all
I = imread('0small.jpg');
% I = rgb2gray(I);
figure(1),imshow(I),set(gcf,'name','Original');
 
%% Global histogram equalization
J1 = histeq(I);
figure(2),imshow(J1),set(gcf,'name','Global histogram equalization');

%% Enhancement using local histogram statistics
I = double(I);
mean_global = mean2(I);
std_global = std2(I);

% get mean_local and std_local
[h, w] = size(I);
[mean_local, std_local] = getLocalVar(I, h, w, 3, 3);


figure(3),imshow(uint8(mean_local)),set(gcf,'name','Local mean');
imwrite(uint8(mean_local),'my_mean_local.jpg');
figure(4),imshow(uint8(std_local)),set(gcf,'name','Local standard deviation');
imwrite(uint8(std_local),'my_std_local.jpg');
% figure(3),imshow(mean_local,[]),set(gcf,'name','Local mean');
% figure(4),imshow(std_local,[]),set(gcf,'name','Local standard deviation');

k0 = 0.4; k1 = 0.02; k2 = 0.4; E = 4; % 
mask = (mean_local<=k0*mean_global) & (std_local>=k1*std_global) & (std_local<=k2*std_global);
J2 = I;
J2(mask) = I(mask)*E;
figure(5),imshow(mask),set(gcf,'name','MASK');
imwrite((mask),'my_mask.jpg');
figure(6),imshow(uint8(J2)),set(gcf,'name','Enhancement by local statistics');
imwrite((uint8(J2)),'my_enhance.jpg');