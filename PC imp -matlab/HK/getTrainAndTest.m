function [train test] = getTrainAndTest(trainSet, testSet) % train是cell类型 test是矩阵类型
    [totalClass, section] = size(trainSet);
    test=[];
    for i = 1:totalClass % 将testSet竖着连起来
        test = [test; testSet{i, 1}];
    end
    for i = 1:totalClass
        col_train = [];
        for j = 1:section
            col_train = [col_train; trainSet{i, j}];
        end
        train{1, i} = col_train;% 将trainSet的特征竖着连起来
    end
end