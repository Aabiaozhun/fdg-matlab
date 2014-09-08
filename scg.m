% author: Xu Wang

function [ g ] = scg( sc0, tpn, To )

% Compute an unobservable state class graph starting from sc0.
% To is a binary vector indicates observable transitions.

g = scg_init(sc0);
W = {sc0};

while ~isempty(W)
    x = scg_all_sc(g);
    w = W{1};
    W = W(2:end);
    entrans = petri_enabled_trans(w.m, tpn);
    for i = 1:size(tpn.pre, 2)
        if entrans(i) == 1 && To(i) == 0
            if sc_is_firable(w, i, tpn)
                suc = sc_successor(w, i, tpn);
                if ~scg_exist_sc(g, suc)
                    W{end+1} = suc;
                end
                g = scg_add_sc(g, w, i, suc);
            end
        end
    end
%     display(count(g.itosc));
end

return;

end

