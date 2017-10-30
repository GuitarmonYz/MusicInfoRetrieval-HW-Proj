function [f0] = myPitchTrackAcf(xb, fs)

%% Blockwise Pitch Tracking based on ACF
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
% [xb, timeInSec] = myBlockAudio(x, blockSize, hopSize, fs);
[~,numBlock] = size(xb);
f0 = zeros(numBlock,1);
for i = 1:numBlock
% compute the ACF for each block (myCompAcf)
    r = myCompAcfMod(xb(:,i));
    r_smoothed = filter(128,1,r);
    f0(i) = myGetF0FromAcfMod(r_smoothed, fs);
end
end