function [f0] = myPitchTrackMod2(xb, fs)
%% Blockwise Pitch Tracking based on a modified approach
% Input:
%   x:          (N x 1) float vector, input signal
%   fs:         float, sample rate in Hz
% Output:
%   f0:         (numBlocks x 1) float vector, detected pitch (Hz) per block
f0_acf = myPitchTrackAcf(xb, fs); 
f0_hps = myPitchTrackHps(xb, fs);
% for freq greater than 570 use result from hps
f0_hps(f0_acf<570) = 0;
f0_acf(f0_acf>=570) = 0;
f0 = f0_hps + f0_acf;
end