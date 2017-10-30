function [f0, timeInSec] = myPitchTrackMax(x, blockSize, hopSize, fs)

%% Blockwise Pitch Tracking based on Maximum Spectrum approach
% Input:
%   x:          (N x 1) float vector, input signal
%   blockSize:  int, block size of the blockwise process
%   hopSize:    int, hop size of the blockwise process
%   fs:         float, sample rate in Hz
% Output:
%   f0:         (numBlocks x 1) float vector, detected pitch (Hz) per block
%   timeInSec:  (numBlocks x 1) float vector, time stamp (sec) of each block


%% Please write your code here. Follow the steps as per the comments
% first block the audio and get the time-stamps per block (myBlockAudio)
[xb, timeInSec] = myBlockAudio(x,blockSize,hopSize,fs);
% compute the magnitude spectrogram (myComputeSpectrogram)
[blockSize, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);
% compute f0 for each block by looking at the maximum of the spectrum of each block
[~, idx] = max(X);
f0 = binFreqs(idx)';
end