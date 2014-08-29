function [ sc1 ] = sc_successor( sc, tf, pre, post, I )

% sc -- t --> sc1
% [m, d] = sc_unpack(sc);

sc1.m1 = petri_successor(sc.m, tf, pre, post);
sc1.d1 = domain_alg1_step4(sc.m, sc.d, tf, pre);

for t = petri_enabled_trans(m1, pre)
    if t ~= tf
        ind = domain_get_inequality(sc1.d1, t, 0, pre);
        sc1.d1(ind, tf) = 1;
    end
end

% Eliminate tf and transitions that are in conflict with tf
ctrans = petri_conflict_trans(tf, m, pre);
for t = find(ctrans>0)
    sc1.d1 = domain_eliminate_trans(sc1.d1, t);
end

% Add newly enabled transitions
for t = petri_newly_enable(pre, post, m, tf)
    sc1.d1 = domain_add_inequality(sc1.d1, t, 0, I(2, t));
    sc1.d1 = domain_add_inequality(sc1.d1, 0, t, -I(1, t));
end

% sc1 = sc_pack(m1, d1);
return;

end

