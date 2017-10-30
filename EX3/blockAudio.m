function xb = blockAudio(x, blockSize, hopSize)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
len_x = length(x);
N = ceil((length(x) - blockSize)/hopSize)+1;
pad_size = N * blockSize - len_x;
x = [x;zeros(pad_size, 1)];
xb = zeros(N, blockSize);
for i = 1:N-1
     xb(i,:) = x((i-1)*hopSize+1:(i-1)*hopSize+blockSize);
end
end

