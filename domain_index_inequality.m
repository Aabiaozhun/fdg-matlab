function [ ind ] = domain_index_inequality(d, t1, t2, tpn)

% Find the index of t1 - t2
% display('----IN domain_index_inequality----');


A = d(:, 1:end-1);
ineq = domain_gen_inequality(t1, t2, 0, tpn);

ineq = ineq(1:end-1);
[~, ind] = ismember(ineq, A, 'rows');


% display('----OUT domain_index_inequality----');
return;

end

