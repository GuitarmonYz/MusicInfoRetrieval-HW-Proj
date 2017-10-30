fs = 44100;
blockSize = 1024;
hopSize = 512;
%generate sine wave, plot estimation and error
f1 = 441;
f2 = 882;
t1 = (0: 1/fs : 1);
t2 = (0: 1/fs : 1);

sin_t1 = sin(2*pi*f1*t1);
sin_t2 = sin(2*pi*f2*t2);
sin_t = [sin_t1,sin_t2(2:end)]';

[f0, ts] = myPitchTrackAcf(sin_t, blockSize, hopSize, fs);

plot(ts, f0);
title('estimated pitch by ACF');
xlabel('T/s');
ylabel('Freq/Hz')
figure;

len_f = floor(length(f0)/2);
%calculate each error
error_1 = abs(f0(1:len_f) - repmat(441,1,len_f)');
error_2 = abs(f0(len_f+1:end) - repmat(882,1,length(f0)-len_f)');

plot([error_1;error_2]);
title('absolute error of estimated pitch')
xlabel('block idx');
ylabel('absolute error')
%first trainning sample
[onset_seconds, ~, pitch_frequency, ~] = textread('trainData/01-D_AMairena.f0.Corrected.txt', '%f %f %f %f');
audio_input = audioread('trainData/01-D_AMairena.wav');

[f0, ts] = myPitchTrackMod(audio_input, blockSize, hopSize, fs);

if length(onset_seconds) == length(ts)
    err = myEvaluation(f0, pitch_frequency);
end
disp(err);
%second trainning sample
[onset_seconds, ~, pitch_frequency, ~] = textread('trainData/24-M1_AMairena-Martinete.f0.Corrected.txt', '%f %f %f %f');
audio_input = audioread('trainData/24-M1_AMairena-Martinete.wav');

[f0, ts] = myPitchTrackAcf(audio_input, blockSize, hopSize, fs);

if length(onset_seconds) == length(ts)
    err = myEvaluation(f0, pitch_frequency);
end
disp(err);
%third trainning sample
[onset_seconds, ~, pitch_frequency, ~] = textread('trainData/63-M2_AMairena.f0.Corrected.txt', '%f %f %f %f');
audio_input = audioread('trainData/63-M2_AMairena.wav');

[f0, ts] = myPitchTrackAcf(audio_input, blockSize, hopSize, fs);

if length(onset_seconds) == length(ts)
    err = myEvaluation(f0, pitch_frequency);
end
disp(err);