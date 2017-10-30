function [errCentRms, pfp, pfn] = myEvaluation2(estimation, annotation)

%% Evaluates the performance of a pitch tracker
% Input:
%   estimation: (numBlocks x 1) float vector, estimated pitch (Hz) per block   
%   annotation: (numBlocks x 1) float vector, annotated pitch (Hz) per block
% Output:
%   errCentRms: float, rms of the difference between estInMidi and annInMidi 
%   pfp:		float, percentage of false positives (unvoiced blocks classified as voiced)
%	pfn:		float, percentage of false negatives (voiced blocks classified as unvoiced)
% Note: 
%   1) please exclude the blocks when ann(i) == 0

[m1,n1] = size(estimation);
if (n1>1)
    error('illegal estimation vector ');
end
[m2,n2] = size(annotation);
if (n2>1)
    error('illegal annotation vector');
end
if (m1~=m2)
   error('size of estimation and annotation do not match'); 
end

%% Please write your code here, Follow the steps as per the comments
% error_ = 0;
% for i = 1 : length(annotation)
%     error_ = error_ + (myFreq2MidiPitch(estimation(i))-myFreq2MidiPitch(annotation(i))).^2;
% end
pfp = myGetFalsePositives(estimation, annotation);
pfn = myGetFalseNegatives(estimation, annotation);

non_zero_est = estimation(annotation~=0);
non_zero_ann = annotation(annotation~=0);

non_zero_ann = non_zero_ann(non_zero_est~=0);
non_zero_est = non_zero_est(non_zero_est~=0);

% error_ = sum((myFreq2MidiPitch(estimation+bias) - myFreq2MidiPitch(annotation+bias)).^2);

errCentRms = 100 * sqrt(mean((myFreq2MidiPitch(non_zero_est) - myFreq2MidiPitch(non_zero_ann)).^2));

end