function rel_partial_amp = getRelativePartialAmp(X, f0, f0_bin, fk_bin, start, end_)
%UNTITLED2 Summary of this function goes here
% X: fftlength/2 * numBlocks
% f0_bin: numBlocks - (start + end_ - 1) * 1 bin index of fundamental freq
% fk_bin: numberOfPartials * numBlocks - (start + end_ - 1) bin index of partial freqs
zero_indices = find(~f0_bin);
X = X(:,(start:end-end_));
rel_partial_amp = zeros(size(fk_bin,1), length(f0_bin));
for i = 1 : length(f0_bin)
    if ~ismember(i,zero_indices)
        tmp_bins = X(:,i);
        rel_partial_amp(:,i) = tmp_bins(fk_bin(:,i))/tmp_bins(f0_bin(i));
    end
end
zero_indices = f0 == 0;
rel_partial_amp(:,zero_indices) = [];
end

