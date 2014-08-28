function [ ind ] = domain_index_inequality(d, t1, t2, pre)

% Find the index of t1 - t2
A = d(:, 1:end-1);
ineq = domain_gen_equality(t1, t2, 0, pre);
ineq = ineq(1:end-1);
[~, ind] = ismember(ineq, A, 'rows');
return;

end

