function [c_labels, centroids] = myKMeansClustering(data, K)

%% Implements a k-means clustering algorithm
% 
% Input:
%   data:           num_features x num_data_points matrix, containing the data features
%   K:              int, parameter for the kNN classifier
% Output:
%   c_labels:       1 x num_data_points vector, containing the cluster label for each of your datapoints
%   centroids:      num_features x K matrix, where each column is one of your cluster centroids

%% Add your code here
[num_features,num_data_points] = size(data);
randidx = randperm(num_data_points);
centroids = data(:,randidx(1:K));
c_labels = (1:num_data_points);
difference = intmax;
while difference >= 1e-5
    for i = 1 : num_data_points
        tmp_point = data(:,i);
        min_dist = intmax;
        for j = 1 : K
            tmp_dist = norm(tmp_point-centroids(:,j));
            if tmp_dist < min_dist
                min_dist = tmp_dist;
                c_labels(i) = j;
            end
        end
    end
    new_centroids = zeros(num_features, K);
    for i = 1 : K
        new_centroids(:,i) = mean(data(c_labels == i),2);
    end
    difference = new_centroids - centroids;
    difference = sum(difference(:));
    centroids = new_centroids;
end
end
