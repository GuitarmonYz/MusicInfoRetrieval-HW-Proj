function [pfp] = myGetFalsePositives(estimation, annotation)

%% Computes the percentage of false positives
% Input:
%   estimation: (numBlocks x 1) float vector, estimated pitch (Hz) per block   
%   annotation: (numBlocks x 1) float vector, annotated pitch (Hz) per block
% Output:
% 	pfp:		float, percentage of false positives


%% Please insert your code here
zero_ann_idx = find(~annotation);
estimation = estimation(zero_ann_idx);
estimation = find(estimation);
pfp = length(estimation) / length(zero_ann_idx);
end