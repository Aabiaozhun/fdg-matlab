function [ scg ] = scg_add_sc( scg, sc1, t, sc2 )

% Add sc2 to scg that sc1 -- t --> sc2. sc1 is in scg.
% If sc2 is in scg, then only add the edge.
% If t == 0, then only add sc2.

% display('----IN scg_add_sc----');


if ~scg_exist_sc(scg, sc2)
    scg.itosc = put(scg.itosc, count(scg.itosc)+1, sc2);
    scg.sctoi = put(scg.sctoi, sc2, count(scg.itosc));
    sc2i = get(scg.sctoi, sc2);
    scg.graph(sc2i, sc2i) = 0;
end

% if t ~= 0
    sc1i = get(scg.sctoi, sc1);
    sc2i = get(scg.sctoi, sc2);
    scg.graph(sc1i, t) = sc2i;
% end

% display('----OUT scg_add_sc----');

end

