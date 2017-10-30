function [specCrest] = mySpectralCrest(xb)

%% Audio Feature: Spectral Crest
% This function extracts the spectral crest for each block of audio
% in the input matrix xb.
% input: 
%   xb:     (blockSize x numBlocks) float matrix, where numBlocks is 
%           the number of blocks
% output: 
%   specCrest:(1 x numBlocks) float array, the resulting feature value per block

%% Write your code below:
[blockSize, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
fft_xb = abs(fft(xb));
fft_xb = fft_xb((1:blockSize/2),:);
specCrest = (max(fft_xb,[],1))./sum(fft_xb,1);
end