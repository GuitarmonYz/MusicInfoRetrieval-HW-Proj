function [f0Adj, timeInSec] = myPitchTrack(x, blockSize, hopSize, fs, method, voicingThres)

%% Computes the fundamental pitch of an input audio using different methods
% Input:
%   x:          (N x 1) float vector, input signal
%   blockSize:  int, block size of the blockwise process
%   hopSize:    int, hop size of the blockwise process
%   fs:         float, sample rate in Hz
%	method:		string, 'acf' for ACF method, 'max' for maximum spectrum method, 'hps' for HPS method
% 	threshold:	float, rms amplitude threshold based on which voicing mask is computed 
% Output:
%   f0Adj:      (numBlocks x 1) float vector, detected pitch(Hz) per block
%   timeInSec:  (numBlocks x 1) float vector, time stamp (sec) of each block

%% Select which pitch tracer to use based on 'method' parameter and compute f0
if strcmp(method, 'acf')
	[f0, timeInSec] = myPitchTrackAcf(x, blockSize, hopSize, fs); 
elseif method == 'max'
    [f0, timeInSec] = myPitchTrackMax(x, blockSize, hopSize, fs); 
elseif method == 'hps'
    [f0, timeInSec] = myPitchTrackHps(x, blockSize, hopSize, fs); 
end

%% Please insert your code here based on the following steps 
% Block audio again (this is inefficient but required for reusing code)
[xb, ~] = myBlockAudio(x,blockSize,hopSize,fs);
% Compute RMS of block 
rmsDb = myComputeRmsDb(xb);
% Create voicing mask 
mask = myCreateVoicingMask(rmsDb, voicingThres);
% Apply voicing mask 
f0Adj = myApplyVoicingMask(f0,mask);
end