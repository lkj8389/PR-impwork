function [Acc, t_train] = SVM_Fuc(trainSet, testSet, C)
    totalClass = size(trainSet , 2) ;
    [lenTest , dim] = size(testSet) ;
    testLabel = testSet(:,dim) ;
    resultMat = zeros(lenTest , totalClass) ; %存放结果的矩阵为测试集长度，与类别数   
    t_train = 0 ;
    model.iterSize = 100;
    model.termination = 1e-3;
    
    
    for i = 1:totalClass-1
        classOne = trainSet{i};
        for j = i+1:totalClass          
            classTwo = trainSet{j};
            tic;    
            train_data = [classOne(:,1:end-1);classTwo(:,1:end-1)];
            train_label = [ones(size(classOne,1),1);-1*ones(size(classOne,1),1)];
%             svmStruct = svmtrain(train_data, train_label, 'kernel_function','linear','boxconstraint',C); % 线性核
            svmStruct = svmtrain(train_data, train_label, 'kernel_function','rbf','boxconstraint',C); % rbf核
            temp = svmclassify(svmStruct,testSet(:,1:end-1));   
            t = toc;
            t_train = t_train + t;
            
            %resultMat是一个测试样本数为行，类别数为列的矩阵
            indexClassOne = find(temp == 1) ;%找到判定为第一类的位置
            resultMat(indexClassOne , i) = resultMat(indexClassOne , i) + 1 ;%判定为i类，则对应i列的样本+1
            indexClassTwo = find(temp == -1) ;
            resultMat(indexClassTwo , j) = resultMat(indexClassTwo , j) + 1 ;%判定为j类，则对应j列的样本+1
        end
    end
    [~, finalClass] = max((resultMat'));
    Acc = size(find(finalClass' == testLabel),1)/lenTest;
end



