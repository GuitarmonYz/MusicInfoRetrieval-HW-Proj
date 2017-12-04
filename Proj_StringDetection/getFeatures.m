function [featureMatrix] = getFeatures(x, blockSize, hopSize, fs, numberOfPartials)
%UNTITLED3 Summary of this function goes here
%   featureMatrix: 17 * 8)
% voicingThres_hps = -40;
% voicingThres_acf = -20;
% numberOfPartials = 15;
[xb, ~] = myBlockAudio(x,blockSize,hopSize,fs);
f0 = myPitchTrackMod2(xb, fs);
% Apply window functions
[~, numBlocks] = size(xb);
window = repmat(hann(blockSize),1,numBlocks);
xb = xb.*window;
[X, binFreqs] = myComputeSpectrogram(xb, fs, blockSize);
% use from 20th block to numBlock - 5th block
start = 22;
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
% [mean_rel, var_rel, skew_rel, max_rel, min_rel] = getStatistics(rel_partial_amp);
% [mean_par, var_par, skew_par, max_par, min_par] = getStatistics(partial_deviation_norm);
fk_centroid = fk_centroid(fk_centroid ~= 0);
if (length(fk_centroid) ~= size(rel_partial_amp, 2))
   disp(length(fk_centroid));
   disp(size(rel_partial_amp, 2));
end
featureMatrix_raw = [beta_inharmonicity';rel_partial_amp;partial_deviation_norm;fk_centroid'];
observations = size(featureMatrix_raw, 2);
featureMatrix = zeros(size(featureMatrix_raw,1),8);
feature_hop = floor(observations/8);
loop_length = feature_hop*8;
k = 1;
for i = 1 :feature_hop: loop_length
%     if i + feature_hop -1 > size(featureMatrix,2)
%         break;
%     end
    if (feature_hop + i - 1 > observations)
        tmp_featureMatrix = featureMatrix_raw(:,i:end);
        featureMatrix(:,k) = mean(tmp_featureMatrix, 2);
    else
        tmp_featureMatrix = featureMatrix_raw(:,i:i+feature_hop-1);
        featureMatrix(:,k) = mean(tmp_featureMatrix, 2);
    end
    k = k + 1;
    
end
end

