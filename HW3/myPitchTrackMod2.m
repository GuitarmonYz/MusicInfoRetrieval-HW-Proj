function [f0, timeInSec] = myPitchTrackMod2(x, blockSize, hopSize, fs)

%% Blockwise Pitch Tracking based on a modified approach
% Input:
%   x:          (N x 1) float vector, input signal
%   blockSize:  int, block size of the blockwise process
%   hopSize:    int, hop size of the blockwise process
%   fs:         float, sample rate in Hz
% Output:
%   f0:         (numBlocks x 1) float vector, detected pitch (Hz) per block
%   timeInSec:  (numBlocks x 1) float vector, time stamp (sec) of each block

%% Please write your code here
[f0_acf_unvoiced, ~] = myPitchTrackMod(x, blockSize, hopSize, fs); 
[f0_hps_unvoiced, timeInSec] = myPitchTrackHps(x, blockSize, hopSize, fs);
% reblock
[xb, ~] = myBlockAudio(x,blockSize,hopSize,fs);
% Compute RMS of block 
rmsDb = myComputeRmsDb(xb);
% Create voicing mask 
voicingThres_hps = -40;
voicingThres_acf = -20;
mask_hps = myCreateVoicingMask(rmsDb, voicingThres_hps);
mask_acf = myCreateVoicingMask(rmsDb, voicingThres_acf);
% Apply voicing mask seperately
f0_hps = myApplyVoicingMask(f0_hps_unvoiced,mask_hps);
f0_acf = myApplyVoicingMask(f0_acf_unvoiced,mask_acf);

% for freq greater than 570 use result from hps
f0_hps(f0_acf<570) = 0;
f0_acf(f0_acf>=570) = 0;
f0 = f0_hps + f0_acf;
end