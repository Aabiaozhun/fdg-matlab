function [ sclist ] = fdg_input_sc( sc, fdg )

% sc1 in sclist, then sc1 --> sc
% 
% sclist = mod(find(fdg.graph==sc), size(fdg.graph, 1));
% sclist(sclist==0) = size(fdg.graph, 1);
% 

% with fdg.outsc

sclist = [];
for i = 1:size(fdg.outsc, 2)
    outi = fdg.outsc{i};
    if sum(outi==sc) > 0
        insc = mod(find(fdg.graph==i, 1), size(fdg.graph, 1));
        sclist = [sclist, insc];
    end
end

sclist = sort(unique(sclist));

end

