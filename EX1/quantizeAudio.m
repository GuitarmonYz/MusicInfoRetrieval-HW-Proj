function yQuant = quantizeAudio(y, bitDepth )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    yQuant = round(2.^(bitDepth-1) * y)/2.^(bitDepth-1);

end

