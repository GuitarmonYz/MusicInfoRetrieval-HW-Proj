function [r] = myCompAcfMod (inputVector)
%% compute acf using fft
% inputVector: N * 1
    len = length(inputVector);
    inputVector = [inputVector ; zeros(len-1, 1)];
    r = ifft(fft(inputVector) .* conj(fft(inputVector)));
    r = r(1:len);
end
