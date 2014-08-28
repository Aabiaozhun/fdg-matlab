function [ scg ] = scg_add_sc( scg, sc1, t, sc2 )

% Add sc2 to scg that sc1 -- t --> sc2. sc1 is in scg.
% If sc2 is in scg, then only add the edge.
% If t == 0, then only add sc2.

[scs, graph, itosc, sctoi] = scg_unpack(scg);
if ~scg_exist_sc(scg, sc2)
    itosc = put(itosc, count(itosc)+1, sc2);
    sctoi = put(sctoi, sc2, count(itosc));
end

if t ~= 0
    sc1i = get(sctoi, sc1);
    sc2i = get(sctoi, sc2);
    graph(sc1i, sc2i) = t;
end

scg = scg_pack(scs, graph, itosc, sctoi);

end

