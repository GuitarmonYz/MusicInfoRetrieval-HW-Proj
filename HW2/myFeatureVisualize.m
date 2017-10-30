% Script: myFeatureVisualize
% Write all your code for this part of the assignment here.
% You are free to write more functions of your own but make 
% sure that everything is performed within this script.
blockSize = 1024;
hopSize = 256;
speech_matrix = getMetaData('speech_wav', blockSize, hopSize);
music_matrix = getMetaData('music_wav', blockSize, hopSize);
feature_matrix = [speech_matrix, music_matrix];
normalized_matrix = zScoreNormalize(feature_matrix);

sc_mean = normalized_matrix(1,:);
rms_mean = normalized_matrix(2,:);
zcr_mean = normalized_matrix(3,:);
scr_mean = normalized_matrix(4,:);
sf_mean = normalized_matrix(5,:);
sc_std = normalized_matrix(6, :);
rms_std = normalized_matrix(7,:);
zcr_std = normalized_matrix(8,:);
scr_std = normalized_matrix(9,:);
sf_std = normalized_matrix(10,:);

c = zeros(length(normalized_matrix(1,:)),3);

c((1:length(speech_matrix(1,:))), :) = repmat([0,0,1],length(speech_matrix(1,:)),1);
c((length(speech_matrix(1,:))+1:end), :) = repmat([1,0,0],length(music_matrix(1,:)),1);

subplot(2,3,1);
scatter(sc_mean, scr_mean, [], c, 'filled');
title('SC_{mean} - SCR_{mean}');
subplot(2,3,2);
scatter(sf_mean, zcr_mean, [], c, 'filled');
title('SF_{mean} - ZCR_{mean}');
subplot(2,3,3);
scatter(rms_mean, rms_std, [], c, 'filled');
title('RMS_{mean} - RMS_{std}');
subplot(2,3,4);
scatter(zcr_std, scr_std, [], c, 'filled');
title('ZCR_{mean} - SCR_{std}');
subplot(2,3,5);
scatter(sc_std, sf_std, [], c, 'filled');
title('SC_{mean} - SF_{std}');

