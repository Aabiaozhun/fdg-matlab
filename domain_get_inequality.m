function [ v ] = domain_get_inequality(d, t1, t2, pre)

% Return v of t1 - t2 <= v in d
% Check the existance of t1 - t2 before!

ind = domain_index_inequality(d, t1, t2, pre);
v = d(ind, end);
return;

end

