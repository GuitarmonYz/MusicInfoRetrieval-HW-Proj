load('data/data.mat');
load('data/labels.mat');
%% B.2
% param init
numClasses = 5;
K = 3;
num_folds = 3;
bestFeature = 0;
bestAccuracy = 0;
% test feature performance individually
for i = 1 : numClasses
    [avg_accuracy, ~, ~] = myCrossValidation(data(i,:), labels, K, num_folds);
    if avg_accuracy > bestAccuracy
        bestAccuracy = avg_accuracy;
        bestFeature = i;
    end
end
%% C.2
[~,accuracy_seq] = myForwardSelection(data, labels, K, num_folds, false);