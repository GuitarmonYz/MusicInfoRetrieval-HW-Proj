function [rmsDb] = myComputeRmsDb(xb) 

%% Computes the rms amplitude of each block of the input blocked audio 
% Input:
%	xb: 	(blockSize x numBlocks) float matrix, blocked audio 
% Output:
%	rmsDb: 	(numBlocks x 1) float vector, rms amplitude of each block in decibels	


%% Please insert your code here
rmsDb = 20 * log10(sqrt(mean(xb.^2)));

end