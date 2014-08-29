function [ tpaths ] = scg_sc_paths_tran_paths( scpaths, scg )

% convert paths of sc to transitions

tpaths = {};
for p = 1:size(scpaths, 2)
    tp = [];
    scp = scpaths{p};
    for i = 1:size(scp, 2)-1
        tp(end+1) = scg.graph(scp(i), scp(i+1));
    end
    tpaths{end+1} = tp;
end

end

