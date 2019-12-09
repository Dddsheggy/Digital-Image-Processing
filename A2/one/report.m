my_mean_local = imread('my_mean_local.jpg');
nlfilter_mean_local = imread('t_mean_local.jpg');

my_std_local = imread('my_std_local.jpg');
nlfilter_std_local = imread('t_std_local.jpg');

my_mask = imread('my_mask.jpg');
nlfilter_mask = imread('t_mask.jpg');

my_enhance = imread('my_enhance.jpg');
nlfilter_enhance = imread('t_enhance.jpg');

figure(1);
subplot(1,2,1),imshow(my_mean_local),title('my mean local');
subplot(1,2,2),imshow(nlfilter_mean_local),title('nlfilter mean local');

figure(2);
subplot(1,2,1),imshow(my_std_local),title('my std local');
subplot(1,2,2),imshow(nlfilter_std_local),title('nlfilter std local');

figure(3);
subplot(1,2,1),imshow(my_mask),title('my mask');
subplot(1,2,2),imshow(nlfilter_mask),title('nlfilter mask');

figure(4);
subplot(1,2,1),imshow(my_enhance),title('my enhance');
subplot(1,2,2),imshow(nlfilter_enhance),title('nlfilter enhance');