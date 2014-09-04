function [ fdg ] = rd_rule1( fdg )

% The first reduction rule.

W = 1:size(fdg.graph, 1);
flag = 1;

while ~isempty(W)
    sc = W(1);
    W = W(2:end);
    
    nsclist = unique(sort(fdg.graph(sc, fdg.graph(sc, :)>0)));
    i = 0;
    for nsc = nsclist
        i = i + 1;
        output1 = [];
        output = get(fdg.elabel, [sc, nsc]);
        while ~isempty(output)
            e1 = output(1, :);
            [e, output] = rd_find_rule1_edges(e1, output);
            if ~isempty(e)
                for i = 2:size(e, 1)
                    e1 = rd_merge_indist_edges(e1, e(i, :));
                end
            end
            output1 = [output1; e1];
        end
        fdg = fdg_reset_edge_label(fdg, sc1, sc2, domain,...
            sigma, tpn, To, Tfc);
    end
end

end

