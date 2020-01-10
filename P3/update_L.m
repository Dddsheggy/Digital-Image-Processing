function [L1] = update_L(L)
    L1 = L;
    labels = unique(L(:))'; 
    if labels(1) == 0
        labels = labels(2:end);
    end
    cnt = 1;
    for n = labels
        L1(L==n) = cnt;
        cnt = cnt+1;
    end
    