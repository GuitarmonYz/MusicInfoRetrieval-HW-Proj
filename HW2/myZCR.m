function [zcr] = myZCR(xb)

%% Audio Feature: Zero-Crossing Rate
% This function extracts the zero-crossing rate for each block of audio
% in the input matrix xb.
% input: 
%   xb:     (blockSize x numBlocks) float matrix, where numBlocks is 
%           the number of blocks
% output: 
%   specCrest:(1 x numBlocks) float array, the resulting feature value per block

%% Write your code below:
zcr = mean(abs(diff(sign(xb))));
end