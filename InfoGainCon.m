function [Max_InfoGain,No_of_Max,Corresponding_Middle] = InfoGainCon(different_classes,targets,feature_num,example_num,trainfeatures)
pnode = zeros(1,length(different_classes));
for i = 1:length(different_classes)
    pnode(i) = length(find(targets == different_classes(i)))/length(targets);%对应的最终分类结果占总样本数的比例
end
EntD = -sum(pnode.*log(pnode)/log(2));%样本集的信息熵

Max_InfoGain = -1;%特征最大的信息增益
No_of_Max = -1;%第几个特征的信息增益最大
Feature_InfoGain = zeros(1,feature_num);%预设各个特征的信息增益都为0
Middle_when_Max = zeros(1,feature_num);%预设各个特征的信息增益最大时所对应的中间值均为0

for i = 1:feature_num
    different_properties = unique(trainfeatures(:,i));%第i个特征下的不同属性值集合
    num_of_different_properties = length(different_properties);%第i个特征下有多少个不同的属性值
    Middle_Ent = zeros(1,num_of_different_properties - 1);%总共有num_of_different_properties - 1个不同的中间值，预设第i个中间值下各个属性的信息熵为0
    Middle_Gain = zeros(1,num_of_different_properties - 1);%预分配中值信息增益的空间
    Middle = zeros(1,num_of_different_properties - 1);%预分配中间值的空间
    for ii = 1:(num_of_different_properties-1)
        Middle(ii) = (different_properties(ii) + different_properties(ii + 1))/2;%计算中间值
    end
    for k = 1:length(Middle)
        Small_Ent = 0;
        Small_Places_in_trainfeatures = find(Middle(k) >= trainfeatures(:,i));%找到小于等于划分点的数据小在原特征表中的位置
        for j = 1:length(different_classes)
            Small_Targets_in_Property = find(different_classes(j) == targets(Small_Places_in_trainfeatures,:));%研究属性值下，最终分类为j的样本位置
            ratio_of_small_targetj_in_property = length(Small_Targets_in_Property)/length(Small_Places_in_trainfeatures);%研究属性下，最终分类为j的样本占该属性所有样本的比例
            if ratio_of_small_targetj_in_property ~= 0
                Small_Ent = Small_Ent+(-ratio_of_small_targetj_in_property*log(ratio_of_small_targetj_in_property)/log(2));%该属性的信息熵
            end
        end
        
        Large_Ent = 0;
        Large_Places_in_trainfeatures = find(Middle(k) < trainfeatures(:,i));%找到大于等于划分点的数据小在原特征表中的位置
        for j = 1:length(different_classes)
            Large_Targets_in_Property = find(different_classes(j) == targets(Large_Places_in_trainfeatures,:));%研究属性值下，最终分类为j的样本位置
            ratio_of_large_targetj_in_property = length(Large_Targets_in_Property)/length(Large_Places_in_trainfeatures);%研究属性下，最终分类为j的样本占该属性所有样本的比例
            if ratio_of_large_targetj_in_property ~= 0
                Large_Ent = Large_Ent+(-ratio_of_large_targetj_in_property*log(ratio_of_large_targetj_in_property)/log(2));%该属性的信息熵
            end
        end
        Small_Ent = Small_Ent*(length(Small_Places_in_trainfeatures)/example_num);%调整各属性的信息熵，乘上该属性占总样本数的比例
        Large_Ent = Large_Ent*(length(Large_Places_in_trainfeatures)/example_num);%调整各属性的信息熵，乘上该属性占总样本数的比例
        Middle_Ent(k) = Small_Ent + Large_Ent;%算出该中值对应的信息熵
        Middle_Gain(k) = EntD - Middle_Ent(k);%算出该中值对应的信息增益
    end
    
    [Feature_InfoGain(i),Middle_Place_when_Max] = max(Middle_Gain);%取中间值的最大信息增益为第i个特征的信息增益，并记录下该中间值在Middle中的位置
    Middle_when_Max(i) = Middle(Middle_Place_when_Max);%记录使信息增益最大的中间值
    if Feature_InfoGain(i)>Max_InfoGain%取最大信息增益，并记录该特征的编号
        Max_InfoGain = Feature_InfoGain(i);%最大信息增益
        No_of_Max = i;%第i个特征的信息增益最大
        Corresponding_Middle = Middle_when_Max(i);%该特征对应的中间值
    end
end
