function [ v ] = domain_get_inequality(d, t1, t2, tpn)

% Return v of t1 - t2 <= v in d
% Check the existance of t1 - t2 before!

% display('----IN domain_get_inequality----');

ind = domain_index_inequality(d, t1, t2, tpn);
v = d(ind, end);




% display('----OUT domain_get_inequality----');
return;

end

