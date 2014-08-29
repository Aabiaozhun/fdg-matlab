function [ d ] = domain_add_inequality(d, t1, t2, v, tpn)

% Add t1 - t2 <= v to d
ineq = domain_gen_inequality(t1, t2, v, tpn);
d = [d; ineq];
return;

end

