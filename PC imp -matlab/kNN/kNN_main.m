function final_res = kNN_main( dataset_name, ktimes, k )
% 预处理
dirctory = '../dataSet/';
dataDir = strcat(dirctory,dataset_name);
load(dataDir);
n = strcat('=' , dataset_name);
fromeName = strcat(n , ';');
toName = 'dataSet';
eval([toName fromeName])% eval()将代码转化为指令dataSet=iris_v;

dataname =  strcat('kNN_k',num2str(k),'_',dataset_name);%转存的文件名
final_res = zeros(ktimes+2,8);%记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=

% 训练与测试
for i_cv = 1:ktimes    
   % 获得数据集（最后一列为类别标记）
    testSet = dataSet(:, mod(3+i_cv, ktimes) + 1);
    trainSet = dataSet;
    trainSet(:, mod(3+i_cv, ktimes) + 1) = []; 
    train_all =[];
    test_all = [];
    for i = 1:size(trainSet,1)
        for j = 1:size(trainSet,2)
            train_all = [train_all ; trainSet{i,j}];
        end
    end
    for i = 1:size(testSet,1)
        test_all = [test_all;testSet{i}];
    end
   % 测试
   [vec_res] = kNN_test(test_all, train_all, k);
   %统计一轮的结果
   final_res(i_cv,:) = vec_res;    
end%for_i_cv

% 统计结果
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

% 保存结果
saveMatName = strcat('.\report\' , dataname);
save([saveMatName,'.mat'],'final_res');
end

