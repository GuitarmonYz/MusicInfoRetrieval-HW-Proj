function [pfn] = myGetFalseNegatives(estimation, annotation)

%% Computes the percentage of false negatives
% Input:
%   estimation: (numBlocks x 1) float vector, estimated pitch (Hz) per block   
%   annotation: (numBlocks x 1) float vector, annotated pitch (Hz) per block
% Output:
% 	pfn:		float, percentage of false negatives


%% Please insert your code here
non_zero_ann_idx = find(annotation);
estimation =  estimation(non_zero_ann_idx);
estimation = find(~estimation);
pfn = length(estimation)/length(non_zero_ann_idx);
end