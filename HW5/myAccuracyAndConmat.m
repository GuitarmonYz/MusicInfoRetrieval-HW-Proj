function [ accuracy, conmat ] = myAccuracyAndConmat( true_labels, est_labels )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    num_classes = 5;
    conmat = zeros(num_classes, num_classes);
    accurate = 0;
    for i = 1 : length(true_labels)
       conmat(est_labels(i),true_labels(i)) = conmat(est_labels(i),true_labels(i)) + 1;
       if (true_labels(i) == est_labels(i))
           accurate = accurate + 1;
       end
    end
    accuracy = accurate / length(true_labels);
end

