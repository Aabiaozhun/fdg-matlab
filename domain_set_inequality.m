function [ d ] = domain_set_inequality(d, t1, t2, v, pre)

% Set t1 - t2 in d as t1 - t2 <= v.
% If t1 - t2 is not in d, then add it.

if domain_exist_inequality(d, t1, t2, pre)
    d = domain_del_inequality(d, t1, t2, pre);
end
d = domain_add_inequality(d, t1, t2, v, pre);
return;

end

