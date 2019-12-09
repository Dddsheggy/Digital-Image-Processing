function [ hough_space, hough_circle, para ] = DetectCircle( detect_area, step_r, step_angle, r_min, r_max, p )
%----------------output-----------------
% hough_space: 参数空间
% hough_circle: 检测到的圆
% para: 各圆的参数（圆心坐标和半径）

% -----------------input-----------------
% detect_area: 限制了坐标范围的二值图像
% step_r: 半径步长
% step_angle: 角度步长（弧度制）
% r_min：半径最小值
% r_max: 半径最大值
% p: 以p*hough_space的最大值为投票阈值

[m, n] = size(detect_area);
length_r = round((r_max-r_min)/step_r)+1;
length_angle = round(2*pi/step_angle);

hough_space = zeros(m,n,length_r);

[rows, cols] = find(detect_area);
cnt = size(rows);

for i=1:cnt
    for j=1:length_r
        for k=1:length_angle
            a = round(rows(i) - (r_min+(j-1)*step_r)*cos(k*step_angle));
            b = round(cols(i) - (r_min+(j-1)*step_r)*sin(k*step_angle));
            if (a>=1 && a<=m && b>=1 && b<=n)
                hough_space(a, b, j) = hough_space(a, b, j)+1;
            end
        end
    end
end

max_value = max(max(max(hough_space)));
idx  = find(hough_space>=max_value*p);
num = size(idx);
hough_circle = false(m,n);


for i=1:cnt
    for j=1:num
        para_r = floor(idx(j)/(m*n))+1;
        para_a = floor((idx(j)-(para_r-1)*(m*n))/m)+1;
        para_b = idx(j)-(para_r-1)*(m*n) - (para_a-1)*m;
        if((rows(i)-para_b)^2+(cols(i)-para_a)^2<(r_min+(para_r-1)*step_r)^2+5&&...
                (rows(i)-para_b)^2+(cols(i)-para_a)^2>(r_min+(para_r-1)*step_r)^2-5)
            hough_circle(rows(i),cols(i))=true;
        end
    end
end

for i=1:num
    para_r = floor(idx(i)/(m*n))+1;
    para_a = floor((idx(i)-(para_r-1)*(m*n))/m)+1;
    para_b = idx(i)-(para_r-1)*(m*n) - (para_a-1)*m;
    para_r = r_min+(para_r-1)*step_r;
    para(:,i) = [para_b,para_a,para_r]; 
end
end
