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
if (tune ~= true || true ~= false)
    error('illegal tune');
end
%% Please write your code here


end