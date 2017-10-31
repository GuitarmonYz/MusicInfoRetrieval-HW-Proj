tuning_eval = './data/tuning_eval/';
key_eval = './data/key_eval/';
avgDeviation = myEvaluateTF(strcat(tuning_eval,'audio/'),strcat(tuning_eval,'GT/'));
accuracy = myEvaluateKD(strcat(key_eval,'audio/'),strcat(key_eval,'GT/'));