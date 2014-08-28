function [ trans ] = sc_firable_trans( sc, pre, I )

% Transitions that are firable at sc
[m, d] = sc_unpack(sc);
entrans = petri_enabled_trans(m, pre);
trans = [];
for t = find(entrans>0)
    if sc_is_firable(sc, t, pre, I)
        trans = [trans, t];
    end
end

return;

end

