function [specFlux] = mySpectralFlux(xb)

%% Audio Feature: Spectral Flux
% This function extracts the spectral flux for each block of audio
% in the input matrix xb.
% input: 
%   xb:     (blockSize x numBlocks) float matrix, where numBlocks is 
%           the number of blocks
% output: 
%   specFlux:(1 x numBlocks) float array, the resulting feature value per block

%% Write your code below:
[blockSize, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
fft_xb = abs(fft(xb));
fft_xb = fft_xb((1:blockSize/2),:);
deltx_xn = diff([fft_xb(:,1), fft_xb], 1, 2);
specFlux = sqrt(sum(deltx_xn.^2))/size(fft_xb, 1);
end