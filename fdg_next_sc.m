function [ sc2i ] = fdg_next_sc( fdg, sc1i )

% the output nodes of sc1i

% with fdg.outsc

outi = fdg.graph(sc1i, fdg.graph(sc1i, :)>0);
sc2i = unique(cell2mat(fdg.outsc(outi)));

end

