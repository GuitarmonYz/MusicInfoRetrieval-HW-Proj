function [spectralPeaks] = mySpectralPeaks(x)

%% Returns the top 20 spectral peak bins in the spectrum of x
% Input:
%   x:              N*1 float vector, input signal
% Output:
%   spectralPeaks:  20*1 float vector, bin indices of spectral peaks

% Check input dimensions 
[~,n] = size(x);
if (n>1)
    error('illegal input signal');
end

%% Please write your code here
fft_x = abs(fft(x));
fft_x = fft_x(1:length(fft_x)/2+1);
[~,indices] = findpeaks(fft_x, 'SortStr', 'descend');
spectralPeaks = indices(1:20);
end