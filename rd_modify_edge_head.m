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
    sc12to = fdg.graph(sc12i, 
end

end

