%% set hyperparams
fs = 44100;
blockSize = 1024;
hopSize = 512;
%% sin wav test
f1 = 441;
f2 = 882;
t1 = (0: 1/fs : 1);
t2 = (0: 1/fs : 1);
% generate sin wav
sin_t1 = sin(2*pi*f1*t1);
sin_t2 = sin(2*pi*f2*t2);
sin_t = [sin_t1,sin_t2(2:end)]';
% calculate f0 by finding max bin in spectrum
[f0_max, ts] = myPitchTrackMax(sin_t, blockSize, hopSize, fs);
% plot fig
plot(ts, f0_max);
title('f0 by max bin');
figure;
% measure the error
len_f = floor(length(f0_max)/2);
error_1 = abs(f0_max(1:len_f) - repmat(441,1,len_f)');
error_2 = abs(f0_max(len_f+1:end) - repmat(882,1,length(f0_max)-len_f)');
% plot fig
plot([error_1;error_2]);
title('error of max bin');
figure;
% calculate f0 by hps
[f0_hps, ts] = myPitchTrackHps(sin_t, blockSize, hopSize, fs);
% plot fig
plot(ts, f0_hps);
title('f0 by hps with 1024 blocksize');
figure;
% measure the error
error_1 = abs(f0_hps(1:len_f) - repmat(441,1,len_f)');
error_2 = abs(f0_hps(len_f+1:end) - repmat(882,1,length(f0_hps)-len_f)');
% plot fig
plot([error_1;error_2]);
title('error of hps with 1024 blocksize');
figure;
% change blocksize to 2048
blockSize = 2048;
% clculte f0 by hps
[f0_max, ts] = myPitchTrackMax(sin_t, blockSize, hopSize, fs);
plot(ts, f0_max);
title('f0 by max with 2048 blocksize');
figure;
% mesure the error
len_f = floor(length(f0_max)/2);
error_1 = abs(f0_max(1:len_f) - repmat(441,1,len_f)');
error_2 = abs(f0_max(len_f+1:end) - repmat(882,1,length(f0_max)-len_f)');
% plot fig
plot([error_1;error_2]);
title('error of max with 2048 blocksize');
%% trainning set before voicing
% change blocksize back to 1024
blockSize = 1024;
% get trainning data by dir function
audio_path = './trainData/*.wav';
annotation_path = './trainData/*.txt';
audio_list = dir(audio_path);
annotation_list = dir(annotation_path);
% allocate memory for eveluate metrics
max_metric = zeros(1,3);
hps_metric = zeros(1,3);
% loop through files
for i = 1:length(audio_list)
    [onset_seconds, ~, pitch_frequency, ~] = textread(strcat('./trainData/',annotation_list(i).name));
    train_audio = audioread(strcat('./trainData/',audio_list(i).name));
    [f0_max, ts_max] = myPitchTrackMax(train_audio,blockSize,hopSize,fs);
    [f0_hps, ts_hps] = myPitchTrackHps(train_audio,blockSize,hopSize,fs);
    [errcent, pfp, pfn] = myEvaluation2(f0_max,pitch_frequency);
    max_metric = max_metric + [errcent, pfp, pfn];
    [errcent, pfp, pfn] = myEvaluation2(f0_hps,pitch_frequency);
    hps_metric = hps_metric + [errcent, pfp, pfn];
end
max_metric = max_metric/length(audio_list);
hps_metric = hps_metric/length(audio_list);
%% add voicing
% allocate memory for eveluate metrics
max_metric_voiced_20 = zeros(1,3);
hps_metric_voiced_20 = zeros(1,3);
acf_metric_voiced_20 = zeros(1,3);
max_metric_voiced_40 = zeros(1,3);
hps_metric_voiced_40 = zeros(1,3);
acf_metric_voiced_40 = zeros(1,3);
% loop through files
for i = 1:length(audio_list)
    [onset_seconds, ~, pitch_frequency, ~] = textread(strcat('./trainData/',annotation_list(i).name));
    train_audio = audioread(strcat('./trainData/',audio_list(i).name));
%     threshold to -40
    [f0_max_voiced_40, ~] = myPitchTrack(train_audio,blockSize,hopSize,fs,'max',-40);
    [f0_acf_voiced_40, ~] = myPitchTrack(train_audio,blockSize,hopSize,fs,'hps',-40);
    [f0_hps_voiced_40, ~] = myPitchTrack(train_audio,blockSize,hopSize,fs,'acf',-40);
%     threshold to -20
    [f0_max_voiced_20, ts_max] = myPitchTrack(train_audio,blockSize,hopSize,fs,'max',-20);
    [f0_hps_voiced_20, ts_hps] = myPitchTrack(train_audio,blockSize,hopSize,fs,'hps',-20);
    [f0_acf_voiced_20, ts_acf] = myPitchTrack(train_audio,blockSize,hopSize,fs,'acf',-20);
%     evaluate when -40
    [errcent, pfp, pfn] = myEvaluation2(f0_max_voiced_40,pitch_frequency);
    max_metric_voiced_40 = max_metric_voiced_40 + [errcent, pfp, pfn];
    
    [errcent, pfp, pfn] = myEvaluation2(f0_hps_voiced_40,pitch_frequency);
    hps_metric_voiced_40 = hps_metric_voiced_40 + [errcent, pfp, pfn];
    
    [errcent, pfp, pfn] = myEvaluation2(f0_acf_voiced_40,pitch_frequency);
    acf_metric_voiced_40 = acf_metric_voiced_40 + [errcent, pfp, pfn];
%     evaluate when -20
    [errcent, pfp, pfn] = myEvaluation2(f0_max_voiced_20,pitch_frequency);
    max_metric_voiced_20 = max_metric_voiced_20 + [errcent, pfp, pfn];
    
    [errcent, pfp, pfn] = myEvaluation2(f0_hps_voiced_20,pitch_frequency);
    hps_metric_voiced_20 = hps_metric_voiced_20 + [errcent, pfp, pfn];
    
    [errcent, pfp, pfn] = myEvaluation2(f0_acf_voiced_20,pitch_frequency);
    acf_metric_voiced_20 = acf_metric_voiced_20 + [errcent, pfp, pfn];
end
% result of evaluation when threshold is -20
max_metric_voiced_20 = max_metric_voiced_20/length(audio_list);
hps_metric_voiced_20 = hps_metric_voiced_20/length(audio_list);
acf_metric_voiced_20 = acf_metric_voiced_20/length(audio_list);
% result of evaluation when threshold is -40
max_metric_voiced_40 = max_metric_voiced_40/length(audio_list);
hps_metric_voiced_40 = hps_metric_voiced_40/length(audio_list);
acf_metric_voiced_40 = acf_metric_voiced_40/length(audio_list);
