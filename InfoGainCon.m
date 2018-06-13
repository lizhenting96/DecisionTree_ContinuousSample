function [Max_InfoGain,No_of_Max,Corresponding_Middle] = InfoGainCon(different_classes,targets,feature_num,example_num,trainfeatures)
pnode = zeros(1,length(different_classes));
for i = 1:length(different_classes)
    pnode(i) = length(find(targets == different_classes(i)))/length(targets);%��Ӧ�����շ�����ռ���������ı���
end
EntD = -sum(pnode.*log(pnode)/log(2));%����������Ϣ��

Max_InfoGain = -1;%����������Ϣ����
No_of_Max = -1;%�ڼ�����������Ϣ�������
Feature_InfoGain = zeros(1,feature_num);%Ԥ�������������Ϣ���涼Ϊ0
Middle_when_Max = zeros(1,feature_num);%Ԥ�������������Ϣ�������ʱ����Ӧ���м�ֵ��Ϊ0

for i = 1:feature_num
    different_properties = unique(trainfeatures(:,i));%��i�������µĲ�ͬ����ֵ����
    num_of_different_properties = length(different_properties);%��i���������ж��ٸ���ͬ������ֵ
    Middle_Ent = zeros(1,num_of_different_properties - 1);%�ܹ���num_of_different_properties - 1����ͬ���м�ֵ��Ԥ���i���м�ֵ�¸������Ե���Ϣ��Ϊ0
    Middle_Gain = zeros(1,num_of_different_properties - 1);%Ԥ������ֵ��Ϣ����Ŀռ�
    Middle = zeros(1,num_of_different_properties - 1);%Ԥ�����м�ֵ�Ŀռ�
    for ii = 1:(num_of_different_properties-1)
        Middle(ii) = (different_properties(ii) + different_properties(ii + 1))/2;%�����м�ֵ
    end
    for k = 1:length(Middle)
        Small_Ent = 0;
        Small_Places_in_trainfeatures = find(Middle(k) >= trainfeatures(:,i));%�ҵ�С�ڵ��ڻ��ֵ������С��ԭ�������е�λ��
        for j = 1:length(different_classes)
            Small_Targets_in_Property = find(different_classes(j) == targets(Small_Places_in_trainfeatures,:));%�о�����ֵ�£����շ���Ϊj������λ��
            ratio_of_small_targetj_in_property = length(Small_Targets_in_Property)/length(Small_Places_in_trainfeatures);%�о������£����շ���Ϊj������ռ���������������ı���
            if ratio_of_small_targetj_in_property ~= 0
                Small_Ent = Small_Ent+(-ratio_of_small_targetj_in_property*log(ratio_of_small_targetj_in_property)/log(2));%�����Ե���Ϣ��
            end
        end
        
        Large_Ent = 0;
        Large_Places_in_trainfeatures = find(Middle(k) < trainfeatures(:,i));%�ҵ����ڵ��ڻ��ֵ������С��ԭ�������е�λ��
        for j = 1:length(different_classes)
            Large_Targets_in_Property = find(different_classes(j) == targets(Large_Places_in_trainfeatures,:));%�о�����ֵ�£����շ���Ϊj������λ��
            ratio_of_large_targetj_in_property = length(Large_Targets_in_Property)/length(Large_Places_in_trainfeatures);%�о������£����շ���Ϊj������ռ���������������ı���
            if ratio_of_large_targetj_in_property ~= 0
                Large_Ent = Large_Ent+(-ratio_of_large_targetj_in_property*log(ratio_of_large_targetj_in_property)/log(2));%�����Ե���Ϣ��
            end
        end
        Small_Ent = Small_Ent*(length(Small_Places_in_trainfeatures)/example_num);%���������Ե���Ϣ�أ����ϸ�����ռ���������ı���
        Large_Ent = Large_Ent*(length(Large_Places_in_trainfeatures)/example_num);%���������Ե���Ϣ�أ����ϸ�����ռ���������ı���
        Middle_Ent(k) = Small_Ent + Large_Ent;%�������ֵ��Ӧ����Ϣ��
        Middle_Gain(k) = EntD - Middle_Ent(k);%�������ֵ��Ӧ����Ϣ����
    end
    
    [Feature_InfoGain(i),Middle_Place_when_Max] = max(Middle_Gain);%ȡ�м�ֵ�������Ϣ����Ϊ��i����������Ϣ���棬����¼�¸��м�ֵ��Middle�е�λ��
    Middle_when_Max(i) = Middle(Middle_Place_when_Max);%��¼ʹ��Ϣ���������м�ֵ
    if Feature_InfoGain(i)>Max_InfoGain%ȡ�����Ϣ���棬����¼�������ı��
        Max_InfoGain = Feature_InfoGain(i);%�����Ϣ����
        No_of_Max = i;%��i����������Ϣ�������
        Corresponding_Middle = Middle_when_Max(i);%��������Ӧ���м�ֵ
    end
end
