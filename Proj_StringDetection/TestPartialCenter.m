blockSize = 2048;
hopSize = 1024;
fs = 44100;
%% train template
% audio_path = './trainSet/audio/*.wav';
% annotation_path = './trainSet/annotation/Fender Strat Clean Neck SC.csv';
% 
% [partial_template, string_template] = getPartialTemplate(audio_path, annotation_path, blockSize, hopSize, fs);

% stringNum = predict_partialCenter( test_file, partial_template, string_template, blockSize, hopSize, fs);
%% test result
audio_path = './testSet/audio/*.wav';
annotation_path = './testSet/annotation/*.csv';

audio_list = dir(audio_path);
annotation_list = dir(annotation_path);
trueVal = zeros(13*length(audio_list),1);
predictVal = zeros(13*length(audio_list),1);

for i = 1 : length(audio_list)
    test_audio = audioread(strcat('./testSet/audio/',audio_list(i).name));
    disp(audio_list(i).name);
    annotation_matrix = csvread(strcat('./testSet/annotation/',annotation_list(i).name));
    disp(annotation_list(i).name);
    onSet = annotation_matrix(:,2);
    offSet = annotation_matrix(:,3);
    stringNum = annotation_matrix(:,5);
    trueVal((i-1)*13+1:i*13) = stringNum(1:13);
    for j = 1 : 13
        onSet_sample = round(onSet(j)*fs);
        offSet_sample = round(offSet(j)*fs);
        single_note = test_audio(onSet_sample:offSet_sample);
        predictVal((i-1)*13+j) = predict_partialCenter( single_note, partial_template, string_template, blockSize, hopSize, fs);
    end
end
trueVal_cat = categorical(trueVal);
predictVal_cat = categorical(predictVal);