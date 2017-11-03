function [accuracy] = myEvaluateKD(pathToAudio, pathToGT)

%% Evaluates the tuning frequency estimation algorithm
% Input:
%   pathToAudio:    string, path to audio files
%   pathToGT:       string, path to ground truth text files
% Output:
%   avgDeviation:   accuracy of key detection algorithm for the audio files
%                   in the audio directory

%% Please write your code here
blockSize = 4096;
hopSize = 2048;
fs = 44100;
audio_list = dir(strcat(pathToAudio,'*.au'));
gt_list = dir(strcat(pathToGT,'*.txt'));
num_correct_tune = 0;
num_correct_untune = 0;
key_major = char('A','A#','B','C','C#','D','D#','E','F','F#','G','G#');
key_minor = char('a','a#','b','c','c#','d','d#','e','f','f#','g','g#');
for i = 1 : length(audio_list)
   test_audio = audioread(strcat(pathToAudio, audio_list(i).name));
   gt = textread(strcat(pathToGT, gt_list(i).name));
   key_estimate_tune = myKeyDetection(test_audio, blockSize, hopSize, fs, true);
   key_estimate_untune = myKeyDetection(test_audio, blockSize, hopSize, fs, false);
   if gt > 0
       if (gt + 1) > 12
           gt_char = strcat(key_minor(gt-11,:),' min');
       else
           gt_char = strcat(key_major(gt+1,:),' Maj');
       end
       disp(gt_char);
       disp(key_estimate_tune);
       disp(key_estimate_untune);
       disp(' ')
       if strcmp(gt_char, key_estimate_tune)
           num_correct_tune = num_correct_tune + 1;
       end
       if strcmp(gt_char, key_estimate_untune)
           num_correct_untune = num_correct_untune + 1;
       end
   end
end
accuracy = [num_correct_tune/length(audio_list);num_correct_untune/length(audio_list)];
end