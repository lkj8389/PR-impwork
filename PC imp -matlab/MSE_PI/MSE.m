function  w1 = MSE(classOne, classTwo, model)
    %感知机权重学习方法
    Y = [[classOne(:,1:end-1), ones(size(classOne, 1), 1)]; [classTwo(:,1:end-1), -1*ones(size(classTwo, 1), 1)]];
    dim = size(Y(:,1:end-1), 2);
    w0 = [0.5; zeros(dim, 1)]; % 初始化w
    delta = getDelta(w0,Y);    
    iter = 0;
    while iter <= model.iterSize
        iter = iter + 1;
        if sum(abs(model.lamda*delta)) <= model.termination 
            break;
        end
        w1 = w0 + model.lamda*(delta);
        delta = getDelta(w1, Y);
        w0 = w1;
    end
    
end

function delta = getDelta(w, Y)
    feature = Y(:,1:end-1);
    label = Y(:,end);       
    I = ones(size(Y,1),1);
    Y_hat = [I, feature]; 
    delta = 2*Y_hat'*(label - Y_hat*w);
end
