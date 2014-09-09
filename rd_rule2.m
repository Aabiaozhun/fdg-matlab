function [ fdg, rsclist ] = rd_rule2( fdg )

rsclist = [];

W = 1:size(fdg.graph, 1);

while ~isempty(W)
    sc = W(1);
    W = W(2:end);
    
%     nsclist = unique(sort(fdg.graph(sc, fdg.graph(sc, :)>0)));
    nsclist = fdg_next_sc(fdg, sc);
    while ~isempty(nsclist)
        nsc = nsclist(1);
        nsclist(1) = [];
        [rule2sc, nsclist1, ~]...
            = rd_find_rule2_nodes(fdg, sc, nsc, nsclist, rsclist);
        if ~isempty(rule2sc)
            if ~isempty(nsclist1)
                W = [W, sc];
            end
            for i = nsclist1
                W(W==i) = [];
            end
            for i = rule2sc
                fdg = rd_modify_output_edge_head(fdg, i, nsc);
                fdg = rd_modify_input_edge_tail(fdg, i, nsc);
            end
        end
        
        rsclist = unique([rsclist, rule2sc]);
    end
end


end

