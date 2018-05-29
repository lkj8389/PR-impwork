function kNN_wrap

%用来设置kNN_main函数所需要的输入变量的函数。


dataset_name = 'iris_v';
ktimes = 5; % 5FCV,fixed
k = [1;3;5;7;9];

ResultName = strcat('result' , '.txt');
saveResultName = strcat('.\' , ResultName);
for i_k = 1:length(k)
    final_res = kNN_main(dataset_name,ktimes,k(i_k));
    fid=fopen(saveResultName,'a');
    %记录ktimes轮结果的矩阵,倒数第二行存均值，最后一行存std，每一列分别是TP,FP,TN,FN,acc,均值acc，gm,auc=
    fprintf(fid,' %s \t TP = %f \t FP = %f  \t TN = %f \t FN = %f acc = %f \t m_acc = %f \t gm = %f \t auc = %f \t \n' , ...
    dataset_name , final_res(6,1), final_res(6,2), final_res(6,3) , final_res(6,4), final_res(6,5), final_res(6,6), final_res(6,7), final_res(6,8)) ;
    fclose(fid);
end%for_i_k
display('...OK')
end