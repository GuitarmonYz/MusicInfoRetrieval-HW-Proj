function [ partial_template, string_template ] = getPartialTemplate( audio_path, annotation_path, blockSize, hopSize, fs )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
audio_list = dir(audio_path);
annotation_matrix = csvread(annotation_path);
note_array = annotation_matrix(:,1);
string_array = annotation_matrix(:,5);
prev_note = 0;
partial_template = zeros(note_array(end)-note_array(1)+1,3);
string_template = zeros(note_array(end)-note_array(1)+1,3);
k = 0;
j = 1;
for i = 1 : length(audio_list)
    disp(audio_list(i).name);
    train_audio = audioread(strcat('./trainSet/audio/',audio_list(i).name));
    partial_center = getPartialCentroid(train_audio, blockSize, hopSize, fs);
    if prev_note ~= note_array(i)
        j = 1;
        k = k + 1;
        partial_template(k,j) = partial_center;
        string_template(k,j) = string_array(i);
        prev_note = note_array(i);
        
    else
        j = j + 1;
        partial_template(k,j) = partial_center;
        string_template(k,j) = string_array(i);
    end
end
end

