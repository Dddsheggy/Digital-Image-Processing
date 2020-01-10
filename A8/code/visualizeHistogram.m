function visualizeHistogram(samples_hist,k)
% visualize histogram result of the samples
for i=1:5
    figure(2),subplot(2,3,i),
    histogram('BinEdges',0:1:k,'BinCounts',samples_hist(:,i));
end