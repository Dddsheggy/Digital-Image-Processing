% read an image 
% find the edges
% get hsv
color_pic = imread('eye3.jpg');
color_pic = im2double(color_pic);
hsv_pic = rgb2hsv(color_pic);
tmp = ones(size(hsv_pic(:,:,1))).* 0.333;
hsv_pic(:,:,1) = tmp;
hsv_pic(:,:,2) = hsv_pic(:,:,2).*3;
trans_pic1 = hsv2rgb(hsv_pic);

gray_pic = rgb2gray(color_pic);
gray_pic = im2double(gray_pic);
BW = edge(gray_pic,'canny',0.08);
[m, n] = size(BW);


% display
figurenum = 1;
figure(figurenum),imshow(color_pic);

% find specific areas that may have circle edges
% rect_left_eyeball = getrect();
rect_left_eyeball = [993  313  247  219];
left_eyeball_detect_area = BW(rect_left_eyeball(2): rect_left_eyeball(2)+rect_left_eyeball(4),rect_left_eyeball(1): rect_left_eyeball(1)+rect_left_eyeball(3));
[mlb, nlb] = size(left_eyeball_detect_area);
% rect_left_eyelid_up = getrect();
rect_left_eyelid_up= [932  359  388  333];
left_eyelid_detect_area_up = BW(rect_left_eyelid_up(2): rect_left_eyelid_up(2)+rect_left_eyelid_up(4),rect_left_eyelid_up(1): rect_left_eyelid_up(1)+rect_left_eyelid_up(3));
[mllu,nllu] = size(left_eyelid_detect_area_up);
% rect_left_eyelid_low = getrect();
rect_left_eyelid_low = [963  154  346  334];
left_eyelid_detect_area_low = BW(rect_left_eyelid_low(2): rect_left_eyelid_low(2)+rect_left_eyelid_low(4),rect_left_eyelid_low(1): rect_left_eyelid_low(1)+rect_left_eyelid_low(3));
[mlll,nlll] = size(left_eyelid_detect_area_low);

% rect_right_eyeball = getrect();
rect_right_eyeball = [277  296  182  210];
right_eyeball_detect_area = BW(rect_right_eyeball(2): rect_right_eyeball(2)+rect_right_eyeball(4),rect_right_eyeball(1): rect_right_eyeball(1)+rect_right_eyeball(3));
[mrb, nrb] = size(right_eyeball_detect_area);
% rect_right_eyelid_up = getrect();
rect_right_eyelid_up = [187  383  357  339];
right_eyelid_detect_area_up = BW(rect_right_eyelid_up(2): rect_right_eyelid_up(2)+rect_right_eyelid_up(4),rect_right_eyelid_up(1): rect_right_eyelid_up(1)+rect_right_eyelid_up(3));
[mrlu,nrlu] = size(right_eyelid_detect_area_up );
% rect_right_eyelid_low = getrect();
rect_right_eyelid_low = [143  115  423  396];
right_eyelid_detect_area_low = BW(rect_right_eyelid_low (2): rect_right_eyelid_low (2)+rect_right_eyelid_low (4),rect_right_eyelid_low (1): rect_right_eyelid_low (1)+rect_right_eyelid_low (3));
[mrll,nrll] = size(right_eyelid_detect_area_low);

% constant parameters for detecting circles
step_r = 1;
step_angle = 0.02;

% parameters for left eyeball
% out means the outside bigger circle
% in means the inside smaller circle
r_min_eyeball_out = 60;
r_max_eyeball_out = 70;
pball = 0.75;

% parameters for left eyelid
% up means the upper eyelid
% low means the lower eyelid
r_min_left_eyelid_up = 177;
r_max_left_eyelid_up = 180;
r_min_left_eyelid_low = 160;
r_max_left_eyelid_low = 180;
plid = 0.85;

% parameters for right eyelid
% up means the upper eyelid
% low means the lower eyelid
r_min_right_eyelid_up = 177;
r_max_right_eyelid_up = 180;
r_min_right_eyelid_low = 210;
r_max_right_eyelid_low = 220;

[ hough_space_left_eyeball_out, hough_circle_left_eyeball_out, para_left_eyeball_out ] = DetectCircle( left_eyeball_detect_area, step_r, step_angle, r_min_eyeball_out, r_max_eyeball_out, pball );
[ hough_space_left_eyelid_up, hough_circle_left_eyelid_up, para_left_eyelid_up ] = DetectCircle( left_eyelid_detect_area_up, step_r, step_angle, r_min_left_eyelid_up, r_max_left_eyelid_up, plid );
[ hough_space_left_eyelid_low, hough_circle_left_eyelid_low, para_left_eyelid_low ] = DetectCircle( left_eyelid_detect_area_low, step_r, step_angle, r_min_left_eyelid_low, r_max_left_eyelid_low, plid );

