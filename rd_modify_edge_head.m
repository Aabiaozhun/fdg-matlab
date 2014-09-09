function [ fdg ] = rd_modify_edge_head(fdg, sc11i, sc12i, sc2i)

% from sc11 -> sc2 to sc12 -> sc2

sc11sc2 = get(fdg.elabel, [sc11i, sc2i]);
sc12sc2 = get(fdg.elabel, [sc12i, sc2i]);
fdg.elabel = put(fdg.elabel, [sc12i, sc2i], [sc11sc2; sc12sc2]);

tolist = zeros(1, size(sc11sc2, 1));
for i = 1:size(sc11sc2, 1)
    ei = sc11sc2(i, :);
    tolist(i) = ei{1};
end
tolist = unique(tolist);

for to = tolist
    if fdg.graph(sc12i, to) > 0
        sc12to = fdg.outsc{fdg.graph(sc12i, to)};
    else
        sc12to = [];
    end
    exist = 0;
    for j = sc12to
        if j == sc2i
            exist = 1;
        end
    end
    if ~exist
        sc12to = [sc12to, sc2];
    end
    for j = sc12to
        fdg = fdg_add_sc(fdg, sc12, to, j);
    end
end

end

