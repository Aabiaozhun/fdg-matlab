function [ fdg ] = rd_rule3(fdg)

i = 0;
for sci = rd_find_rule3_paths(fdg)
    i = i + 1;
    insci = fdg_input_sc(sci, fdg);
    outsci = fdg_next_sc(fdg, sci);
    e1 = get(fdg.elabel, [insci, sci]);
    e2 = get(fdg.elabel, [sci, outsci]);
    e = rd_rule3_label(e1, e2);
    
    % remove insc -- ? --> outsc
    for t = 1:size(fdg.graph, 2)
        if fdg.graph(insci, t) > 0
            k = fdg.graph(insci, t);
            outsck = fdg.outsc{k};
            if sum(outsck==outsci) > 0 % exist outsci
                outsck(outsck==outsci) = [];
                fdg.outsc{k} = outsck;
            end
        end
    end
    el = get(fdg.elabel, [insci, outsci]);
    fdg.elabel = put(fdg.elabel, [insci, outsci], [el; e]);
end

end

