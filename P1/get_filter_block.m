function [ Gabor_block ] = get_filter_block( better_fre, dir, Wg, num )
Gabor_block = cell(num, num);
for i=1:num
    for j=1:num
        newdir = pi/2 - dir(i,j);
        newfre = better_fre(i,j);
        if newfre <= 0
            Gabor_block{i,j}=zeros(Wg, Wg);
        else
            Gabor_block{i,j}=filter_Gabor(newdir, newfre, floor(Wg/2));
        end
    end
end

end

