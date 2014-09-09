function [ fdg ] = rd_modify_output_edge_head(fdg, sc1i, sc2i)

% modify all output edges of sc1 to sc2

nsclist = fdg_next_sc(fdg, sc1i);
for i = nsclist
    fdg = rd_modify_edge_head(fdg, sc1i, sc2i, i);
end

end

