function [ fk_hz, fk_bin, fk_centroid, f0_bin_mask, f0_bin ] = getPartials(X, binFreqs, f0, fs, start, end_, numberOfPartials)
%% function to get all partial related basic params
% X: fftLength/2 * numBlocks
% binFreqs: fftLength/2 * 1
% f0: numBlocks * 1, in Hz
% fs: scalar
% start, end_: only use block from start to end_
% numberOfPartials: numberOfPartials to take
% fk_hz: numberOfPartials * (numBlocks-(start+end_-1)), in Hz
% fk_bin: numberOfPartials * (numBlocks-(start+end_-1)), in bin idx
% fk_centroid: (numBlocks-(start+end_-1)) * 1, partial centroid by partialIdx
% f0_bin_mask: zero out invalid blocks
% f0_bin: (numBlocks-(start+end_-1)) * 1, f0 in bin index
[numBins, numBlocks] = size(X);
fk_hz = zeros(numberOfPartials, numBlocks-(start+end_-1));
fk_bin = zeros(numberOfPartials, numBlocks-(start+end_-1));
f0_bin_mask = ones(numBlocks-(start+end_-1), 1);
f0_bin = zeros(numBlocks-(start+end_-1), 1);
fk_centroid = zeros(numBlocks-(start+end_-1), 1);
for i = start : numBlocks - end_
    f_bins = X(:,i);
% thresholding bins
    f_bins(f_bins < 0.2) = 0;
% findpeaks in frequency domain
    [~, f_k] = findpeaks(f_bins);
% f_k is bin index, and sort it in descending order to get first numberOfPartials
% note that the first element of f_k is probably f0
    
% convert f0 to bin index
    f0_bin_truth = f0*(2*numBins-1)/fs;
    if length(f_k) <= 6 || isempty(f_k)
            disp('no peak found');
            fk_bin(:,i - start + 1) = zeros(numberOfPartials,1); 
            fk_hz(:,i - start + 1) = zeros(numberOfPartials,1);
            f0_bin_mask(i - start + 1) = 0;
            fk_centroid(i - start + 1) = 0;
    else
        first_partial = 0;
        % get rid of unwanted peaks before f0 peak
        for j = 1 : length(f_k)
            if (f_k(j) > f0_bin_truth(i)*0.8 && f_k(j) < f0_bin_truth(i) * 1.2)
               f0_bin(i - start + 1) = f_k(j); 
            end
            if (f_k(j) > f0_bin_truth(i) * 1.5)
                first_partial = j;
                break;
            end
        end
        f_k = f_k(first_partial:end);
        % make fake partial postion to 'in-complete signal'
        if length(f_k) < numberOfPartials
            for j = length(f_k) : numberOfPartials
                f_k = [f_k;2*f_k(j)-f_k(j-1)];
            end
        end
        fk_bin(:,i - start + 1) = f_k(1:numberOfPartials);
        fk_hz(:,i - start + 1) = binFreqs(f_k(1:numberOfPartials));
        fk_val = f_bins(f_k(1:numberOfPartials));
        fk_centroid(i - start + 1) = sum((1:numberOfPartials)'.*fk_val)/sum(fk_val);
    end
end

end

