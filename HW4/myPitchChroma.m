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
[fftLength, ~] = size(X);
numOctives = 3;
f_mid = 440 * 2^((48-69+tf)/12);
H = zeros(12, fftLength);
for i = 1 : 12
    bounds = [2^(-1/24), 2^(1/24)] * f_mid * 2 * (fftLength-1)/fs;
    for j = 1 : numOctives
        bin_bounds = [ceil(2^(j-1)*bounds(1)), floor(2^(j-1)*bounds(2))];
        H(i, bin_bounds(1):bin_bounds(2)) = 1/(bin_bounds(2)+1-bin_bounds(1));
    end
    f_mid = f_mid * 2^(1/12);
end
pitchChroma = H * X.^2;
pitchChroma = pitchChroma ./ repmat(sum(pitchChroma,1), 12, 1);
end