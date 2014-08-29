function [ fdg, W ] = fdg(fdg, scg, W, tpn, To, Tfc)

% Construct FDG based on a SCG
% This function does not diagnose on FDG. Diag is for diagnosis on a FDG.
% Use DiagnosisFDG for constructing the FDG and diagnosing on it.

Dnormal = zeros(1, length(Tfc));

% [~, graph, itosc, sctoi] = scg_unpack(scg);
sc0 = get(scg.itosc, 1);
% [sc0m, sc0d] = sc_unpack(sc0);

xi = 1;
for scu = scg_all_sc(scg)
    xi = xi + 1;
%     [scum, scud] = sc_unpack(scu);
    % entrans is a list of index
    entrans = find(petri_enabled_trans(scu.m, tpn));
    % enabled observable transitions
    ento = intersect(find(To>0), entrans);
    if ~isempty(ento)
        fireto = [];
        for t = ento
            if sc_is_firable(scu, t, tpn)
                fireto = [fireto, t];
            end
        end
        
        if sc_is_equal(sc0, scu)
            Dsigma = Dnormal;
            for t = fireto
                scm = sc_successor(scu, t, tpn);
                if ~scg_exist_sc(fdg, scm)
                    fdg = scg_add_sc(fdg, sc0, t, scm);
                    W{end+1} = scm;
                end
                [gl, gu] = fdg_firing_domain(scu, t, tpn);
                fdg = fdg_add_edge_label(fdg, sc0, scu, [gl, gu],...
                    t, tpn, To, Tfc);
            end
        else
            [scpaths, tpaths] = scg_all_paths(scg, sc0, scu);
            for j = 1:size(scpaths, 2)
                scsigma = scpaths{j};
                tsigma = tpaths{j};
                for t = fireto
                    scm = sc_successor(scu, t, tpn);
                    if ~scg_exist_sc(fdg, scm)
                        fdg = scg_add_sc(fdg, sc0, t, scm);
                        W{end+1} = scm;
                    end
                    [gl, gu] = fdg_firing_domain(scsigma, [tsigma t], tpn);
                    fdg = fdg_add_edge_label(fdg, sc0, scu, [gl, gu],...
                        [tsigma t], tpn, To, Tfc);
                end
            end
        end
    end
end

end

