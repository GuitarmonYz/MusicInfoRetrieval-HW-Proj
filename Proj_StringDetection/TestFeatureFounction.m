blockSize = 2048;
hopSize = 1024;
fs = 44100;
% test = audioread('audio/G53-55305-1111-00032.wav');
% featureMatrix = getFeatures(test, blockSize, hopSize, fs);

%% prepare trainning data
% train_audio_path = './trainSet/audio/*.wav';
% train_annotation_path = './trainSet/annotation/Fender Strat Clean Neck SC.csv';
% train_data = getTrainData(train_audio_path, train_annotation_path, blockSize, hopSize, fs);
%% prepare testing data
test_audio_path = './testSet/audio/*.wav';
test_annotation_path = './testSet/annotation/*.csv';
[ testData, featureMatrix_test, trueVal ] = getTestData( test_audio_path, test_annotation_path, blockSize, hopSize, fs);
