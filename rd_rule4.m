function [ fdg ] = rd_rule4( fdg )

W = 1:size(fdg.graph, 1);
rsclist = [];

while ~isempty(W)
    sci = W(1);
    W(1) = [];
    
    nsclist = fdg_input_sc(sci, fdg);
    while ~isempty(nsclist)
        nsc = nsclist(1);
        nsclist(1) = [];
        [rule4sc, nsclist1, ~]...
            = rd_find_rule4_nodes(fdg, sci, nsc, nsclist, rsclist);
        if ~isempty(rule4sc)
            if ~isempty(nsclist1)
                W = unique([W, sc]);
            end
            for k = nsclist1
                W(W==k) = [];
            end
            for i = rule4sc
                fdg = rd_modify_output_edge_head(fdg, i, nsc);
                fdg = rd_modify_input_edge_tail(fdg, i, nsc);
            end
            rsclist = [rsclist, rule4sc];
        end
    end
    
end

rsclist = unique(rsclist);

end

