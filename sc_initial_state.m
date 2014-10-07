function [ sc0 ] = sc_initial_state( m, tpn)

% Create the initial state from the initial marking

entrans = petri_enabled_trans(m, tpn);
entransi = find(entrans>0);
d = domain_gen_inequality(entransi(1), 0, tpn.I(2, entransi(1)), tpn);
d = domain_add_inequality(d, 0, entransi(1), -tpn.I(1, entransi(1)), tpn);
for i = 2:length(entransi)
    t = entransi(i);
    
    d = domain_add_inequality(d, 0, t, -tpn.I(1, t), tpn);
    d = domain_add_inequality(d, t, 0, tpn.I(2, t), tpn);
end

sc0.m = m;
sc0.d = sortrows(d);

% sc0 = sc_pack(m, d);

end

