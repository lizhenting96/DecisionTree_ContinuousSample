function Prediction = DataClassifier(Input_Data,tree)
while tree.pro == 1%��Ȼ���м�ڵ�ʱ
    childset = tree.child;%ȡ�ӽڵ�
    v = tree.value;%��ʾ�ýڵ��õ��ĸ������ֵ���
    if Input_Data(v)<=tree.middle
        tree = childset{1};
    else
        tree = childset{2};
    end
end
Prediction = tree.value;
end