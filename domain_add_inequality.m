function [ d ] = domain_add_inequality(d, t1, t2, v, pre)

% Add t1 - t2 <= v to d
ineq = domain_gen_inequality(t1, t2, v, pre);
d = [d; ineq];
return;

end

