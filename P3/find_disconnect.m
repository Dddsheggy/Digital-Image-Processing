function [list] = find_disconnect(L)
% find disconnected groups of superpixel regions
% adj_matrix(i,j) means whether region labeled as i and region labeled as j are
% connected
% adj_idx{n} is an array of the region indices adjacent to region labeled as n.
    [adj_matrix, adj_idx] = get_adjMatrix(L);
%  the number of labels
    N = max(L(:));
% whether this label region has been visited
    visited = zeros(N,1);
    list = {};
    listnum= 0;
    for cnt = 1:N
        if ~visited(cnt)
            listnum = listnum + 1;
            list{listnum} = cnt;
            visited(cnt) = 1;
            % regions that are not visited but disconnected with current
            % one
            no_connection = setdiff(find(~adj_matrix(cnt,:)), find(visited));
            for m = no_connection
                if isempty(intersect(adj_idx{m}, list{listnum}))
                    list{listnum} = [list{listnum} m];
                    visited(m) = 1;
                end
            end
        end
    end
    