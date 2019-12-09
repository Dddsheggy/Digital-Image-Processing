function [ better_dir ] = filter_dir( dir )
% 按照题目给的建议滤波
dir2 = 2*dir;
cos_dir2 = cos(dir2);
sin_dir2 = sin(dir2);

h = fspecial('gaussian', 5, 4);
cos_dir2 = imfilter(cos_dir2, h, 'conv');
sin_dir2 = imfilter(sin_dir2, h, 'conv');

better_dir = 0.5*atan2(sin_dir2, cos_dir2);

end

