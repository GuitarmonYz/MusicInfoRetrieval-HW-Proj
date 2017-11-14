function [est_class] = myKnn(test_data, train_data, train_label, K)

%% Implements a kNN classifier
% 
% Input:
%   test_data:      num_features x num_test_points matrix, containing the test data features
%   train_data:     num_features x num_train_points matrix, containing the train data features
%   train_label:    1 x num_train_points vector, containing the training labels
%   K:              int, parameter for the kNN classifier
% Output:
%   est_class:      1 x num_test_points vector, containing the predicted labels for the test data points

%% Add your code here
[~, num_test_points] = size(test_data);
[~, num_train_points] = size(train_data);
est_class = zeros(1, num_test_points);
for i = 1 : num_test_points
   distances = zeros(1,num_train_points);
   for j = 1 : num_train_points
      distance = norm(train_data(:,j) - test_data(:,i));
      distances(j) = distance;
   end
   [~, idx] = sort(distances);
   k_nearest = idx(1:K);
   label = train_label(k_nearest);
   est_class(i) = mode(label);
end    
end