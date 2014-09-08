function [ fdgraph, W ] = fdg(fdgraph, scg, W, tpn, To, Tfc)

% Construct FDG based on a SCG
% This function does not diagnose on FDG. Diag is for diagnosis on a FDG.
% Use DiagnosisFDG for constructing the FDG and diagnosing on it.

debug = 0;

if debug
    display('---IN fdg---');
end

Dnormal = zeros(1, length(Tfc));
% [~, graph, itosc, sctoi] = scg_unpack(scg);
sc0 = get(scg.itosc, 1);
% [sc0m, sc0d] = sc_unpack(sc0);

xi = 1;
all_sc = scg_all_sc(scg);
for sci = 1:size(all_sc, 1)
    scu = all_sc{sci};
    xi = xi + 1;
    % entrans is a list of index
    entrans = find(petri_enabled_trans(scu.m, tpn)>0);
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
                inflag = scg_exist_sc(fdgraph, scm);
                fdgraph = fdg_add_sc(fdgraph, sc0, t, scm);
                if ~inflag
                    W(end+1) = get(fdgraph.sctoi, scm);
                end
                [gl, gu] = fdg_firing_domain({scu}, t, tpn);
                fdgraph = fdg_add_edge_label(fdgraph, sc0, scm, [gl, gu],...
                    t, tpn, To, Tfc);
            end
        else
            [scpaths, tpaths] = scg_all_paths(scg, sc0, scu);
            for j = 1:size(scpaths, 2)
                scsigma = scpaths{j};
                tsigma = tpaths{j};
                for t = fireto
                    scm = sc_successor(scu, t, tpn);
                    inflag = scg_exist_sc(fdgraph, scm);
                    fdgraph = fdg_add_sc(fdgraph, sc0, t, scm);
                    if ~inflag
                        W(end+1) = get(fdgraph.sctoi, scm);
                    end
                    [gl, gu] = fdg_firing_domain(scsigma, [tsigma t], tpn);
                    fdgraph = fdg_add_edge_label(fdgraph, sc0, scm, [gl, gu],...
                        [tsigma t], tpn, To, Tfc);
                end
            end
        end
    end
    %     fdgraph.graph
end

fdgraph = fdg_update_vlabel(fdgraph, sc0, Tfc);

%necessary?
W = unique(W);

if debug
    display('---OUT fdg---');
end
end

