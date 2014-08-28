function [ fdg, W ] = fdg(fdg, scg, W, pre, post, I, To, Tfc)

% Construct FDG based on a SCG
% This function does not diagnose on FDG. Diag is for diagnosis on a FDG.
% Use DiagnosisFDG for constructing the FDG and diagnosing on it.

Dnormal = zeros(1, length(Tfc));

[~, graph, itosc, sctoi] = scg_unpack(scg);
sc0 = get(itosc, 1);
[sc0m, sc0d] = sc_unpack(sc0);

xi = 1;
for scu = scg_all_sc(scg)
    xi = xi + 1;
    [scum, scud] = sc_unpack(scu);
    % entrans is a list of index
    entrans = find(petri_enabled_trans(scum, pre));
    % enabled observable transitions
    ento = intersect(find(To>0), entrans);
    if ~isempty(ento)
        fireto = [];
        for t = ento
            if sc_is_firable(scu, t, pre, I)
                fireto = [fireto, t];
            end
        end
        
    end
end

end

