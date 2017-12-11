# README

### running instruction

EaxmplePlayGround.m and ExtractFeature.m are the entry point to other codes;

If you want re-run the feature extraction and trainning process, you can run ExtractFeature, with the dataset provided at:

https://drive.google.com/file/d/1F01OE9DW1f1Xp3lZFR5kvcrTZQPlwDQR/view?usp=sharing

make sure the testSet/trainSet and ExatrctFeature are under the same folder;

The machine learning process are done in machine learning toolbox for matlab, choose train_data in the app and run SVM with PCA(11 feature selected);

If you just want to check the result, you can run EaxmplePlayGround.m, which load the pre-trained SVM model and pre-extracted features of both trainData and testData. The script will output confusion matrix for both.

------

The function of each .m files are written in the files

**Great thanks for Jakob Abeßer for sharing their dataset!**