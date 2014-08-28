function [ scg ] = scg( sc0, pre, post, I, To )

scg = scg_init(sc0);
W = {sc0};

while ~isempty(W)
    w = W{1};
    W = W{2:end};
    [twm, twd] = sc_unpack(w);
    entrans = petri_enabled_trans(twm, pre);
    for i = 1:size(pre, 2)
        
    end
end

end

