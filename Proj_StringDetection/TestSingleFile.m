blockSize = 1024;
hopSize = 512;
fs = 44100;
test_audio = audioread('./testSet/audio/FS_G_fret_0-20.wav');
%     disp(audio_list(i).name);
    annotation_matrix = csvread('./testSet/annotation/FS_G_fret_0-20.csv');
%     disp(annotation_list(i).name);
    onSet = annotation_matrix(:,2);
    offSet = annotation_matrix(:,3);
    stringNum = annotation_matrix(:,5);
    stringNum = stringNum(1:13);
    featureMatrix_test = zeros(31, 13*8);
%     trueVal((i-1)*104+1:i*104) = repelem(stringNum,8);
    for j = 1 : 13
        onSet_sample = round(onSet(j)*fs);
        offSet_sample = round(offSet(j)*fs);
        single_note = test_audio(onSet_sample:offSet_sample);
        featureMatrix_aggregated = getFeatures(single_note, blockSize, hopSize, fs);
        featureMatrix_test(:,(j-1)*8+1:j*8) = featureMatrix_aggregated;
    end