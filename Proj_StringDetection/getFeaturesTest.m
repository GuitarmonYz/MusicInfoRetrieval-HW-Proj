function [featureVector] = getFeaturesTest( x, blockSize, hopSize, fs, numberOfPartials )
%% same feature extraction withn getFeature but different aggregation approach for test data
% Block audio
[xb, ~] = myBlockAudio(x,blockSize,hopSize,fs);
f0 = myPitchTrackMod2(xb, fs);
% Apply window functions
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);
% use from 20th block to numBlock - 5th block
start = 8;
end_ = 5;
% get partials
[fk_hz, fk_bin, fk_centroid, f0_bin_mask, f0_bin] = getPartials(X, binFreqs, f0, fs, start, end_, numberOfPartials);
% use from 20th block to numBlock - 5th block
f0 = f0(start:end-end_);
% f0(f0_bin_mask==0) = 0;
f0 = f0 .* f0_bin_mask;
% ts = ts(start:end-end_);
% get features
beta_inharmonicity = getInharmonicityCoefficient( f0, fk_hz );
rel_partial_amp = getRelativePartialAmp(X, f0, f0_bin, fk_bin, start, end_);
partial_deviation_norm = getPartialDeviations(f0, fk_hz, beta_inharmonicity);
fk_centroid = fk_centroid(fk_centroid ~= 0);
featureMatrix_raw = [beta_inharmonicity';rel_partial_amp;partial_deviation_norm;fk_centroid'];
featureVector = median(featureMatrix_raw,2);
end

