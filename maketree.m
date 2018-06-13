function tree = maketree(featurelabels,trainfeatures,targets,threshold)

tree=struct('pro',0,'value',-1,'child',[],'parentpro',-1,'middle',-1);
%pro是叶节点（0表示）还是内部节点（1表示）
%value如果是叶节点,则表示具体的分类结果，如果是内部节点，则表示某个特征
%parentpro如果该节点有父节点，则该值表示父节点所表示特征的具体属性值
%child表示该节点的子树数组

[example_num,feature_num] = size(trainfeatures);%样本数与特征数
different_classes = unique(targets);%筛选出不同的标签

if length(different_classes) == 1 %如果只有一个类别，则它就是这个节点的标签，返回
    tree.pro = 0;%由于只有一个类别，说明已经是叶节点，用0表示
    tree.value = different_classes;%用这个类别来代表该叶节点的分类结果
    tree.child = [];%由于是叶节点，没有子节点
    return
end

if feature_num == 0%
    H = hist(targets,length(different_classes));%以直方图形式列出
    [~,largest] = max(H);%largest为最大直方所在的位置
    tree.pro = 0;%由于没有特征可以继续分，因此是叶节点，赋值为0
    tree.value = different_classes(largest);%选择该节点所含样本最多的类别作为其结果
    tree.child = [];%由于是叶节点，没有子节点
    return
end

[Max_InfoGain,No_of_Max,Corresponding_Middle] = InfoGainCon(different_classes,targets,feature_num,example_num,trainfeatures);

if Max_InfoGain<threshold%如果剩余特征中最大的信息增益都小于我们设定的阈值
    H = hist(targets,length(different_classes));%以直方图形式列出
    [~,largest] = max(H);%largest为最大直方所在的位置
    tree.pro = 0;%最大信息增益都不符合要求，因此是叶节点，赋值为0
    tree.value = different_classes(largest);%选择该节点所含样本最多的类别作为其结果
    tree.child = [];%由于是叶节点，没有子节点
    return
end
tree.pro = 1;%否则说明该节点可继续分，是内部节点，用1表示
tv = featurelabels(No_of_Max);
tree.value = tv;%用信息增益最大的那个特征最为该节点的分类依据
tree.child = [];%子节点目前还不知道，先令为空

[Data_Splited,Target_Splited] = SplitData(trainfeatures,targets,No_of_Max,Corresponding_Middle);
fprintf('split data into %d\n',length(Data_Splited));
fprintf('according to feature %d\n',featurelabels(No_of_Max));
fprintf('the middle value is %d\n',Corresponding_Middle);
tree.middle = Corresponding_Middle;%记录该节点用于分类的中间值
featurelabels(No_of_Max) = [];%这个特征被用过了，之后就不能再用，相当于从featurelabels中删除这个特征
for i = 1:length(Data_Splited)
    disp([Data_Splited{i},Target_Splited{i}]);
%显示分类结果
end
fprintf('\n');
for i = 1:length(Data_Splited)
    New_Features = Data_Splited{i};%选取按特征分类后的第i类作为新的属性值
    New_Targets = Target_Splited{i};%新的分类结果与新的属性值相对应
    Temp_Tree = maketree(featurelabels,New_Features,New_Targets,threshold);%进行迭代
    tree.pro = 1;%表示是内部节点
    tree.value = tv;%节点所用的特征名称
    tree.child{i} = Temp_Tree;%生成第i个子树
    tree.child{i}.parentpro = i;%“子树的父节点”，也就是当前节点，用来表示当前节点的属性值
end
fprintf('\n');
end