function [f0Adj] = myApplyVoicingMask(f0, mask)

%% Applies the voicing mask to the computed fundamental frequency vector 
% Input:
%	f0:		(numBlocks x 1) float vector, fundamental frequency (Hz) for each audio block
%	mask:	(numBlocks x 1) binary int vector
% Output: 
%	f0Adj:	(numBlocks x 1) float vector, fundamental frequency (Hz) for each audio block with voicing detection
f0Adj = f0.*mask;
end