function [ string_number ] = predict_partialCenter( test_file, partial_template, string_template, blockSize, hopSize, fs)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[xb, ~] = myBlockAudio(test_file,blockSize,hopSize,fs);
f0 = myPitchTrackMod2(xb, fs, -40, -20);
f0_midi = round(myFreq2MidiPitch(f0));
template_partial_centroid = partial_template(round(mean(abs(f0_midi))) - 39,:);
partial_centroid = getPartialCentroid(test_file, blockSize, hopSize, fs);
[~,index] = min(abs(template_partial_centroid - partial_centroid));
string_number_template = string_template(round(mean(abs(f0_midi)))-39,:);
string_number = string_number_template(index);
end

