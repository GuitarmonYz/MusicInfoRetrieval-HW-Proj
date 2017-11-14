function [ accuracy, conmat ] = myAccuracyAndConmat( true_labels, est_labels )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    conmat = confusionmat(est_labels, true_labels);
    accurate = length(true_labels(true_labels == est_labels));
    accuracy = accurate / length(true_labels);
end

