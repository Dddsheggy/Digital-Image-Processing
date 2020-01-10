function [samples_cluster,centers] = applyKmeans(samples_res,k)
% apply kmeans algorithm to cluster all pixels into k classes.
% input are the samples responses and class numbers 
% output are the samples cluster result and kmeans centers
% personnally I recommand function 'kmeans', you can learn how 
% to use it by 'doc kmeans' or 'help kmeans'
opts = statset('Display','off','MaxIter',2000);
[samples_cluster,centers]=kmeans(samples_res,k,'Options',opts);

% replace it with your implementation
% samples_cluster = [];
% centers = [];