[ hough_space_right_eyeball_out, hough_circle_right_eyeball_out, para_right_eyeball_out ] = DetectCircle( right_eyeball_detect_area, step_r, step_angle, r_min_eyeball_out, r_max_eyeball_out, pball );
[ hough_space_right_eyelid_up, hough_circle_right_eyelid_up, para_right_eyelid_up ] = DetectCircle( right_eyelid_detect_area_up, step_r, step_angle, r_min_right_eyelid_up, r_max_right_eyelid_up, plid );
[ hough_space_right_eyelid_low, hough_circle_right_eyelid_low, para_right_eyelid_low ] = DetectCircle( right_eyelid_detect_area_low, step_r, step_angle, r_min_right_eyelid_low, r_max_right_eyelid_low, plid );

mean_b_left_eyeball_out = round(mean(para_left_eyeball_out(1,:,:)));
mean_a_left_eyeball_out = round(mean(para_left_eyeball_out(2,:,:)));
mean_r_left_eyeball_out = round(mean(para_left_eyeball_out(3,:,:)));
mask_left_eyeball_out = zeros(mlb,nlb);

mean_b_left_eyeball_in = mean_b_left_eyeball_out;
mean_a_left_eyeball_in = mean_a_left_eyeball_out;
mean_r_left_eyeball_in = round(mean_r_left_eyeball_out/3);
mask_left_eyeball_in = ones(mlb,nlb);


mean_b_left_eyelid_up = round(max(para_left_eyelid_up(1,:,:)));
mean_a_left_eyelid_up = round(min(para_left_eyelid_up(2,:,:)));
mean_r_left_eyelid_up = round(min(para_left_eyelid_up(3,:,:)));
mask_left_eyelid_up = zeros(mllu,nllu);

mean_b_left_eyelid_low = round(mean(para_left_eyelid_low(1,:,:)));
mean_a_left_eyelid_low = round(mean(para_left_eyelid_low(2,:,:)));
mean_r_left_eyelid_low = round(mean(para_left_eyelid_low(3,:,:)));
mask_left_eyelid_low = zeros(mlll,nlll);

for i=1:mlb
    for j=1:nlb
        if ((i-mean_b_left_eyeball_out)^2+(j-mean_a_left_eyeball_out)^2<=mean_r_left_eyeball_out^2)
            mask_left_eyeball_out(i,j) = 1;
        end
    end
end
for i=1:mlb
    for j=1:nlb
        if ((i-mean_b_left_eyeball_in)^2+(j-mean_a_left_eyeball_in)^2<=mean_r_left_eyeball_in^2)
            mask_left_eyeball_in(i,j) = 0;
        end
    end
end
for i=1:mllu
    for j=1:nllu
        if ((i-mean_b_left_eyelid_up)^2+(j-mean_a_left_eyelid_up)^2<=mean_r_left_eyelid_up^2)
            mask_left_eyelid_up(i,j) = 1;
        end
    end
end
for i=1:mlll
    for j=1:nlll
        if ((i-mean_b_left_eyelid_low)^2+(j-mean_a_left_eyelid_low)^2<=mean_r_left_eyelid_low^2)
            mask_left_eyelid_low(i,j) = 1;
        end
    end
end
mask_left = zeros(m,n);
for i=rect_left_eyeball(2): rect_left_eyeball(2)+rect_left_eyeball(4)
    for j=rect_left_eyeball(1): rect_left_eyeball(1)+rect_left_eyeball(3)
        mask_left(i,j) = mask_left_eyeball_in(i+1-rect_left_eyeball(2),j+1-rect_left_eyeball(1)) & mask_left_eyeball_out(i+1-rect_left_eyeball(2),j+1-rect_left_eyeball(1));
    end
end
mask_left1 = zeros(m,n);
for i=rect_left_eyelid_up(2): rect_left_eyelid_up(2)+rect_left_eyelid_up(4)
    for j=rect_left_eyelid_up(1): rect_left_eyelid_up(1)+rect_left_eyelid_up(3)
        mask_left1(i,j) = mask_left_eyelid_up(i+1-rect_left_eyelid_up(2),j+1-rect_left_eyelid_up(1));
    end
end
mask_left2 = zeros(m,n);
for i=rect_left_eyelid_low(2): rect_left_eyelid_low(2)+rect_left_eyelid_low(4)
    for j=rect_left_eyelid_low(1): rect_left_eyelid_low(1)+rect_left_eyelid_low(3)
        mask_left2(i,j) = mask_left_eyelid_low(i+1-rect_left_eyelid_low(2),j+1-rect_left_eyelid_low(1));
    end
