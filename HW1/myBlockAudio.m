function [xb, timeInSec] = myBlockAudio(x, blockSize, hopSize, fs)

%% Blocks the input audio signal into overlapping buffers
% Input:
%   x:          N*1 float vector, input signal
%   blockSize:  int, size of each block
%   hopSize:    int, hop size
%   fs:         float, sampling rate in Hz
% Output:
%   xb:         (blockSize x numBlocks) float matrix, where numBlocks is 
%               the number of blocks
%   timeInSec:  (numBlocks x 1) float vector, time stamp (sec) of each block   
% Note:
%   1)  numBlocks depends on the length of the audio, zeropadding may be needed

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
% N = ceil((len_x - blockSize)/hopSize)+1;
N = ceil(len_x/hopSize);
pad_size = N * blockSize - len_x;
x = [x;zeros(pad_size, 1)];
xb = zeros(blockSize, N);
timeInSec = zeros(N,1);
hop_length = hopSize/fs;
for i = 1:N
     xb(:,i) = x((i-1)*hopSize+1:(i-1)*hopSize+blockSize);
     timeInSec(i) = hop_length * (i-1);
end




end