function [L] = handle_small_regions(L, adjRadius)
% orphaned regions smaller than the size computed by adjRadius will be
% relabeled
    se=strel('disk',adjRadius);   
    mask = zeros(size(L));
    list = find_disconnect(L);
    for cnt = 1:length(list)
        b = zeros(size(L));
        for m = 1:length(list{cnt})
            b = b | L == list{cnt}(m);
        end
        mask = mask | (b - imopen(b,se));
    end
    [~, idx] = bwdist(~mask);
    L(mask) = L(idx(mask));
    L=update_L(L);
    