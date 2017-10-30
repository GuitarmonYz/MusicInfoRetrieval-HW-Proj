function [f0] = myComputeF0FromHPS(X, fs, order)

%% Computes the fundamental frequency f0 from a spectrogram using HPS
% Input:
%	X:			(fftLength / 2 x numBlocks) float matrix, mag. spectrogram
%	fs:			float, sampling rate in Hz
% 	order:		int, specifying the order for computing HPS
% Output:
% 	f0:			(numBlocks x 1) float vector, fundamental frequency of all blocks

%% Please insert your code here
tmp_hps = X;
for i = 2:order
    tmp_hps = tmp_hps .* [X(1:i:end,:); zeros(size(X,1)-size(X(1:i:end,:),1), size(X,2))];
end
[~, f0] = max(tmp_hps);
f0 = (f0 / size(X,1) * fs/2)';
end
