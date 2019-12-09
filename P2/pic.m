% or 'r96_4.bmp'
img_name = 'r96_4.bmp';
ori_img = imread(img_name);
ori_img = im2double(ori_img);
fignum = 1;
figure(fignum),imshow(ori_img);

% binarize
% thresh = graythresh(ori_img);
if strcmp(img_name,'r2_5.bmp')
    thresh = 0.51;
%     bi_img = imbinarize(ori_img,'adaptive','ForegroundPolarity','dark','Sensitivity',thresh);
else
    thresh = 0.5;
end
bi_img = imbinarize(ori_img, thresh);
fignum = fignum + 1;
figure(fignum),imshow(bi_img);

% effective for 'r2_5.bmp'
% no need for 'r96_4.bmp'
if strcmp(img_name,'r2_5.bmp')
    % fill holes
    marker = ~bi_img;
    marker(300:end-1,2:end-1) = 0;
    bi_img = imreconstruct(marker, ~bi_img);
    bi_img=~bi_img;
    fignum = fignum + 1;
    figure(fignum),imshow(bi_img); 
    % clear islands
    bi_img = bwareaopen(bi_img,8);
    fignum = fignum + 1;
    figure(fignum),imshow(bi_img);
end

% thining
thin_img = bwmorph(bi_img,'thin',Inf);
fignum = fignum + 1;
figure(fignum),imshow(thin_img);
% clear short lines
thin_img = bwareaopen(thin_img,8);
fignum = fignum + 1;
figure(fignum),imshow(thin_img);
% pruning
thin_img = Pruning(thin_img,3);
fignum = fignum + 1;
figure(fignum),imshow(thin_img);
% clear bridge
if strcmp(img_name,'r96_4.bmp')
    se = [0 0 0 0 1 0 0;0 0 0 0 1 1 1;0 0 0 1 0 0 0; 0 0 1 0 0 0 0;1 1 0 0 0 0 0];
    se2 = [1 1 1 1 0 1 1;1 1 1 1 0 0 0;1 1 1 0 1 1 1; 1 1 0 1 1 1 1;0 0 1 1 1 1 1];
    p = bwhitmiss(thin_img,se,se2);
    thin_img(p==1) = 0;
    thin_img = Pruning(thin_img,3);
    fignum = fignum + 1;
    figure(fignum),imshow(thin_img);
end


% get feature points
[m, n] = size(thin_img);
% the number of branch points
brnnum = 0;
% the number of end points
endnum = 0;
% indexs of  branch points
brnx(:) = 0;
brny(:) = 0;
% indexs of  end points
endx(:) = 0;
endy(:) = 0;

% calculate cn for every pixel
for i=2:m-1
    for j=2:n-1
        cn = 0;
        if(thin_img(i,j))
            cn = 0.5*(abs(thin_img(i-1,j)-thin_img(i-1,j-1))+abs(thin_img(i-1,j+1)-thin_img(i-1,j))+abs(thin_img(i,j+1)-thin_img(i-1,j+1))+abs(thin_img(i+1,j+1)-thin_img(i,j+1))+abs(thin_img(i+1,j)-thin_img(i+1,j+1))+abs(thin_img(i+1,j-1)-thin_img(i+1,j))+abs(thin_img(i,j-1)-thin_img(i+1,j-1))+abs(thin_img(i-1,j-1)-thin_img(i,j-1)));
        end 
        if cn == 3
            brnnum = brnnum + 1;
            brnx(brnnum) = j;
            brny(brnnum) = i;
        elseif cn == 1
            endnum = endnum + 1;
            endx(endnum) = j;
            endy(endnum) = i;
        end
    end
end
fignum = fignum + 1;
figure(fignum),imshow(thin_img)
hold on
plot(endx, endy, 'go')
plot(brnx, brny, 'ro')
hold off


% clear fake feature points
% points on border
for i=1:endnum
    cx = endx(i);
    cy = endy(i);
    flag = 0;
    blk1 = thin_img(cy-14:cy-5,cx-14:cx-5);
    blk2 = thin_img(cy-14:cy-5,cx-4:cx+5);
    blk3 = thin_img(cy-14:cy-5,cx+6:cx+15);
    blk4 = thin_img(cy-4:cy+5,cx-14:cx-5);
    blk5 = thin_img(cy-4:cy+5,cx+6:cx+15);
    blk6 = thin_img(cy+6:cy+15,cx-14:cx-5);
    blk7 = thin_img(cy+6:cy+15,cx-4:cx+5);
    blk8 = thin_img(cy+6:cy+15,cx+6:cx+15);
    s = [sum(sum(blk1)),sum(sum(blk2)),sum(sum(blk3)),sum(sum(blk4)),sum(sum(blk5)),sum(sum(blk6)),sum(sum(blk7)),sum(sum(blk8))];
    for j=1:8
        if s(j)==0
            flag = 1;
        break;
        end
    end
    if flag == 1
        endx(i) = -1;
        endy(i) = -1;
    end
end
a = find(endx == -1);
b = find(endy == -1);
endx(a) = [];
endy(b) = [];
endnum = size(endx,2);
fignum = fignum + 1;
figure(fignum),imshow(thin_img)
hold on
plot(endx, endy, 'go')
plot(brnx, brny, 'ro')
hold off

% points that are too close to each other
for i=1:brnnum-1
    for j=i+1:brnnum
        sqrdis = (brnx(i) - brnx(j))^2+(brny(i) - brny(j))^2;
        if sqrdis<25
            brnx(i) = -1;
            brny(i) = -1;
            brnx(j) = -1;
            brny(j) = -1;
        end
    end
end
a = find(brnx == -1);
b = find(brny == -1);
brnx(a) = [];
brny(b) = [];
brnnum = size(brnx,2);

for i=1:endnum-1
    for j=i+1:endnum
        sqrdis = (endx(i) - endx(j))^2+(endy(i) - endy(j))^2;
        if sqrdis<25
            endx(i) = -1;
            endy(i) = -1;
            endx(j) = -1;
            endy(j) = -1;
        end
    end
end
a = find(endx == -1);
b = find(endy == -1);
endx(a) = [];
endy(b) = [];
endnum = size(endx,2);

for i=1:endnum
    for j=1:brnnum
        sqrdis = (endx(i) - brnx(j))^2+(endy(i) - brny(j))^2;
        if sqrdis<25
            endx(i) = -1;
            endy(i) = -1;
            brnx(j) = -1;
            brny(j) = -1;
        end
    end
end
a = find(endx == -1);
b = find(endy == -1);
endx(a) = [];
endy(b) = [];
endnum = size(endx,2);
c = find(brnx == -1);
d = find(brny == -1);
brnx(c) = [];
brny(d) = [];
brnnum = size(brnx,2);
fignum = fignum + 1;
figure(fignum),imshow(thin_img)
hold on
plot(endx, endy, 'go')
plot(brnx, brny, 'ro')
hold off

            
