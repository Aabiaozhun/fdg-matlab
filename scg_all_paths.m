function [ scpaths, tpaths ] = scg_all_paths(scg, src, dest)

src = get(scg.sctoi, src);
dest = get(scg.sctoi, dest);

scpaths = scg_all_sc_paths(scg, src, dest);
tpaths = scg_sc_paths_tran_paths(scpaths, scg);

end

