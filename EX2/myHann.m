function w = myHann(blockSize)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
w = zeros(blockSize,1);
for i = 1:blockSize
    w(i) = 0.5*(1 - cos((2*pi*i)/(blockSize - 1)));
end
end

