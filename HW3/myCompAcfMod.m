function [r] = myCompAcfMod (inputVector)

%% Please insert your ACF computation code here
% r = zeros(2*length(inputVector)-1,1);
len = length(inputVector);
inputVector = [inputVector ; zeros(len-1, 1)];
r = ifft(fft(inputVector) .* conj(fft(inputVector)));
r = r(1:len);
end
