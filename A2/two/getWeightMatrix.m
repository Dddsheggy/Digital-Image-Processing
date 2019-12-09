function [K] = getWeightMatrix(img, m, n)
% [m, n]: size of img
% get the index of img's focus

sumvalue = sum(sum(img));
summ = 0;
sumn = 0;

for i=1:m
    for j=1:n
        summ = summ + img(i,j)*i;
        sumn = sumn + img(i,j)*j;
    end
end

centerm = ceil(summ/sumvalue);
centern = ceil(sumn/sumvalue);

% get other pixels' distance from focus
% saved in K
K = zeros(m,n);
for i=1:m
    for j=1:n
        if (i>=centerm) && (j>=centern)
            % normalization
            K(i,j) = ((i-centerm)/(m-centerm)+(j-centern)/(n-centern))/2;
        elseif (i>=centerm) && (j<centern)
            K(i,j) = ((i-centerm)/(m-centerm)+(centern-j)/centern)/2;
        elseif (i<centerm) && (j>=centern)
            K(i,j) = ((centerm-i)/centerm+(j-centern)/(n-centern))/2;
        elseif (i<centerm) && (j<centern)
            K(i,j) = ((centerm-i)/centerm+(centern-j)/centern)/2;
        end
    end
end

end

