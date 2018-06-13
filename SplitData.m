function [Data_Splited,Target_Splited] = SplitData(trainfeatures,targets,No_of_Max,Corresponding_Middle)
Data_Splited = cell(2,1);
Target_Splited = cell(2,1);

Small_Position = find(trainfeatures(:,No_of_Max) < Corresponding_Middle);%��ǳ�ԭ���ݼ��У�ѡ�������£����м�ֵС�����ݵ�λ��
Data_Splited{1} = trainfeatures(Small_Position,:);%Data_Splited(i)��һ������ÿһ�ж���һ������������ѡ��������С��Middle
Target_Splited{1} = targets(Small_Position,:);%Target_Splited����Data_Splitedƥ�䣬��֤�����ֿ�֮������������һ����
Data_Splited{1}(:,No_of_Max) = [];

Large_Position = find(trainfeatures(:,No_of_Max) > Corresponding_Middle);%��ǳ�ԭ���ݼ��У�ѡ�������£����м�ֵ������ݵ�λ��
Data_Splited{2} = trainfeatures(Large_Position,:);%Data_Splited(i)��һ������ÿһ�ж���һ������������ѡ������������Middle
Target_Splited{2} = targets(Large_Position,:);%Target_Splited����Data_Splitedƥ�䣬��֤�����ֿ�֮������������һ����
Data_Splited{2}(:,No_of_Max) = [];