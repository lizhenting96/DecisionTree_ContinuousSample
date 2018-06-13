# DecisionTree_ContinuousSample
Decision Tree, Continuous Sample, Information Entropy, Information Gain, Simple Pruning

Decision tree is a common machine learning method. We hope that the program can learn a model from a given training data set to classify new samples. The decision tree is based on the structure of the tree to make decisions. The selection of optimal partition attributes is related to information gain and information entropy. In addition, it is necessary to prune the decision tree to reduce the risk of over-fitting. In this paper, discrete decision trees and continuous decision trees are designed, and some simple pruning processes are given.

This program mainly includes four subroutines:
maketree.m: Build the tree and output the classified data
InfoGainCon: Calculate Information Gains
DataClassifier: Seperate data at each nodes according to the proper feature.
And the script DecisionTree includes the process of inputing data.

To run the codes,maketree, it will be necessary to input featurelabes(for example, using 1,2,3,4 to represent Sepal length, Sepal width, Petal length, Petal width), trainfeatures(features of the training set), targets(the classification of  training set) and threshold(the minimum information gain to stop recurrence).

The sample I use is Iris Dataset and it is uploaded in the excel.
