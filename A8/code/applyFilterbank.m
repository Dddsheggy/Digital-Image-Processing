function samples_res = applyFilterbank(train_samples,fb)
% apply Filter into the images of the sample,
% input is the images sample and filter bank
% output is the filter respons of the images sample
m=480;
n=640;
data_dir = '..\data';
if (length(train_samples.image)==5)
    str = fullfile(data_dir, 'uiuc_texture','train_data');
else
    str = fullfile(data_dir, 'uiuc_texture','test_data');
end
dim=size(fb,3);
samples_res=zeros(m*n*length(train_samples.image),dim);
for i=1:length(train_samples.image)
    img=imread(fullfile(str,train_samples.image{i}));
    res=zeros(m*n,dim);
    for j=1:dim
        tmp=conv2(img,fb(:,:,j),'same');
        tmp1=tmp(:)';
        res(:,j)=tmp1;
    end
    samples_res((i-1)*m*n+1:i*m*n,:)=res;
end

% replace it with your implementation
% samples_res = [];