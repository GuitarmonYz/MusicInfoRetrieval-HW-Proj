x = audioread('sax_example.wav');
block_size = 2056;
hop_size = 1028;
sample_rate = 44100;
xb = blockAudio(x, block_size, hop_size);
Xb = compMagSpectrum(xb);
f = (1:22050/length(Xb(1,:)):22050)';
delta_t = hop_size/sample_rate;
time_stamp = 0.5 * block_size/sample_rate;
t = (time_stamp:delta_t:length(Xb(:,1)) * time_stamp)';
surf(t,f,Xb','EdgeColor','none');
view(2);
axis tight;
title('Spectrum for sax')
xlabel('T/s');
ylabel('Freq/Hz');