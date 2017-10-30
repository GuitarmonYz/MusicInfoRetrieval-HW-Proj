function [f0, timeInSec] = myPitchTrackMod(x, blockSize, hopSize, fs)

%% Blockwise Pitch Tracking based on a modified approach
% Input:
%   x:          (N x 1) float vector, input signal
%   blockSize:  int, block size of the blockwise process
%   hopSize:    int, hop size of the blockwise process
%   fs:         float, sample rate in Hz
% Output:
%   f0:         (numBlocks x 1) float vector, detected pitch (Hz) per block
%   timeInSec:  (numBlocks x 1) float vector, time stamp (sec) of each block

% Check input dimensions 
[~,n] = size(x);
if (n>1)
    error('illegal input signal');
end
[m,n] = size(blockSize);
if (m ~= 1 && n ~=1)
    error('illegal blockSize');
end
[m,n] = size(hopSize);
if (m ~= 1 && n ~=1)
    error('illegal hopSize');
end
[m,n] = size(fs);
if (m ~= 1 && n ~=1)
    error('illegal fs');
end

%% Please write your code here
len_x = length(x);
N = ceil(len_x/hopSize);
pad_size = N * blockSize - len_x;
x = [x;zeros(pad_size, 1)];
timeInSec = zeros(N,1);
hop_length = hopSize/fs;
f0 = zeros(N,1);
for i = 1:N
     r = myCompAcfMod(x((i-1)*hopSize+1:(i-1)*hopSize+blockSize));
     r_smoothed = filter(128,1,r);
     f0(i) = myGetF0FromAcfMod(r_smoothed, fs);
     timeInSec(i) = hop_length * (i-1);
end


end