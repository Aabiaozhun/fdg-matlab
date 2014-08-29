function [ fdg ] = fdg_init( sc0 )

fdg.graph = sparse([0]);
fdg.itosc = put(hashtable, 1, sc0);
fdg.sctoi = put(hashtable, sc0, 1);
fdg.vlabel = hashtable;
fdg.elabel = hashtable;

end

