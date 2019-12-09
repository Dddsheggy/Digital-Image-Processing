function [ gb ] = filter_Gabor(newdir, newfre, W )
% ����sigma��Ϊ4����'23_2.bmp'Ч������Ϊ5ʱ��
[x, y] = meshgrid(-W:W);
sigma = 5;

% ��ʽ��������
gb = exp(-(x.^2/sigma^2+y.^2/sigma^2)/2).*cos(2*pi*newfre*x);
gb = imrotate(gb, newdir*180/pi, 'bilinear', 'crop');

end

