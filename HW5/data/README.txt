This folder contains the pre-computed features and labels for the genre classification task.
All songs are sourced from the GTZAN dataset: 
http://marsyasweb.appspot.com/download/data_sets/
100 songs from 5 genres have been used: classical, country, hip-hop, jazz and metal
All features are z-score normalized

File Details:
1) data.mat:            contains the 10 x 500 feature matrix              
2) labels.mat:          contains 1 x 500 row vector with the genre labels 
3) label_dict.txt:      defines the label dictionary 
                        (mapping of label tags to genre)
4) feature_dict.txt:    defines the feature dictionary 
                        (mapping of row index of the feature matrix to feature description)
                
