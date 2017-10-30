function [mean_, var_, skew_, max_, min_] = getStatistics( sample )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
mean_ = mean(sample);
var_ = var(sample);
skew_ = skewness(sample);
max_ = max(sample);
min_ = min(sample);
end

