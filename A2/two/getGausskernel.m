function [ Gausskernel ] = getGausskernel(a, sigma)
% a: size of the kernel
% sigma: variance

% odd
if mod(a,2)==0
    a = a+1;
end

Gausskernel = zeros(a,a);
center = ceil(a/2);

for i=1:a
    for j=1:a
        Gausskernel(i,j) = exp(-((i-center)^2+(j-center)^2) / (2*sigma^2));
    end
end

% normalization
sumG = sum(sum(Gausskernel));
Gausskernel = Gausskernel ./ sumG;


end

