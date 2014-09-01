function [ sc1 ] = sc_successor( sc, tf, tpn )

% display('-----IN sc_successor----');

% sc -- t --> sc1


sc1.m = petri_successor(sc.m, tf, tpn);
sc1.d = domain_alg1_step4(sc.m, sc.d, tf, tpn);

for i = 1:size(sc1.d, 1)
    for j = 1:size(sc1.d, 2)-1
        if j ~= tf
            if sc1.d(i, j) > 0
                sc1.d(i, tf) = sc1.d(i, tf) + 1;
            elseif sc1.d(i, j) < 0
                sc1.d(i, tf) = sc1.d(i, tf) - 1;
            end
        end
    end
end

% Eliminate tf and transitions that are in conflict with tf
ctrans = petri_conflict_trans(tf, sc.m, tpn);
sc1.d = domain_eliminate_trans(sc1.d, tf);
for t = find(ctrans>0)
    if t ~= tf
        sc1.d = domain_eliminate_trans(sc1.d, t);
    end
end



% Add newly enabled transitions
for t = find(petri_newly_enable(tpn, sc.m, tf)>0)
    sc1.d = domain_add_inequality(sc1.d, t, 0, tpn.I(2, t), tpn);
    sc1.d = domain_add_inequality(sc1.d, 0, t, -tpn.I(1, t), tpn);
end


sc1.d = sortrows(unique(sc1.d, 'rows'));

% sc_display(sc);
% display(tf);
% sc_display(sc1);

% display('-----OUT sc_successor-----');
return;

end

