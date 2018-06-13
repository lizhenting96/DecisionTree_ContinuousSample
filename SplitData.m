function [Data_Splited,Target_Splited] = SplitData(trainfeatures,targets,No_of_Max,Corresponding_Middle)
Data_Splited = cell(2,1);
Target_Splited = cell(2,1);

Small_Position = find(trainfeatures(:,No_of_Max) < Corresponding_Middle);%标记出原数据集中，选中特征下，比中间值小的数据的位置
Data_Splited{1} = trainfeatures(Small_Position,:);%Data_Splited(i)是一个矩阵，每一行都是一个样本，它们选中特征都小于Middle
Target_Splited{1} = targets(Small_Position,:);%Target_Splited，与Data_Splited匹配，保证样本分开之后属性与分类的一致性
Data_Splited{1}(:,No_of_Max) = [];

Large_Position = find(trainfeatures(:,No_of_Max) > Corresponding_Middle);%标记出原数据集中，选中特征下，比中间值大的数据的位置
Data_Splited{2} = trainfeatures(Large_Position,:);%Data_Splited(i)是一个矩阵，每一行都是一个样本，它们选中特征都大于Middle
Target_Splited{2} = targets(Large_Position,:);%Target_Splited，与Data_Splited匹配，保证样本分开之后属性与分类的一致性
Data_Splited{2}(:,No_of_Max) = [];