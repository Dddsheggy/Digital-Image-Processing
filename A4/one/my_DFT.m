function [fun_DFT] = my_DFT(original_fun, m)
i = complex(0, 1);
w = exp(-2*pi*i/m);
[X, Y] = meshgrid(0:m-1);
N = X .* Y;
W = w .^ N;
fun_DFT = W * original_fun * W;
end

