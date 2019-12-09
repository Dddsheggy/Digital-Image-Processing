function [ gb ] = filter_Gabor(newdir, newfre, W )
% 论文sigma设为4，对'23_2.bmp'效果不如为5时好
[x, y] = meshgrid(-W:W);
sigma = 5;

% 公式参照论文
gb = exp(-(x.^2/sigma^2+y.^2/sigma^2)/2).*cos(2*pi*newfre*x);
gb = imrotate(gb, newdir*180/pi, 'bilinear', 'crop');

end

