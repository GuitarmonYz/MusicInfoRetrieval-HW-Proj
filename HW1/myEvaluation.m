function [errCentRms] = myEvaluation(estimation, annotation)

%% Evaluates the performance of a pitch tracker
% Input:
%   estimation: (numBlocks x 1) float vector, estimated pitch (Hz) per block   
%   annotation: (numBlocks x 1) float vector, annotated pitch (Hz) per block
% Output:
%   errCentRms: float, rms of the difference between estInMidi and annInMidi 
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
error_ = 0;
for i = 1 : length(annotation)
    if (annotation(i)~=0)
        error_ = error_ + (myFreq2MidiPitch(estimation(i))-myFreq2MidiPitch(annotation(i))).^2;
    end
end

errCentRms = 100 * sqrt(error_/(length(annotation)-1));

end