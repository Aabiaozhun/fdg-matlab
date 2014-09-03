function [ fdg ] = fdg_add_sc( fdg, sc1, t, sc2 )

% Add sc2 to scg that sc1 -- t --> sc2. sc1 is in scg.
% If sc2 is in scg, then only add the edge.


% display('----IN fdg_add_sc----');


if ~scg_exist_sc(fdg, sc2)
    fdg.itosc = put(fdg.itosc, count(fdg.itosc)+1, sc2);
    fdg.sctoi = put(fdg.sctoi, sc2, count(fdg.itosc));
end

sc2i = get(fdg.sctoi, sc2);
sc1i = get(fdg.sctoi, sc1);
fdg.graph(sc1i, t) = sc2i;


% display('----OUT fdg_add_sc----');

end

