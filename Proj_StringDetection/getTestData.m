function [ testData, featureMatrix_test, trueVal_cat ] = getTestData( audio_path, annotation_path, blockSize, hopSize, fs )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
numberOfPartials = 6;
audio_list = dir(audio_path);
annotation_list = dir(annotation_path);
featureMatrix_test = zeros(numberOfPartials*2+2, 13*length(audio_list));
trueVal = zeros(13*length(audio_list),1);
for i = 1 : length(audio_list)
    test_audio = audioread(strcat('./testSet/audio/',audio_list(i).name));
    disp(audio_list(i).name);
    annotation_matrix = csvread(strcat('./testSet/annotation/',annotation_list(i).name));
    disp(annotation_list(i).name);
    onSet = annotation_matrix(:,2);
    offSet = annotation_matrix(:,3);
    stringNum = annotation_matrix(:,5);
    trueVal((i-1)*13+1:i*13) = stringNum(1:13);
    for j = 1 : 13
        onSet_sample = round(onSet(j)*fs);
        offSet_sample = round(offSet(j)*fs);
        single_note = test_audio(onSet_sample:offSet_sample);
        featureVector = getFeaturesTest(single_note, blockSize, hopSize, fs, numberOfPartials);
        featureMatrix_test(:,(i-1)*13+j) = featureVector;
    end
end
beta = featureMatrix_test(1,:);
featureMatrix_test(:,beta>3) = [];
trueVal(beta > 3) = [];
first_rel = featureMatrix_test(2,:);
featureMatrix_test(:,first_rel > 10) = [];
trueVal(first_rel > 10) = [];

% featureMatrix_test = featureMatrix_test./max(featureMatrix_test, 2);

trueVal_cat = categorical(trueVal);
% featureMatrix_norm = zScoreNormalize(featureMatrix_test);

testData = table(trueVal_cat, featureMatrix_test');

end

