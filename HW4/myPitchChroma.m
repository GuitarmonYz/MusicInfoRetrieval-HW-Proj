function [pitchChroma] = myPitchChroma(X, fs, tf)

%% Compute the pitch chroma for an incoming spectrogram

%   X:          frequencyBins*numBlocks float matrix, input magnitude
%               spectrogram
%   fs:         float, sampling rate in Hz
%   tf:         float, tuning frequency deviation from equitempered scale.
%               this is used for adjusting the semi-tone bins.
% Output:
%   pitchChroma:(12 x numBlocks) float matrix

% Check input dimensions 
[m,n] = size(X);
if (m == 1 || n==1)
    error('illegal input spectrogram');
end
[m,n] = size(fs);
if (m ~= 1 && n ~=1)
    error('illegal fs');
end
[m,n] = size(tf);
if (m ~= 1 && n ~=1)
    error('illegal tf');
end

%% Please write your code here
[blockSize, numBlocks] = size(X);
numOctives = 3;
H = zeros(12, numBlocks);
for i = 1 : 12
    bounds = [2^(-1/24), 2^(1/24)] * f_mid * 2 * blockSize/fs;
    for j = 1 : numOctives
        tmp_bounds = [ceil(2^(j-1)*bounds(1)), floor(2^(j-1)*bounds(2))];
        H(i, tmp_bounds(1):tmp_bounds(2)) = 1/(tmp_bounds(2)+1-tmp_bounds(1));
    end
    f_mid = f_mid * 2^(1/12);
end
end