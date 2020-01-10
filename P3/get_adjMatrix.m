function  [adj_Matrix, adj_idx] = get_adjMatrix(L)
    [rows,cols] = size(L);
    % the number of labels
    labels = setdiff(unique(L(:))',0);
    N = max(labels); 
    % set connectivity=8
    i = zeros(rows*cols,1);  
    j = zeros(rows*cols,1); 
    v = zeros(rows*cols,1);
    cnt = 1;
    for r = 1:rows-1
        for c = 1:cols-1
            i(cnt) = L(r,c); 
            % right
            j(cnt) = L(r  ,c+1); 
            v(cnt) = 1; 
            cnt=cnt+1;
            i(cnt) = L(r,c);
            % down
            j(cnt) = L(r+1,c  ); 
            v(cnt) = 1; 
            cnt=cnt+1;
        end
    end
    
    adj_Matrix = logical(sparse(i, j, v, N, N)); 
    for diag = 1:N
        % kind of initialize
        adj_Matrix(diag,diag) = 0;
    end
    % symmetrical matrix
    adj_Matrix = adj_Matrix | adj_Matrix';
    
    adj_idx = cell(N,1);
    for r = 1:N
        adj_idx{r} = find(adj_Matrix(r,:));
    end
    end
    