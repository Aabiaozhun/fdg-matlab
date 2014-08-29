function [d] = domain_alg1_step4(m, d, tf, tpn)

% Alg. 1 Step. 4 of the paper Efficient Reachability Analysis for Time
% Petri Nets

for t = petri_enabled_trans(m, tpn)
    if t ~= tf
        d = domain_add_inequality(d, tf, t, 0, tpn);
    end
end

end

