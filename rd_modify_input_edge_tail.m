function [ fdg ] = rd_modify_input_edge_tail( fdg, sc1i, sc2i )

insclist = mod(find(fdg.graph==sc2i), size(fdg.graph, 1));
insclist(insclist==0) = size(fdg.graph, 1);

sc2 = get(fdg.itosc, sc2i);

for i = insclist
    elist = get(fdg.elabel, [i, sc1i]);
    elist2 = get(fdg.elabel, [i, sc2i]);
    fdg.elabel = put(fdg.elabel, [i, sc2i], [elist; elist2]);
    
    tolist = [];
    for j = 1:size(elist, 1)
        elistj = elist(j, :);
        tolist = [tolist, elistj{1}];
    end
    sci = get(fdg.itosc, i);
    for j = tolist
        fdg = fdg_add_sc(fdg, sci, j, sc2);
    end
end

end

