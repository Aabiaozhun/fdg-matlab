function [ trans ] = sc_firable_trans( sc, tpn, I )

% Transitions that are firable at sc
% [m, d] = sc_unpack(sc);
entrans = petri_enabled_trans(sc.m, tpn);
trans = [];
for t = find(entrans>0)
    if sc_is_firable(sc, t, tpn, I)
        trans = [trans, t];
    end
end

return;

end

