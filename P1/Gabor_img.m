function [ better_img ] = Gabor_img( better_fre, zeroed_img, s, Gabor_block)
Wg = 11;
better_img = zeros(s-2, s-2);
for i=1:s-2
    for j=1:s-2
        if(better_fre(floor((i+6)/7),floor((j+6)/7))>0)
            a = zeroed_img(i+13-floor(Wg/2):i+13+floor(Wg/2),j+13-floor(Wg/2):j+13+floor(Wg/2)).*Gabor_block{floor((i+6)/7),floor((j+6)/7)};
            better_img(i,j) = sum(sum(a));
        else
            better_img(i,j)=255;
        end
    end
end

end

