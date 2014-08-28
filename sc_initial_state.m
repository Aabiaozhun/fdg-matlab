function [ sc0 ] = sc_initial_state( m, pre, I )

% Create the initial state from the initial marking

entrans = petri_enabled_trans(m, pre);
d = domain_gen_inequality(entrans(1), 0, I(2, entrans(1)));
d = domain_add_inequality(d, 0, entrans(1), -I(1, entrans(1)));

for i = 2:length(entrans)
    t = entrans(i);
    d = domain_add_inequality(d, 0, t, -I(1, t));
    d = domain_add_inequality(d, t, 0, I(2, t));
end

sc0 = sc_pack(m, d);

end

