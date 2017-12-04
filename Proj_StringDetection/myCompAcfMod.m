function [r] = myCompAcfMod (inputVector)
    len = length(inputVector);
    inputVector = [inputVector ; zeros(len-1, 1)];
    r = ifft(fft(inputVector) .* conj(fft(inputVector)));
    r = r(1:len);
end
