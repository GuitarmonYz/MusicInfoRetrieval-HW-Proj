function [mask] = myCreateVoicingMask(rmsDb, thresholdDb) 

%% Computes the binary voicing mask based on the rms amplitude threshold 
% Input:
%	rmsDb:			(numBlocks x 1) float vector, rms amplitude values for each audio block
%	thresholdDb:	float, rms amplitude threshold based on which mask is computed 
% Output:
%	mask: 		(numBlocks x 1) binary int vector

%% Please insert your code here
mask = zeros(length(rmsDb),1);
mask(rmsDb >= thresholdDb) = 1;
end