function Xb = compMagSpectrum (xb)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[N, block_size] = size(xb);
% N = length(xb(:,1));
% block_size = length(xb(1,:));
Xb = zeros(N, ceil(block_size/2));
H_win = myHann(block_size);
for i = 1:N
    tmp_xb = xb(i,:) .* H_win.';
    tmp_freq_spec = abs(fft(tmp_xb)) * (2/block_size);
    Xb(i,:) = tmp_freq_spec(1:ceil(block_size/2));
end

end

