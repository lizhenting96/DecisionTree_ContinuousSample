function Prediction = DataClassifier(Input_Data,tree)
while tree.pro == 1%仍然是中间节点时
    childset = tree.child;%取子节点
    v = tree.value;%表示该节点用的哪个特征分的类
    if Input_Data(v)<=tree.middle
        tree = childset{1};
    else
        tree = childset{2};
    end
end
Prediction = tree.value;
end