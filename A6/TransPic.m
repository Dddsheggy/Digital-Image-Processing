function [ trans_pic ] = TransPic( ori_pic, point, rect, sat_ratio, hue_add )
ori_pic = im2double(ori_pic);
ori_hsv = rgb2hsv(ori_pic);
trans_hsv = ori_hsv;
M = size(ori_pic,1);
N = size(ori_pic,2);

trans_hsv(:,:,1) = mod(255*(ori_hsv(:,:,1)+hue_add),256)/255;
trans_hsv(:,:,2) = ori_hsv(:,:,2).^sat_ratio;

trans_pic1 = hsv2rgb(trans_hsv);
a = [ori_pic(point(2),point(1),1) ori_pic(point(2),point(1),2) ori_pic(point(2),point(1),3)];


if point ==[147 381] 
    R = 50/255;
elseif point == [1135 2601]
    R = 50/255;
else
    R = 100/255;
end
D = (ori_pic(:,:,1)-a(1)).^2+(ori_pic(:,:,2)-a(2)).^2+(ori_pic(:,:,3)-a(3)).^2;
mask = D<=R*R;

roi = false(size(mask));
roi(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3)) = 1;
mask = mask & roi;

trans_pic= ori_pic;
idx = find(mask);
trans_pic(idx) = trans_pic1(idx);
trans_pic(idx+M*N) = trans_pic1(idx+M*N);
trans_pic(idx+M*N*2) = trans_pic1(idx+M*N*2);

end

