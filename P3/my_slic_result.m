clc
clear all
close all
% can be changed into other images
A=imread('1.jpg');
ks = [10 20 100 400 1600 6400];
for i = 1:length(ks)
    k = ks(i);
    tic;
    L = Aslic(A,k,10,2,10); 
    t = toc;
    figure(1), subplot(2,3,i)
    BW = boundarymask(L);
    imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67)
    title(sprintf('k: %d, time: %.2f sec', k, t));
     tic;
    L = slic(A,k,10,2,10); 
    t = toc;
    figure(2), subplot(2,3,i)
    BW = boundarymask(L);
    imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67)
    title(sprintf('k: %d, time: %.2f sec', k, t));
end