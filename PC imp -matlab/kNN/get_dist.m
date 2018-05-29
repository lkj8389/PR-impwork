function [D] = get_dist(X,Y,n_X,n_Y)   

% 求X与Y集合中两两样本距离的函数，要求自身内部两两样本，则令X=Y
% X,Y：一行一个样本，无标号
% n_X，n_Y：X与Y总数
% D：n_X行与n_Y列的距离矩阵

    % 求欧氏距离
        D_temp = sum(X.^2,2)*ones(1,n_Y) + ones(n_X,1)*sum(Y.^2,2)' - 2*X*Y'; %||xi-xj||2
        D = sqrt(D_temp);
            
end%functionb
