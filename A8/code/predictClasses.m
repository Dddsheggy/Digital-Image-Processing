function test_samples_cluster = predictClasses(test_samples_res,centers)
% predict the class of each pixel for all images responses in the sample according to
% the kmeans centers.
% inputs are the images responses sample and kmeans centers
% output is the cluster result of the sample
% personnally I recommend function 'pdist2', you can learn how to use it
% by 'doc pdist2' or 'help pdist2'
[D,Class]=pdist2(centers,test_samples_res,'euclidean','Smallest',1);
test_samples_cluster=Class';
% replace it with your implementation
% test_samples_cluster = [];