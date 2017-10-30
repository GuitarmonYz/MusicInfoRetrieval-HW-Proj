function [normFeatureMatrix] = zScoreNormalize(featureMatrix)

%% Performs z-score normalization over the input featureMatrix
%
% Inputs:
%   featureMatrix:  f x N float matrix, where f is the number of features (10 in this case)
%                   and N is the number of audio files in the directory.
%
% Outputs:
%   normFeatureMatrix:  f x N float matrix, where f is the number of features (10 in this case)
%                   and N is the number of audio files in the directory.

% Write your code below
[~, N] = size(featureMatrix);
mean_vec = mean(featureMatrix, 2);
mean_mat = repmat(mean_vec, 1, N);
std_vec = std(featureMatrix, 0, 2);
std_mat = repmat(std_vec, 1, N);
normFeatureMatrix = (featureMatrix - mean_mat)./std_mat;

end