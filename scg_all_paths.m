function [ scpaths, tpaths ] = scg_all_paths(scg, src, dest)

src = get(scg.sctoi, src);
dest = get(scg.sctoi, dest);


scpathsi = scg_all_sc_paths(scg, src, dest);
tpaths = scg_sc_paths_tran_paths(scpathsi, scg);

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

