function [pre_label] = get_k_neighbor(mat_dist, c, k)

% 统计前k个最近的样本中类别数最多的一类的标记
% pre_label：类别标记，一个正数
% mat_dist：第一列是候选样本的距离，第二列是候选样本的类别标记
% c：类别总数
% k：近邻个数

mat_rank = sortrows(mat_dist,1); % 按照第一列（距离列）递增排序的临时矩阵，n行2列
a = mat_rank(1:k,2); % 选出前k个候选样本的类别构成列向量

vec_vote = [];
for i = 1:c % 统计每一类的候选样本个数，没有出现的类标记为0
    if isempty(find(a == i))
        vec_vote = [vec_vote;0];
    else
        vec_vote = [vec_vote;length(find(a == i))];
    end %if
end%for_i

temp_label = find(vec_vote == max(vec_vote)); % 找出最多类
if length(temp_label) > 1 % 出现并列类
    pre_label = 0;
else
    pre_label = temp_label;
end%if

end% function