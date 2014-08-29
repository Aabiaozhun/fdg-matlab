function [ d ] = domain_del_inequality(d, t1, t2, tpn)

% Delete t1 - t2 from d
ind = domain_index_inequality(d, t1, t2, tpn);
d = [d(1:ind-1, :); d(ind+1:end, :)];
return;

end

