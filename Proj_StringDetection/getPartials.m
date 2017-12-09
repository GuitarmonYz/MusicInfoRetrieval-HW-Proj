function [ fk_hz, fk_bin, fk_centroid, f0_bin_mask, f0_bin ] = getPartials(X, binFreqs, f0, fs, start, end_, numberOfPartials)
%UNTITLED6 Summary of this function goes here
% X: fftLength/2 * numBlocks
% binFreqs: fftLength/2 * 1
% f0: numBlocks * 1, in Hz
% fs: scalar
% fk: numberOfPartials * (numBlocks-24), in Hz, start form the 20th block and end at
% numblocks - 5
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
%     [~, f_k] = findpeaks(f_bins, 'SortStr', 'descend');
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
%             f0_bin(i - start + 1) = 0;
            fk_centroid(i - start + 1) = 0;
    else
%         if (f_k(1)>f0(i))
%            f0_bin(i - start + 1) = f_k(1); 
%         else
%            f0_bin(i - start + 1) = round(f0(i));
%         end
        first_partial = 0;
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
%         if length(f_k) < numberOfPartials+1
%             f_k = sort(f_k, 'ascend');
%             for j = length(f_k) : numberOfPartials+1
%                 f_k = [f_k;2*f_k(j)-f_k(j-1)];
%             end
%         end
        if length(f_k) < numberOfPartials
            for j = length(f_k) : numberOfPartials
                f_k = [f_k;2*f_k(j)-f_k(j-1)];
            end
        end
%         f_k = f_k(1:numberOfPartials+1);
%         f_k = sort(f_k, 'ascend');
%         fk_bin(:,i - start + 1) = f_k(2:numberOfPartials+1);
%         fk_hz(:,i - start + 1) = binFreqs(f_k(2:numberOfPartials+1));
%         fk_val = f_bins(f_k(2:numberOfPartials+1));
        fk_bin(:,i - start + 1) = f_k(1:numberOfPartials);
        fk_hz(:,i - start + 1) = binFreqs(f_k(1:numberOfPartials));
        fk_val = f_bins(f_k(1:numberOfPartials));
        fk_centroid(i - start + 1) = sum((1:numberOfPartials)'.*fk_val)/sum(fk_val);
    end
end

end

