%% The entry function to get all features
%% set hyper params
blockSize = 4096;
hopSize = 2048;
fs = 44100;
%% prepare trainning data
train_audio_path = './trainSet/audio/*.wav';
train_annotation_path = './trainSet/annotation/Fender Strat Clean Neck SC.csv';
[train_data, train_GT] = getTrainData(train_audio_path, train_annotation_path, blockSize, hopSize, fs);
%% prepare testing data
test_audio_path = './testSet/audio/*.wav';
test_annotation_path = './testSet/annotation/*.csv';
[ testData, ~, trueVal ] = getTestData( test_audio_path, test_annotation_path, blockSize, hopSize, fs);