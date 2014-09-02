function [ scpaths, tpaths ] = scg_all_paths(scg, src, dest)


[scpathsi, tpaths] = scg_paths(scg, src, dest);

% convert index of scs in scpathsi into sc
scpaths = {};
for p = 1:size(scpathsi, 2)
    scp = {};
    scpi = scpathsi{p};
    for i = 1:size(scpi, 2)
        scp{end+1} = get(scg.itosc, scpi(i));
    end
    scpaths{end+1} = scp;
end



end

