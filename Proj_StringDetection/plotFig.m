x_1 = audioread('./trainSet/audio/G53-50110-1111-00011.wav');
[xb, ~] = myBlockAudio(x_1,blockSize,hopSize,fs);
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);
plot(X(:,34));
hold on
x_2 = audioread('./trainSet/audio/G53-50205-1111-00019.wav');
[xb, ~] = myBlockAudio(x_2,blockSize,hopSize,fs);
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);
plot(X(:,34));
figure;
plot(X(:,34));
hold on
x_3 = audioread('./trainSet/audio/G53-50300-1111-00027.wav');
[xb, ~] = myBlockAudio(x_3,blockSize,hopSize,fs);
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);
plot(X(:,34));
