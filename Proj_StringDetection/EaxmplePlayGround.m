%% use saved model and feature to test
load('train_data');
load('train_GT');
load('testData');
load('test_GT');
load('model');
predict_res_train = trainedClassifier.predictFcn(train_data(:,2));
predict_res_test = trainedClassifier.predictFcn(testData(:,2));
confusionmat(train_GT, predict_res_train)
confusionmat(trueVal, predict_res_test)