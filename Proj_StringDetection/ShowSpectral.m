%% code for debugging
test_audio = audioread('./trainSet/audio/G53-59500-1111-00053.wav');
blockSize = 4096;
hopSize = 2048;
fs = 44100;
[xb, ~] = myBlockAudio(test_audio,blockSize,hopSize,fs);
f0 = myPitchTrackMod2(xb, fs);
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);