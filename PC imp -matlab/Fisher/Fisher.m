function [w, b] = Fisher(classOne, classTwo)
    %Fisher权重与偏置的求解
    I_one = ones(size(classOne,1), 1);
    I_two = ones(size(classTwo,1), 1); 
    n1 = length(I_one);
    n2 = length(I_two);
    m_one = sum(classOne(:,1:end-1))/size(classOne,1);
    m_two = sum(classTwo(:,1:end-1))/size(classOne,1);
%     Sb = (m_one*w - m_two*w)'*(m_one*w - m_two*w);
    S1 = (classOne(:,1:end-1)-I_one*m_one)'*(classOne(:,1:end-1)-I_one*m_one);
    S2 = (classTwo(:,1:end-1)-I_two*m_two)'*(classTwo(:,1:end-1)-I_two*m_two);
    Sw = S1 + S2; % 类间散度  
    w = pinv(Sw)*(m_one' - m_two'); % 权重
    b = (n1*m_one*w + n2*m_two*w)/(n1+n2)*(-1); % 偏置
end

