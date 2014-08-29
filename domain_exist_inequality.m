function [ ex ] = domain_exist_inequality(d, t1, t2, tpn)

% Exists t1 - t2 <= v in d or not
A = d(:, 1:end-1);
ineq = domain_gen_equality(t1, t2, 0, tpn);
ineq = ineq(1:end-1);

ex = ismember(ineq, A, 'rows');
return;

end

