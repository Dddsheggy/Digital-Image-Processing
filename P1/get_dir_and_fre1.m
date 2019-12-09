function [ dir, wav, mask, fre ] = get_dir_and_fre1( DFT_img, m1, n1, mask, kernel, para)
dir = zeros(m1,n1);
wav = zeros(m1, n1);
fre = zeros(m1, n1);
kernel = IBF( 3, 6 );

for i = 1:m1
    for j = 1:n1
        block = DFT_img(32 * (i - 1) + 1:32 * i,32 * (j - 1) + 1:32 * j);
        BW = block .* kernel;
        Amp = sum(sum(BW));
        if Amp > 1.2 && Amp < 1.7
            mask(8 * (i - 1) + 1:8 * i, 8 * (j - 1) + 1:8 * j) = 1;
        end
        [a, b] = sort(BW(:),'descend');
        [c, d] = size(BW);
        for k=1:10
            % ����Ӧ����ȡ����ֵ��ľ���
            % ����Ϊָ��ͼ���Ǳ�׼���Ҳ��Ҵ��ڸ���
            % ����������10�������ҹ���ԭ��ԳƵ�һ��
            % ����Ч��������
            
            % ���ؾ����±�
            [x1, y1] = ind2sub([c, d],b(k));
            [x2, y2] = ind2sub([c, d],b(k+1));
            if (BW(x1,y1)==BW(x2,y2)&&(x1+x2)/2==17&&(y1+y2)/2==17)
                dir(i, j) = atan2((y1 - y2), (x1 - x2));
                R = sqrt(((x2-x1)/2)^2+((y2-y1)/2)^2);
                % ����������ͼƬ��ͬ��Ƶ�ʶ���
                % ����Gabor
                fre(i, j) = R / 32;
                wav(i,j) = 1 / fre(i,j);
            end
            break;
        end
    end
end

% ����mask
% ���ȡ��
mask = imfill(mask ,'holes');
mask = ~mask;
% �������ȡ��
mask = imfill(mask, 'holes');
mask = ~mask;

end

