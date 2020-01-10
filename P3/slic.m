
function [L, info, L1, L2,info1,info2] = slic(img, k, m, adjRadius,itr_num)
% ----------------------------------input------------------------------------------
% img: original image
% k: desired number of clusters
% m: weighting factor between color and spatial differences
% adjRadius: regions smaller than this will be merged with adjacent
% regions(has to >= 1)
% itr_num: for iteration(fixed number of iterations instead of computing
% error to decide when to stop)
% ----------------------------------output------------------------------------------
% L: labeled image of superpixels
% N: real number of pixels 
    [rows, cols, chan] = size(img);
    % change type
    img = rgb2lab(img);
    % get S
    S = sqrt(rows*cols / k);
    col_nodes = round(cols/S - 0.5);
    % update S
    S = cols/(col_nodes + 0.5); 
    row_nodes = round(rows/S);
    len = rows/row_nodes;
    % update k
    k = row_nodes * col_nodes;
    % save infomation of every cluster center
    % 1:3  mean_L,mean_a,mean_b
    % 4:5  col and row index
    % 6     the number of pixels
    C = zeros(6,k); 
    % initialize labeled image
    L = -ones(rows, cols);
    % initialize distance matrix
    d = inf(rows, cols);

    cnt = 1;
    r = len/2;  
    for ri = 1:row_nodes
        c=S/2;
        for ci = 1:col_nodes
            cc = round(c); rr = round(r);
            C(1:5, cnt) = [squeeze(img(rr,cc,:)); cc; rr];
            c = c+S;
            cnt = cnt+1;
        end       
        r = r+len;
    end
    % start iteration  
    S = round(S);    
    for n= 1:itr_num
       for cnt = 1:k 
           rmin = max(C(5,cnt)-S, 1); 
           rmax = min(C(5,cnt)+S, rows);
           cmin = max(C(4,cnt)-S, 1); 
           cmax = min(C(4,cnt)+S, cols); 
           small_img = img(rmin:rmax, cmin:cmax, :); 
           % update distance
           D = get_distance(C(:, cnt), small_img, rmin, cmin, S, m);
           small_d =  d(rmin:rmax, cmin:cmax);
           small_L =  L(rmin:rmax, cmin:cmax);
           new_mask = D < small_d;
           small_d(new_mask) = D(new_mask);
           small_L(new_mask) = cnt;   
           
           d(rmin:rmax, cmin:cmax) = small_d;
           L(rmin:rmax, cmin:cmax) = small_L;           
       end
       % update cluster info
       C(:) = 0;
       for rr = 1:rows
           for cc = 1:cols
              tmp_C = [img(rr,cc,1); img(rr,cc,2); img(rr,cc,3); cc; rr; 1];
              C(:, L(rr,cc)) = C(:, L(rr,cc)) + tmp_C;
           end
       end
       % get mean values
       for cnt = 1:k 
           C(1:5,cnt) = round(C(1:5,cnt)/C(6,cnt)); 
       end
    if itr_num==10 && n==2
        L1=L;
    end
    if itr_num==10 && n==5
        L2=L;
    end
    
    if itr_num==5 && n==1
        L1=L;
    end
    if itr_num==5 && n==3
        L2=L;
    end
    
    if itr_num==20 && n==5
        L1=L;
    end
    if itr_num==20 && n==15
        L2=L;
    end
    end
    % handle samll regions which scaterred in different backgrounds
    L = handle_small_regions(L, adjRadius);
    N = max(L(:));
    info=zeros(2,N);
    [X,Y] = meshgrid(1:cols, 1:rows);   
    for cnt = 1:N
        mask = L==cnt;
        total= sum(mask(:));
        info(1,cnt)=round(sum(Y(mask))/total);
        info(2,cnt)=round(sum(X(mask))/total);
    end

    N1 = max(L1(:));
    info1=zeros(2,N1);
    [X,Y] = meshgrid(1:cols, 1:rows);   
    for cnt = 1:N1
        mask = L1==cnt;
        total= sum(mask(:));
        info1(1,cnt)=round(sum(Y(mask))/total);
        info1(2,cnt)=round(sum(X(mask))/total);
    end
    
    N2 = max(L2(:));
    info2=zeros(2,N2);
    [X,Y] = meshgrid(1:cols, 1:rows);   
    for cnt = 1:N2
        mask = L2==cnt;
        total= sum(mask(:));
        info2(1,cnt)=round(sum(Y(mask))/total);
        info2(2,cnt)=round(sum(X(mask))/total);
    end


function D = get_distance(C, im, r1, c1, S, m)
    [rows, cols,chan] = size(im);
    [x,y] = meshgrid(c1:(c1+cols-1), r1:(r1+rows-1));
    x = x-C(4); 
    y = y-C(5);
    ds2 = x.^2 + y.^2;
    for n = 1:3
        im(:,:,n) = (im(:,:,n)-C(n)).^2;
    end
    dc2 = sum(im,3);
    D = sqrt(dc2 + ds2/S^2*m^2);
    