function [ train_data ] = getTrainData( audio_path, annotation_path, blockSize, hopSize, fs )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
audio_list = dir(audio_path);
annotation_matrix = csvread(annotation_path);
Y = annotation_matrix(:,5);
Y = repelem(Y,8);
numberOfPartials = 11;
featureMatrix = zeros(2*numberOfPartials+1, length(audio_list)*4);
for i = 1 : length(audio_list)
    disp(audio_list(i).name);
    train_audio = audioread(strcat('./trainSet/audio/',audio_list(i).name));
    featureMatrix_aggregated = getFeatures(train_audio, blockSize, hopSize, fs, numberOfPartials);
    if size(featureMatrix_aggregated,2) ~= 8
        disp('fuck')
    end
    featureMatrix(:,(i-1)*8+1:i*8) = featureMatrix_aggregated; 
end
% featureMatrix_norm = zScoreNormalize(featureMatrix);
beta = featureMatrix(1,:);
featureMatrix(:,beta>3) = [];
Y(beta > 3) = [];
Y_cat = categorical(Y);
train_data = table(Y_cat, featureMatrix');

end

