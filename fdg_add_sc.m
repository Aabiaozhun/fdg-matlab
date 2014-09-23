function [ fdg ] = fdg_add_sc( fdg, sc1, t, sc2 )

% Add sc2 to scg that sc1 -- t --> sc2. sc1 is in scg.
% If sc2 is in scg, then only add the edge.

% with fdg.outsc


% display('----IN fdg_add_sc----');

if ~scg_exist_sc(fdg, sc2)
    fdg.itosc = put(fdg.itosc, count(fdg.itosc)+1, sc2);
    fdg.sctoi = put(fdg.sctoi, sc2, count(fdg.itosc));
end

sc2i = get(fdg.sctoi, sc2);
sc1i = get(fdg.sctoi, sc1);

if sc1i > size(fdg.graph, 1) || fdg.graph(sc1i, t) == 0
    fdg.graph(sc1i, t) = max(fdg.graph(:)) + 1;
    fdg.outsc{fdg.graph(sc1i, t)} = [sc2i];
else
    out = fdg.outsc{fdg.graph(sc1i, t)};
    fdg.outsc{fdg.graph(sc1i, t)} = [out, sc2i];
end

fdg.g(sc1i, sc2i) = 1;
if size(fdg.g, 1) < sc2i
    fdg.g(sc2i, 1) = 0;


% display('----OUT fdg_add_sc----');

end

