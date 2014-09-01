function [ sc1 ] = sc_successor( sc, tf, tpn )

% display('-----IN sc_successor----');

% sc -- t --> sc1
% [m, d] = sc_unpack(sc);


sc1.m = petri_successor(sc.m, tf, tpn);
sc1.d = domain_alg1_step4(sc.m, sc.d, tf, tpn);

for t = find(petri_enabled_trans(sc.m, tpn)>0)
    if t ~= tf
        ind = domain_get_inequality(sc1.d, t, 0, tpn);
        sc1.d(ind, tf) = 1;
    end
end


% Eliminate tf and transitions that are in conflict with tf
ctrans = petri_conflict_trans(tf, sc.m, tpn);
for t = find(ctrans>0)
    sc1.d = domain_eliminate_trans(sc1.d, t);
end
sc1.d = domain_eliminate_trans(sc1.d, tf);

% Add newly enabled transitions
for t = find(petri_newly_enable(tpn, sc.m, tf)>0)
    sc1.d = domain_add_inequality(sc1.d, t, 0, tpn.I(2, t), tpn);
    sc1.d = domain_add_inequality(sc1.d, 0, t, -tpn.I(1, t), tpn);
end

sc1.d = sortrows(sc1.d);

% display('-----OUT sc_successor-----');
% sc1 = sc_pack(m1, d1);
return;

end

