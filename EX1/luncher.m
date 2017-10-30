y = audioread('sax_example.wav');
plot(y);

yDec = decimateAudio(y, 2);
