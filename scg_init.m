function [ scg ] = scg_init( sc0 )

% Initialize a scg with the initial sc.

scs = {};
graph = sparse([0]);
itosc = hashtable;
itosc = put(itosc, 1, sc0);
sctoi = hashtable;
sctoi = put(sctoi, sc0, 1);

scg = scg_pack(scs, graph, itosc, sctoi);

end

