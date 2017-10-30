function [f0] = myGetF0FromAcf(acfVector, fs)

%% Computes the pitch for a block of audio from the ACF vector
% Input:
%   acfVector:  (blockSize x 1) float vector, ACF of a block
%   fs:         float, sampling rate in Hz
% Output:
%   f0:         float, fundamental frequency of the block in Hz  

% check input dimensions
[~, n] = size(acfVector);
if (n>1)
    error('illegal input acfVector');
end
[m,n] = size(fs);
if (m ~= 1 && n ~=1)
    error('illegal fs');
end


%% Please insert your code here
diff_vec = diff(acfVector);
t_init = 0;
y_init = 0;
for i = 2 : length(diff_vec)
    if diff_vec(i-1) >= 0 && diff_vec(i) < 0
        if acfVector(i) > y_init
            t_init = i;
            y_init = acfVector(i);
        end
    end
end
f0 = fs/(t_init-1);
% if tmp_f0>=85 && tmp_f0<1100
%     f0 = tmp_f0;
% else
%     f0 = 0;

end
