clear all;
dirctory = '../dataSet/';
dataSetName = {
    'iris_v'  
   } ;
lenRound = size(dataSetName , 1) 
for roundId = 1:lenRound
    % 加载数据集
    fileName = dataSetName{roundId} ;
    dataDir = strcat(dirctory,fileName) ;
    clc ;
    load(dataDir);
    
    n = strcat('=' , fileName);
    fromeName = strcat(n , ';');
    toName = 'dataSet';
    eval([toName fromeName])% eval()将代码转化为指令dataSet=iris_v;
    clear(fileName) ;
    % 写入结果
    postName = strcat(fileName , '.mat') ;
    saveMatName =strcat('.\report\' , postName); 
    postName = strcat(fileName , '.txt') ;
    saveFileName = strcat('.\report\' , postName) ;
    
    ktimes = 5;
    res = zeros(ktimes+2,2);
    for i_cv = 1:ktimes
        % 划分训练集和测试集
        testSet = dataSet(:, mod(3+i_cv, ktimes) + 1);
        trainSet = dataSet;
        trainSet(:, mod(3+i_cv, ktimes) + 1) = [];
        [train, test] = getTrainAndTest(trainSet, testSet);
        
        [Acc, t_train] = HK_Fuc(train , test); 
        res(i_cv,:) = [Acc t_train];
        fid=fopen(saveFileName,'a');
        fprintf('The %d cycle --- Acc: %f  --- time: %f \n' , i_cv , Acc, t_train);
        fprintf(fid,'The %d cycle --- Acc: %f  --- time: %f \n' , i_cv , Acc, t_train);
        fclose(fid);
    end
    res(ktimes+1 , :) = mean(res(1:ktimes,:)) ;%5轮交叉验证，6行纪录其均值
    res(ktimes+2 , :) = std(res(1:ktimes , :)) ;%7行纪录其方差
    fid=fopen(saveFileName,'a');
    fprintf('.......  mean AUC = %f\tstd = %f ........\n' , res(ktimes+1 , 1) , res(ktimes+2 , 1)) ;
    fprintf(fid,'.......  mean AUC = %f\tstd = %f ........\n' , res(ktimes+1 , 1) , res(ktimes+2 , 1)) ;
    fprintf('.......  mean time = %f\tstd = %f .......\n' , res(ktimes+1 , 2) , res(ktimes+2 , 2)) ;
    fprintf(fid,'....... mean time = %f\tstd = %f .......\n' , res(ktimes+1 , 2) , res(ktimes+2 , 2)) ;
    fclose(fid);
end

