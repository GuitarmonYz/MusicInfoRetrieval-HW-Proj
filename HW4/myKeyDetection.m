function [keyEstimate] = myKeyDetection(x, blockSize, hopSize, fs, tune)

%% Computes the key for the input music signal
% Input:
%   x:          N*1 float vector, input signal
%   blockSize:  int, size of each block
%   hopSize:    int, hop size
%   fs:         float, sampling rate in Hz
%   tune:       boolean, true if tuning frequency correction is to be done,
%               false if no tuning frequency correction is required.
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
[m,n] = size(tune);
if (m ~= 1 && n ~=1)
    error('illegal tune');
end
if (tune ~= true && tune ~= false)
    error('illegal tune');
end
%% Please write your code here
template = [6.35 2.23 3.48 2.33 4.38 4.09 2.52 5.19 2.39 3.66 2.29 2.88; 6.33 2.68 3.52 5.38 2.60 3.53 2.54 4.75 3.98 2.69 3.34 3.17];
keyMajor  = char ('C Maj','C# Maj','D Maj','D# Maj','E Maj','F Maj', 'F# Maj','G Maj','G# Maj','A Maj','A# Maj','B Maj');
keyMinor  = char ('c min','c# min','d min','d# min','e min','f min', 'f# min','g min','g# min','a min','a# min','b min');
% normalize template
template    = diag(1./sum(template,2))*template;
[X, ~, ~] = spectrogram(x, hann(blockSize), blockSize - hopSize, blockSize, fs);
% get magnitude spectrum
X = abs(X)*2/blockSize;
% init tune freq deviation
tf = 0;
if tune == true
    tf = myTuningFrequencyEstimate(x, blockSize, hopSize, fs);
end
pitch_chroma = myPitchChroma(X, fs, tf);
pitch_chroma = mean(pitch_chroma, 2);
distance = zeros(2,12);
for i = 0:11
%     calculate L2 distance for each cirshift
    distance(:,i+1) = sqrt(sum((repmat(pitch_chroma',2,1)-circshift(template,[0 i])).^2,2));
end
[dist,keyIdx]  = min(distance,[],2);
if (dist(1) < dist(2))
    keyEstimate    = deblank(keyMajor(keyIdx(1),:));
else
    keyEstimate    = deblank(keyMinor(keyIdx(2),:));
end 
end