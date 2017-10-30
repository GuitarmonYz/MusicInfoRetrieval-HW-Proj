function [ fk_hz, fk_bin, f0_bin ] = getPartials(X, binFreqs, f0, fs, start, end_, numberOfPartials)
%UNTITLED6 Summary of this function goes here
% X: fftLength/2 * numBlocks
% binFreqs: fftLength/2 * 1
% f0: numBlocks * 1, in Hz
% fs: scalar
% fk: 15 * (numBlocks-24), in Hz, start form the 20th block and end at
% numblocks - 5
[numBins, numBlocks] = size(X);
fk_hz = zeros(numberOfPartials, numBlocks-(start+end_-1));
fk_bin = zeros(numberOfPartials, numBlocks-(start+end_-1));
f0_bin = zeros(numBlocks-(start+end_-1), 1);
for i = start : numBlocks - end_
    f_bins = X(:,i);
    f_bins(f_bins < 0.08) = 0;
    [~, f_k] = findpeaks(f_bins);
    f0 = f0*2*numBins/fs;
    if length(f_k) == 1 || isempty(f_k)
            disp('no peak found');
            fk_bin(:,i - start + 1) = zeros(numberOfPartials,1); 
            fk_hz(:,i - start + 1) = zeros(numberOfPartials,1);
            f0_bin(i - start + 1) = 0;
    else
        if (f_k(1)>f0(i))
           f0_bin(i - start + 1) = f_k(1); 
        else
           f0_bin(i - start + 1) = round(f0(i));
        end
        if length(f_k) < numberOfPartials+1
                for j = length(f_k) : numberOfPartials+1
%                     disp(2*f_k(j)-f_k(j-1));
                    f_k = [f_k;2*f_k(j)-f_k(j-1)];
                end
        end
        fk_bin(:,i - start + 1) = f_k(2:numberOfPartials+1);
        fk_hz(:,i - start + 1) = binFreqs(f_k(2:numberOfPartials+1)); 
    end
end
end

