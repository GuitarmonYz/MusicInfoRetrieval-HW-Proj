function [ center_partial ] = getPartialCentroid( x, blockSize, hopSize, fs )
%% get partial centroid based on bin index
[xb, ~] = myBlockAudio(x,blockSize,hopSize,fs);
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);
f0 = myPitchTrackMod2(xb, fs, -40, -20);
[fk_hz, fk_bin, f0_bin] = getPartials(X, binFreqs, f0, fs, 20, 5);
zero_indices = find(~f0_bin);
X = X(:,(20:end-5));
center_partial = zeros(length(f0_bin)-length(zero_indices),1);
j = 1;
for i = 1 : length(f0_bin)
    if ~ismember(i, zero_indices)
        tmp_bins = X(:,i);
        ak = tmp_bins(fk_bin(:,i));
        center_partial(j) = ak'*fk_hz(:,i)/sum(ak);
        j = j + 1;
    end
end
center_partial = mean(center_partial);
end

