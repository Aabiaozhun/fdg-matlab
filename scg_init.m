function [ scg ] = scg_init( sc0 )

% Initialize a scg with the initial sc.

scg.graph = sparse([0]);
scg.itosc = hashtable;
scg.itosc = put(scg.itosc, 1, sc0);
scg.sctoi = hashtable;
scg.sctoi = put(scg.sctoi, sc0, 1);

% scg = scg_pack(scs, graph, itosc, sctoi);

end

