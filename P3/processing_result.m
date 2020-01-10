% can be changed into other images
% as for the value of itr_num, try 5 or 10 or 20
% [L, info, L1, L2,info1,info2] = slic(A, k,m, adjRadius,itr_num);
% using 10 now
A = imread('1.jpg');
[L, info, L1, L2,info1,info2] = slic(A, 400,10, 2,10);
BW = boundarymask(L1);
figure(1),imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67);
figure(2),imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67);
hold on
plot(info1(2,:),info(1,:),'*r')
hold off
BW = boundarymask(L2);
figure(3),imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67);
figure(4),imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67);
hold on
plot(info2(2,:),info(1,:),'*r')
hold off
BW = boundarymask(L);
figure(5),imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67);
figure(6),imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67);
hold on
plot(info(2,:),info(1,:),'*r')
hold off




