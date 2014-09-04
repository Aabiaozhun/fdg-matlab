function [ sclist ] = fdg_input_sc( sc, fdg )

% sc1 in sclist, then sc1 --> sc

sclist = mod(find(fdg.graph==sc), size(fdg.graph, 1));
sclist(sclist==0) = size(fdg.graph, 1);

end

