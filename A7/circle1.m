% read the image 
% find the edges
% get hsv
color_pic = imread('eye1.jpg');
color_pic = im2double(color_pic);
hsv_pic = rgb2hsv(color_pic);
hsv_pic(:,:,1) = mod(255*(hsv_pic(:,:,1)-0.3),256)/255;
trans_pic1 = hsv2rgb(hsv_pic);

gray_pic = rgb2gray(color_pic);
gray_pic = im2double(gray_pic);
BW = edge(gray_pic,'canny');
[m, n] = size(BW);

% display original image
figurenum = 1;
figure(figurenum),imshow(color_pic);

% find specific areas that may have circle edges
% rect_left_eyeball = getrect();
rect_left_eyeball = [981  348  167  141];
left_eyeball_detect_area = BW(348: 348+141,981:981+167);
[mlb, nlb] = size(left_eyeball_detect_area);
% rect_left_eyelid_up = getrect();
rect_left_eyelid_up = [902   355   357   340];
left_eyelid_detect_area_up = BW(355: 355+340,902:902+357);
[mllu,nllu] = size(left_eyelid_detect_area_up);
% rect_left_eyelid_low = getrect();
rect_left_eyelid_low = [900  210  333  292];
left_eyelid_detect_area_low = BW(210: 210+292,900:900+333);
[mlll,nlll] = size(left_eyelid_detect_area_low);

% rect_right_eyeball = getrect();
rect_right_eyeball = [380   393   153   134];
right_eyeball_detect_area = BW(393: 393+134,380:380+153);
[mrb, nrb] = size(right_eyeball_detect_area);
% rect_right_eyelid_up = getrect();
rect_right_eyelid_up = [298   384   349   324];
right_eyelid_detect_area_up = BW(349: 349+324,298:298+384);
[mrlu,nrlu] = size(right_eyelid_detect_area_up );
% rect_right_eyelid_low = getrect();
rect_right_eyelid_low = [291  215  328  321];
right_eyelid_detect_area_low = BW(215: 215+321,291:291+328);
[mrll,nrll] = size(right_eyelid_detect_area_low);

% constant parameters for detecting circles
step_r = 1;
step_angle = 0.02;

% parameters for eyeball
% out means the outside bigger circle
% in means the inside smaller circle
r_min_eyeball_out = 60;
r_max_eyeball_out = 61;
r_min_eyeball_in = 20;
r_max_eyeball_in = 25;
pball = 0.75;

% parameters for left eyelid
% up means the upper eyelid
% low means the lower eyelid
r_min_left_eyelid_up = 155;
r_max_left_eyelid_up = 158;
r_min_left_eyelid_low = 152;
r_max_left_eyelid_low = 155;
plid = 0.85;

% parameters for right eyelid
% up means the upper eyelid
% low means the lower eyelid
r_min_right_eyelid_up = 151;
r_max_right_eyelid_up = 152;
r_min_right_eyelid_low = 152;
r_max_right_eyelid_low = 155;


[ hough_space_left_eyeball_out, hough_circle_left_eyeball_out, para_left_eyeball_out ] = DetectCircle( left_eyeball_detect_area, step_r, step_angle, r_min_eyeball_out, r_max_eyeball_out, pball );
[ hough_space_left_eyeball_in, hough_circle_left_eyeball_in, para_left_eyeball_in ] = DetectCircle( left_eyeball_detect_area, step_r, step_angle, r_min_eyeball_in, r_max_eyeball_in, pball );
[ hough_space_left_eyelid_up, hough_circle_left_eyelid_up, para_left_eyelid_up ] = DetectCircle( left_eyelid_detect_area_up, step_r, step_angle, r_min_left_eyelid_up, r_max_left_eyelid_up, plid );
[ hough_space_left_eyelid_low, hough_circle_left_eyelid_low, para_left_eyelid_low ] = DetectCircle( left_eyelid_detect_area_low, step_r, step_angle, r_min_left_eyelid_low, r_max_left_eyelid_low, plid );

