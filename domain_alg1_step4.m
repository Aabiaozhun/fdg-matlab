function [d] = domain_alg1_step4(m, d, tf, tpn)

% Alg. 1 Step. 4 of the paper Efficient Reachability Analysis for Time
% Petri Nets

% display('----IN domain_alg1_step4----');


for t = find(petri_enabled_trans(m, tpn)>0)
    if t ~= tf
        d = domain_add_inequality(d, tf, t, 0, tpn);
    end
end

% display('----OUT domain_alg1_step4----');

end

