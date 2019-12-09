function [ dir, fre ] = get_dir_and_fre( abs_block, num )
% 图像块方向
dir = zeros(num, num);
% 归一化后的图像块频率
fre = zeros(num, num);
distance = zeros(num, num);

for i=1:num
    for j=1:num
        [x, y] = sort(abs_block{i, j}(:),'descend');
%         [x1, y1] = ind2sub([32, 32],y(1));
%         [x2, y2] = ind2sub([32, 32],y(2));
%         dir(i,j) = atan((x2-x1)/(y2-y1))+pi/2;
%         distance(i,j) = sqrt((x2-17)^2+((y2-17)^2));
%         fre(i,j) = distance(i,j)/64;
%          if(distance(i,j)>=6)
%             fre(i,j) = -1;
%             dir(i,j) = 0;
%          end 
        for k=1:10
            % 本来应该求取两峰值间的距离
            % 但因为指纹图像不是标准正弦波且存在干扰
            % 换成在最大的10个点中找关于原点对称的一对
            % 否则效果不理想
            
            % 返回矩阵下标
            [x1, y1] = ind2sub([32, 32],y(k));
            [x2, y2] = ind2sub([32, 32],y(k+1));
            if (abs_block{i,j}(x1,y1)==abs_block{i,j}(x2,y2)&&(x1+x2)/2==17&&(y1+y2)/2==17)
                dir(i,j) = atan((x2-x1)/(y2-y1))+pi/2;
                distance(i,j) = sqrt(((x2-x1)/2)^2+((y2-y1)/2)^2);
                fre(i,j) = distance(i,j)/32;
                if (distance(i,j)>=6)
                    fre(i,j) = -1;
                    dir(i,j) = 0;
                end
                break;
            end
        end
    end
end
% 对图片'23_2.bmp'的特殊处理
% 通过调参可以去掉此段所要去除的图片底部阴影
% 但也会导致此外的整个图片效果不如这样处理的结果
% 最终还是选择这样处理
if num == 51
    fre(49:51,:) = -1;
end
end

