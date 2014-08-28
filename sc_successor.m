function [ sc1 ] = sc_successor( sc, tf, pre, post, I )

% sc -- t --> sc1
[m, d] = sc_unpack(sc);

m1 = petri_successor(m, tf, pre, post);
d1 = domain_alg1_step4(m, d, tf, pre);

for t = petri_enabled_trans(m1, pre)
    if t ~= tf
        ind = domain_get_inequality(d1, t, 0, pre);
        d1(ind, tf) = 1;
    end
end

% Eliminate tf and transitions that are in conflict with tf
ctrans = petri_conflict_trans(tf, m, pre);
for t = find(ctrans>0)
    d1 = domain_eliminate_trans(d1, t);
end

% Add newly enabled transitions
for t = petri_newly_enable(pre, post, m, tf)
    d1 = domain_add_inequality(d1, t, 0, I(2, t));
    d1 = domain_add_inequality(d1, 0, t, -I(1, t));
end

sc1 = sc_pack(m1, d1);
return;

end

