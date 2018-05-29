function [Acc, t_train] = Relaxation_Fuc(trainSet, testSet)
    totalClass = size(trainSet , 2) ;
    [lenTest , dim] = size(testSet) ;
    testLable = testSet(:,dim) ;
    resultMat = zeros(lenTest , totalClass) ; %存放结果的矩阵为测试集长度，与类别数   
    t_train = 0 ;
    model.iterSize = 100;
    model.termination = 1e-3;
    model.lamda = 0.01; % 学习步长不宜过小（要不然学习不出来）
    model.b = 0.7; % 松弛变量（随着松弛变量b（区间为[0,1]）的增大，acc先增大后减小）
    for i = 1:totalClass-1
        classOne = trainSet{i};
        for j = i+1:totalClass          
            classTwo = trainSet{j};
            tic;
            w = Relaxation(classOne, classTwo, model);
            t = toc;
            t_train = t_train + t;
            
            temp = class4test(w, testSet, lenTest);
            %resultMat是一个测试样本数为行，类别数为列的矩阵
            indexClassOne = find(temp == 1) ;%找到判定为第一类的位置
            resultMat(indexClassOne , i) = resultMat(indexClassOne , i) + 1 ;%判定为i类，则对应i列的样本+1
            indexClassTwo = find(temp == -1) ;
            resultMat(indexClassTwo , j) = resultMat(indexClassTwo , j) + 1 ;%判定为j类，则对应j列的样本+1
        end
    end
    [C, finalClass] = max((resultMat'));
    Acc = size(find(finalClass' == testLable),1)/lenTest;
end

function temp = class4test(w, testData,lenTest)
    test_set = zeros(lenTest, 1);
    I = ones(lenTest,1);
    data = [I, testData(:,1:end-1)];
    test_set = test_set + data*w;
    temp = sign(test_set);
    temp(find(temp == 0)) = 1;
end

