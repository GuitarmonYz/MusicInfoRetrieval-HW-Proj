function [tf] = myTuningFrequencyEstimate(x, blockSize, hopSize, fs)

%% Estimate the tuning frequency of an input music signal
% Input:
%   x:          N*1 float vector, input signal
%   blockSize:  int, size of each block
%   hopSize:    int, hop size
%   fs:         float, sampling rate in Hz
% Output:
%   tf:         deviation of tuning frequency from A440 equally tempered
%               scale in cents.

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
f_ref = 440;
[xb, ~] = myBlockAudio(x, blockSize, hopSize, fs);
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
deviation = zeros(20 * numBlocks,1);
for i = 1 : numBlocks
    x_block_sig = xb(:,i);
    spectralPeaks = mySpectralPeaks(x_block_sig);
    spectralPeaks_Hz = spectralPeaks./blockSize*fs/2;
    pitch_midi = 69 + 12 * log2(spectralPeaks_Hz/f_ref);
    deviation((i-1)*20+1:i*20) = abs(pitch_midi - round(pitch_midi))*100;
end
set_deviation = unique(deviation);       
sort_deviation = sort(deviation);
hist = zeros(size(set_deviation));
for i = 1:length(set_deviation)
    hist(i) = sum(sort_deviation == set_deviation(i));
end
% hist = sum(sort_deviation == set_deviation');
hist = sort(hist);
tf = hist(end);
end