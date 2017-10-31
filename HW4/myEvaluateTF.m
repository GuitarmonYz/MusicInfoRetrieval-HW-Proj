function [avgDeviation] = myEvaluateTF(pathToAudio, pathToGT)

%% Evaluates the tuning frequency estimation algorithm
% Input:
%   pathToAudio:    string, path to audio files
%   pathToGT:       string, path to ground truth text files
% Output:
%   avgDeviation:   average absolute deviation (in cents) of tuning frequency
%                   from A440 equally tempered scale for all the files in audio
%                   directory.

%% Please write your code here
blockSize = 4096;
hopSize = 2048;
fs = 44100;
audio_list = dir(strcat(pathToAudio,'*.wav'));
gt_list = dir(strcat(pathToGT,'*.txt'));
total_deviation = 0;
for i = 1 : length(audio_list)
   test_audio = audioread(strcat(pathToAudio,audio_list(i).name));
   gt = textread(strcat(pathToGT, gt_list(i).name));
   tf_estimate = myTuningFrequencyEstimate(test_audio, blockSize, hopSize, fs);
   total_deviation = total_deviation + abs(tf_estimate - gt);
end

avgDeviation = total_deviation / length(audio_list);

end