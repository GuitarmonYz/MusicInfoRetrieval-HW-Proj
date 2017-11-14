function [sel_feature_set, accuracy_seq, conf_mat] = myForwardSelection(data, labels, K, num_folds, req_plot) 

%% Implements your forward selection procedure
% 
% Input:
%   data:               num_features x num_data_points matrix, containing the data features
%   labels:             1 x num_data_points matrix, containing the data labels
%   K:                  int, parameter for the kNN classifier
%   num_folds:          int, parameter for the number of folds for cross validation
%   req_plot:           bool, plots the best accuracy v/s iteration number if TRUE, no plots if FALSE
% Output:
%   sel_feature_set:    1 x num_features vector, containing the indices of the selected features 
%   accuracy_seq:       1 x num_features vector, containing the accuracies at each feature selection step
%   conf_mat:           num_classes x num_classes matrix, confusion matrix for the final selected feature set           
% Hint:
%   Here, at iteration of the feature selection process, you need to  run a cross-validation with 
%   num_folds. Use the average accuracy to determine which feature to select. Ideally you should stop
%   the iteration process when the accuracy drops below a certain threshold compared to previous 
%   iteration. But to keep things simple, we ask you to perform iterations till you all exhaust all
%   available features here.           

%% Add your code here
[num_features, ~] = size(data);
features = (1:num_features);
accuracy_seq = zeros(1, num_features);
sel_feature_set = [];
itr_sel_feature_set = [];
global_best = 0;
j = 1;
while ~isempty(features)
    best_accuracy = 0;
    feature_sel = -1;
    local_sel_feature_set = [];
    for i = 1 : length(features)
        tmp_sel_feature_set = [itr_sel_feature_set,features(i)];
        [avg_accuracy, ~, local_conf_mat] =myCrossValidation(data(tmp_sel_feature_set,:), labels, K, num_folds);
        if best_accuracy < avg_accuracy
            feature_sel = features(i);
            best_accuracy = avg_accuracy;
            local_sel_feature_set = tmp_sel_feature_set;
            local_max_conf_mat = local_conf_mat;
        end
    end
    itr_sel_feature_set = local_sel_feature_set;
    features(features == feature_sel) = [];
    accuracy_seq(j) = best_accuracy;
    if best_accuracy > global_best
        global_best = best_accuracy;
        sel_feature_set = local_sel_feature_set;
        conf_mat = local_max_conf_mat;
    end
    j = j + 1;
end
if req_plot 
    plot(accuracy_seq);
end
end