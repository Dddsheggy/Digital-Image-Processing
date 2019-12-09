m = 256;
i = complex(0, 1);

% make impulse function
impulse_fun = zeros(m, m);
x = 144;
y = 144;
impulse_fun(x, y) = 1;
figure(1);
subplot(1,3,1),imshow(impulse_fun),title('original');
fft_impulse_fun = fftshift(fft2(impulse_fun));
subplot(1,3,2),imshow(fft_impulse_fun),title('fft2 impulse fun');

% impulse function 2D DFT
w = exp(-2*pi*i/m);
[X, Y] = meshgrid(0:m-1);
N = X .* Y;
W = w .^ N;
impulse_DFT = W * impulse_fun * W;
impulse_DFT = fftshift(impulse_DFT);
subplot(1,3,3),imshow(impulse_DFT),title('my impulse DFT');


% make sin function
[X, Y] = meshgrid(1:m);
sin_fun = cos(2*pi*0.1*X);
fft_sin_fun = fftshift(fft2(sin_fun));
figure(2);
subplot(1,3,1),imshow(sin_fun),title('original');
subplot(1,3,2),imshow(fft_sin_fun),title('fft2 sin DFT');

% sin function 2D DFT
sin_DFT = fftshift(my_DFT(sin_fun,m));
subplot(1,3,3),imshow(sin_DFT),title('my sin DFT');

% make rec function
rec_fun = zeros(m, m);
x = 100;
y = 100;
long_edge = 20;
scale = 0.3;
short_edge = long_edge * scale;
rec_fun(x - long_edge:x + long_edge, y - short_edge:y + short_edge) = 1;
figure(3);
subplot(1,3,1),imshow(rec_fun),title('original');
% rec function 2D DFT
rec_DFT = fftshift(my_DFT(rec_fun,m));
fft_rec_fun = fftshift(fft2(rec_fun));
subplot(1,3,2),imshow(fft_rec_fun),title('fft2 rec DFT');
subplot(1,3,3),imshow(rec_DFT),title('my rec DFT');



% make gaussian function
sigma = 41;
gauss_fun = zeros(m, m);
center = ceil(m/2);
for s=1:m
    for t=1:m
        gauss_fun(s,t) = exp(-((s-center)^2+(t-center)^2) / (2*sigma^2)) / (2*pi*sigma^2);
    end
end

figure(4);
subplot(1,3,1),imshow(gauss_fun,[]),title('original');
fft_gauss_fun = fftshift(fft2(gauss_fun));
subplot(1,3,2),imshow(fft_gauss_fun),title('fft2 gauss DFT');

% gaussian function 2D DFT
gauss_DFT = fftshift(my_DFT(gauss_fun,m));
subplot(1,3,3),imshow(gauss_DFT),title('my gauss DFT');