end
mask_left = mask_left&mask_left1&mask_left2;

mean_b_right_eyeball_out = round(mean(para_right_eyeball_out(1,:,:)));
mean_a_right_eyeball_out = round(mean(para_right_eyeball_out(2,:,:)));
mean_r_right_eyeball_out = round(mean(para_right_eyeball_out(3,:,:)));
mask_right_eyeball_out = zeros(mrb,nrb);

mean_b_right_eyeball_in = mean_b_right_eyeball_out;
mean_a_right_eyeball_in = mean_a_right_eyeball_out;
mean_r_right_eyeball_in = round(mean_r_right_eyeball_out/3);
mask_right_eyeball_in = ones(mrb,nrb);

mean_b_right_eyelid_up = round(mean(para_right_eyelid_up(1,:,:)));
mean_a_right_eyelid_up = round(mean(para_right_eyelid_up(2,:,:)));
mean_r_right_eyelid_up = round(mean(para_right_eyelid_up(3,:,:)));
mask_right_eyelid_up = zeros(mrlu,nrlu);

mean_b_right_eyelid_low = round(mean(para_right_eyelid_low(1,:,:)));
mean_a_right_eyelid_low = round(mean(para_right_eyelid_low(2,:,:)));
mean_r_right_eyelid_low = round(mean(para_right_eyelid_low(3,:,:)));
mask_right_eyelid_low = zeros(mrll,nrll);

for i=1:mrb
    for j=1:nrb
        if ((i-mean_b_right_eyeball_out)^2+(j-mean_a_right_eyeball_out)^2<=mean_r_right_eyeball_out^2)
            mask_right_eyeball_out(i,j) = 1;
        end
    end
end
for i=1:mrb
    for j=1:nrb
        if ((i-mean_b_right_eyeball_in)^2+(j-mean_a_right_eyeball_in)^2<=mean_r_right_eyeball_in^2)
            mask_right_eyeball_in(i,j) = 0;
        end
    end
end
for i=1:mrlu
    for j=1:nrlu
        if ((i-mean_b_right_eyelid_up)^2+(j-mean_a_right_eyelid_up)^2<=mean_r_right_eyelid_up^2)
            mask_right_eyelid_up(i,j) = 1;
        end
    end
end
for i=1:mrll
    for j=1:nrll
        if ((i-mean_b_right_eyelid_low)^2+(j-mean_a_right_eyelid_low)^2<=mean_r_right_eyelid_low^2)
            mask_right_eyelid_low(i,j) = 1;
        end
    end
end
mask_right = zeros(m,n);
for i=rect_right_eyeball(2): rect_right_eyeball(2)+rect_right_eyeball(4)
    for j=rect_right_eyeball(1): rect_right_eyeball(1)+rect_right_eyeball(3)
        mask_right(i,j) = mask_right_eyeball_in(i+1-rect_right_eyeball(2),j+1-rect_right_eyeball(1)) & mask_right_eyeball_out(i+1-rect_right_eyeball(2),j+1-rect_right_eyeball(1));
    end
end
mask_right1 = zeros(m,n);
for i=rect_right_eyelid_up(2): rect_right_eyelid_up(2)+rect_right_eyelid_up(4)
    for j=rect_right_eyelid_up(1): rect_right_eyelid_up(1)+rect_right_eyelid_up(3)
        mask_right1(i,j) = mask_right_eyelid_up(i+1-rect_right_eyelid_up(2),j+1-rect_right_eyelid_up(1));
    end
end
mask_right2 = zeros(m,n);
for i=rect_right_eyelid_low (2): rect_right_eyelid_low (2)+rect_right_eyelid_low (4)
    for j=rect_right_eyelid_low (1): rect_right_eyelid_low (1)+rect_right_eyelid_low (3)
        mask_right2(i,j) = mask_right_eyelid_low(i+1-rect_right_eyelid_low (2),j+1-rect_right_eyelid_low (1));
    end
end
mask_right = mask_right&mask_right1&mask_right2;

mask = mask_right + mask_left;
figurenum = figurenum+1;
figure(figurenum),imshow(mask);
figurenum = figurenum+1;
figure(figurenum),imshow(mask.*gray_pic);
index = find(mask);
color_pic(index) = trans_pic1(index);
color_pic(index+m*n) = trans_pic1(index+m*n);
color_pic(index+m*n*2) = trans_pic1(index+m*n*2);
figurenum = figurenum+1;
figure(figurenum),imshow(color_pic);
imwrite(color_pic,'eye3change3.jpg');


