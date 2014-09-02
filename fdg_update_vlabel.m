function [ fdg ] = fdg_update_vlabel( fdg, sc, Tfc )

sci = get(fdg.sctoi, sc);
next_scis = find(fdg.graph(sci, :) > 0);

sc_diag = ones(1, size(Tfc, 2)) * -1;

for si = next_scis
    elabel = get(fdg.elabel, [sci, si]);
    for f = 1:size(sc_diag, 2)
        for j = 1:size(elabel, 1)
            e = elabel{j, :};
            d = e{4};
            if sc_diag(f) == -1
                sc_diag(f) = d(f);
            elseif (sc_diag(f) == 0 && d(f) == 1)...
                    || (sc_diag(f) == 1 && d(f) == 0)
                sc_diag(f) = 2;
            end
        end
    end
end

fdg.vlabel = put(fdg.vlabel, sci, sc_diag);

end
