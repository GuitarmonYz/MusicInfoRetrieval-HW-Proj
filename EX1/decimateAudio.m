function yDec = decimateAudio( y, interdownsample )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    input_size = length(y);
    yDec = zeros(round(input_size/interdownsample), 1);
    for i = 1:interdownsample:input_size
        yDec(i) = y(i);
    end
end

