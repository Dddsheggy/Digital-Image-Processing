function [ better_img ] = Gabor_img1( padded_img, fre, dir, mask)
% 对边长为8的倍数的补零后原图做处理
% 用16×16的窗口
pad = padarray(padded_img, [4, 4], 'replicate', 'both');
dir = dir - pi / 2;
[m, n] = size(padded_img);
gabored_img = zeros([m + 8, n + 8]);

for i = 1:m/8
      for j = 1:n/8
          mmin = 8 * (i - 1) + 1;
          mmax = mmin + 16 - 1;
          nmin = 8 * (j - 1) + 1;
          nmax = nmin + 16 - 1;
          block = pad(mmin:mmax, nmin:nmax);
           if fre(i, j) < 2
                continue;
           end
           [amp, phs] = imgaborfilt(block, fre(i, j), dir(i, j) / pi *180);
           gabored_img(mmin:mmax, nmin:nmax) = gabored_img(mmin:mmax, nmin:nmax) + amp .* cos(phs);
      end
end

gabored_img = gabored_img(5:4 + m,5:4 + n);
better_img = gabored_img .* mask;
better_img = better_img + (1-mask);

end

