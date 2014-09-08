function [ tlist ] = fdg_get_edge(fdg, sc1i, sc2i)

% return sc1i -- t --> sc2i
% for fdg.outsc
tlist = [];
sc1irow = fdg.graph(sc1i, :);
for i = 1:size(sc1irow, 2)
    if i > 0
        sc1iouti = fdg.outsc{sc1irow(i)};
        if ~isempty(find(sc1iouti==sc2i, 1))
            tlist = [tlist, i];
        end
    end
end

end

