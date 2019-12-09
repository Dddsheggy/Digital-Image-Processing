function [ kernel ] = IBF( a, b )
x = 17;
y = 17;
kernel = zeros(32,32);
for i = 1:32
    for j = 1:32
        dx = i - x;
        dy = j - y;
        % 像素点到中心的距离
        dis = dx^2 + dy^2;
        if dis > a^2 && dis < b^2
            kernel(i, j) = 1;
        end
    end
end

end

