function w1 = HK( classOne, classTwo, model )
    % HK权重优化过程
    Y = [[classOne(:,1:end-1), ones(size(classOne, 1), 1)]; -1*[classTwo(:,1:end-1), ones(size(classTwo, 1), 1)]];
    dim = size(Y(:,1:end-1), 2);
    w0 = [0.5; zeros(dim, 1)]; % 初始化w
    b0 = ones(size(Y,1), 1)*model.b; % 初始化b
    [w0, b0, e] = getWB(w0, b0, Y, model);    
    iter = 0;
    while iter <= model.iterSize
        iter = iter + 1;
        if abs(e) <= model.termination 
            break;
        end
        [w1, b1, e] = getWB(w0, b0, Y, model);
        w0 = w1;
        b0 = b1;
    end

end

function [w, b, e] = getWB(w, b, Y, model)
    I = ones(size(Y,1),1);
    Y_hat = [Y(:,end), Y(:,1:end-1)]; % 增广矩阵
    e = (Y_hat*w-b);
    b = b + 2*model.lamda*(e + abs(e));
    w = pinv(Y_hat)*b;
end


