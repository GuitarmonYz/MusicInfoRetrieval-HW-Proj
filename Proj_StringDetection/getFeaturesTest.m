function [featureVector] = getFeaturesTest( x, blockSize, hopSize, fs, numberOfPartials )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
voicingThres_hps = -40;
voicingThres_acf = -20;
[xb, ~] = myBlockAudio(x,blockSize,hopSize,fs);
f0 = myPitchTrackMod2(xb, fs, voicingThres_hps, voicingThres_acf);
% Apply window functions
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);
% use from 20th block to numBlock - 5th block
start = 4;
end_ = 2;
% get partials
[fk_hz, fk_bin, f0_bin] = getPartials(X, binFreqs, f0, fs, start, end_, numberOfPartials);
% use from 20th block to numBlock - 5th block
f0 = f0(start:end-end_);
f0(f0_bin==0) = 0;
% ts = ts(start:end-end_);
% get features
beta_inharmonicity = getInharmonicityCoefficient( f0, fk_hz );
rel_partial_amp = getRelativePartialAmp(X, f0_bin, fk_bin, start, end_);
partial_deviation_norm = getPartialDeviations(f0, fk_hz, beta_inharmonicity);
numSelBlocks = size(rel_partial_amp, 2);
% [mean_rel, var_rel, skew_rel, max_rel, min_rel] = getStatistics(rel_partial_amp);
% [mean_par, var_par, skew_par, max_par, min_par] = getStatistics(partial_deviation_norm);
featureMatrix_raw = [beta_inharmonicity';rel_partial_amp;partial_deviation_norm];
sel_start = floor(numSelBlocks/6)+1;
sel_end = 5 * floor(numSelBlocks/6);
featureVector = median(featureMatrix_raw(:,sel_start:sel_end),2);
end

