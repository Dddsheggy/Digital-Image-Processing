function visualizeSamples(samples_cluster)
% visualize the samples result
m=480;
n=640;
for i = 1:5
    tmp = samples_cluster((i-1)*m*n+1:i*m*n);
    tmp1 = reshape(tmp,[m n]);
    pic = label2rgb(tmp1);
    figure(1),subplot(2,3,i),imshow(pic),title(['Type',num2str(i)]);
end