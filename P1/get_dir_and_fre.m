function [ dir, fre ] = get_dir_and_fre( abs_block, num )
% ͼ��鷽��
dir = zeros(num, num);
% ��һ�����ͼ���Ƶ��
fre = zeros(num, num);
distance = zeros(num, num);

for i=1:num
    for j=1:num
        [x, y] = sort(abs_block{i, j}(:),'descend');
%         [x1, y1] = ind2sub([32, 32],y(1));
%         [x2, y2] = ind2sub([32, 32],y(2));
%         dir(i,j) = atan((x2-x1)/(y2-y1))+pi/2;
%         distance(i,j) = sqrt((x2-17)^2+((y2-17)^2));
%         fre(i,j) = distance(i,j)/64;
%          if(distance(i,j)>=6)
%             fre(i,j) = -1;
%             dir(i,j) = 0;
%          end 
        for k=1:10
            % ����Ӧ����ȡ����ֵ��ľ���
            % ����Ϊָ��ͼ���Ǳ�׼���Ҳ��Ҵ��ڸ���
            % ����������10�������ҹ���ԭ��ԳƵ�һ��
            % ����Ч��������
            
            % ���ؾ����±�
            [x1, y1] = ind2sub([32, 32],y(k));
            [x2, y2] = ind2sub([32, 32],y(k+1));
            if (abs_block{i,j}(x1,y1)==abs_block{i,j}(x2,y2)&&(x1+x2)/2==17&&(y1+y2)/2==17)
                dir(i,j) = atan((x2-x1)/(y2-y1))+pi/2;
                distance(i,j) = sqrt(((x2-x1)/2)^2+((y2-y1)/2)^2);
                fre(i,j) = distance(i,j)/32;
                if (distance(i,j)>=6)
                    fre(i,j) = -1;
                    dir(i,j) = 0;
                end
                break;
            end
        end
    end
end
% ��ͼƬ'23_2.bmp'�����⴦��
% ͨ�����ο���ȥ���˶���Ҫȥ����ͼƬ�ײ���Ӱ
% ��Ҳ�ᵼ�´��������ͼƬЧ��������������Ľ��
% ���ջ���ѡ����������
if num == 51
    fre(49:51,:) = -1;
end
end

