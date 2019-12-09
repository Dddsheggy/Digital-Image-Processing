function [ mean_local, std_local ] = getLocalVar(img, h, w, m1, n1)
% get mean_local and std_local
% img: input image
% [h, w]: size of img
% [m1, n1]: size of the sliding block

N = bsum(ones(h, w), m1, n1);
data1 = bsum(img .* img, m1, n1) ./ N;
data2 = bsum(img, m1, n1);
mean_local = data2 ./ N;

std_local = (data1 - mean_local .* mean_local) .^ 0.5;
% var_local = std_local .^ 2;

end

