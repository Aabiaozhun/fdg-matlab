function [ fdg ] = fdg_init( sc0 )


% fdg.graph is a sc x transition graph
% fdg.graph(i, j) = k means sci -- j --> sck
fdg.graph = sparse([0]);
fdg.itosc = put(hashtable, 1, sc0);
fdg.sctoi = put(hashtable, sc0, 1);
fdg.vlabel = hashtable;
fdg.elabel = hashtable;
fdg.edges = hashtable;

end

