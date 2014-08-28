% author: Xu Wang

function [ scg ] = scg( sc0, pre, post, I, To )

% Compute an unobservable state class graph starting from sc0.
% To is a binary vector indicates observable transitions.

scg = scg_init(sc0);
W = {sc0};

while ~isempty(W)
    w = W{1};
    W = W{2:end};
    [twm, twd] = sc_unpack(w);
    entrans = petri_enabled_trans(twm, pre);
    for i = 1:size(pre, 2)
        if entrans(i) == 1 && To(i) == 0
            if sc_is_firable(w, i, pre, I)
                suc = sc_successor(w, i, pre, post, I);
                if ~scg_exist_sc(scg, suc)
                    W{end+1} = suc;
                end
                scg = scg_add_sc(scg, w, i, suc);
            end
        end
    end
end

return;

end