[ hough_space_right_eyeball_out, hough_circle_right_eyeball_out, para_right_eyeball_out ] = DetectCircle( right_eyeball_detect_area, step_r, step_angle, r_min_eyeball_out, r_max_eyeball_out, pball );
[ hough_space_right_eyeball_in, hough_circle_right_eyeball_in, para_right_eyeball_in ] = DetectCircle( right_eyeball_detect_area, step_r, step_angle, r_min_eyeball_in, r_max_eyeball_in, pball );
[ hough_space_right_eyelid_up, hough_circle_right_eyelid_up, para_right_eyelid_up ] = DetectCircle( right_eyelid_detect_area_up, step_r, step_angle, r_min_right_eyelid_up, r_max_right_eyelid_up, plid );
 [ hough_space_right_eyelid_low, hough_circle_right_eyelid_low, para_right_eyelid_low ] = DetectCircle( right_eyelid_detect_area_low, step_r, step_angle, r_min_right_eyelid_low, r_max_right_eyelid_low, plid );

mean_b_left_eyeball_out = round(mean(para_left_eyeball_out(1,:,:)));
mean_a_left_eyeball_out = round(mean(para_left_eyeball_out(2,:,:)));
mean_r_left_eyeball_out = round(mean(para_left_eyeball_out(3,:,:)));
mask_left_eyeball_out = zeros(mlb,nlb);
mean_b_left_eyeball_in = round(mean(para_left_eyeball_in(1,:,:)));
mean_a_left_eyeball_in = round(mean(para_left_eyeball_in(2,:,:)));
mean_r_left_eyeball_in = round(mean(para_left_eyeball_in(3,:,:)));
mask_left_eyeball_in = ones(mlb,nlb);
mean_b_left_eyelid_up = round(mean(para_left_eyelid_up(1,:,:)));
mean_a_left_eyelid_up = round(mean(para_left_eyelid_up(2,:,:)));
mean_r_left_eyelid_up = round(mean(para_left_eyelid_up(3,:,:)));
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
for i=348: 348+141
    for j=981:981+167
        mask_left(i,j) = mask_left_eyeball_in(i-347,j-980) & mask_left_eyeball_out(i-347,j-980);
    end
end
mask_left1 = zeros(m,n);
for i=355: 355+340
    for j=902:902+357
        mask_left1(i,j) = mask_left_eyelid_up(i-354,j-901);
    end
end
mask_left2 = zeros(m,n);
for i=210: 210+292
    for j=900:900+333
        mask_left2(i,j) = mask_left_eyelid_low(i-209,j-899);
    end
end
mask_left = mask_left&mask_left1&mask_left2;

mean_b_right_eyeball_out = round(mean(para_right_eyeball_out(1,:,:)));
mean_a_right_eyeball_out = round(mean(para_right_eyeball_out(2,:,:)));
mean_r_right_eyeball_out = round(mean(para_right_eyeball_out(3,:,:)));
mask_right_eyeball_out = zeros(mrb,nrb);
mean_b_right_eyeball_in = round(mean(para_right_eyeball_in(1,:,:)));
mean_a_right_eyeball_in = round(mean(para_right_eyeball_in(2,:,:)));
mean_r_right_eyeball_in = round(mean(para_right_eyeball_in(3,:,:)));
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
for i=393: 393+134
    for j=380:380+153
        mask_right(i,j) = mask_right_eyeball_in(i-392,j-379) & mask_right_eyeball_out(i-392,j-379);
    end
end
mask_right1 = zeros(m,n);
for i=349: 349+324
    for j=298:298+384
        mask_right1(i,j) = mask_right_eyelid_up(i-348,j-297);
    end
end
mask_right2 = zeros(m,n);
for i=215: 215+321
    for j=291:291+328
        mask_right2(i,j) = mask_right_eyelid_low(i-214,j-290);
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
imwrite(color_pic,'eye1change3.jpg');


