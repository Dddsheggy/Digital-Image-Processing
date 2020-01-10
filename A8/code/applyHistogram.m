function samples_hist = applyHistogram(samples_cluster,k)
% apply histogram for each image in the sample
% input is the sample
% output is the histogram result
m=480;
n=640;
cnt=size(samples_cluster,1)/(m*n);
samples_hist=zeros(k,cnt);
for i=1:cnt
    tmp=tabulate(samples_cluster((i-1)*m*n+1:i*m*n,:));
    tmp=sortrows(tmp(:,1:2),1);
    tmp=tmp(:,2);
    samples_hist(:,i)=tmp;
end
% replace it with your implementation
% samples_hist = [];