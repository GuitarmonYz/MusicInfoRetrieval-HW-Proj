function rms = myRMS(xb)

%% Audio Feature: Root Mean Square energy
% This function extracts the RMS energy for each block of audio
% in the input matrix xb.
% input: 
%   xb:     (blockSize x numBlocks) float matrix, where numBlocks is 
%           the number of blocks
% output: 
%   maxEnv:(1 x numBlocks) float array, the resulting feature value per block

%% Write your code below:
rms = sqrt(mean(xb.^2));
end