function [ k ] = bsum(img, m1, n1)

% get block sum
% [m1, n1]: size of the sliding block
% same function as colfilt(img, [m1, n1], 'sliding', @sum)

m1 = floor(m1/2);
n1 = floor(n1/2);
[m, n] = size(img);
k = zeros(m,n);

% boundaries of the block
MIN = 1;
downmax = m;
rightmax = n;

for i = 1:m
    for j = 1:n
        k(i,j) = sum(sum(img(max(MIN, i-m1):min(downmax,i+m1),max(MIN, j-n1):min(rightmax,j+n1))));
    end
end
end

