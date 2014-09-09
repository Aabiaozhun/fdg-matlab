function [ rule3sc ] = rd_find_rule3_paths( fdg )

rule3sc = [];
W = 1:size(fdg.graph, 1);

i = 0;
for sci = W
    i = i + 1;
    inputsclist = fdg_input_sc(sci, fdg);
    outputsclist = fdg_next_sc(fdg, sci);
    if size(inputsclist, 2) == 1 && size(outputsclist, 2) == 1
        ie = get(fdg.elabel, [inputsclist, sci]);
        oe = get(fdg.elabel, [sci, outputsclist]);
        if size(ie, 1) == 1 && size(oe, 1) == 1
            if isequal(ie{4}, oe{4})
                rule3sc = [rule3sc, sc];
            end
        end
    end
end

