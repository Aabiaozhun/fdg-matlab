function [rule4sc, nsclist1, elist]...
    = rd_find_rule4_nodes( fdg, sci, sc1i, nsclist, rsclist )

rule4sc = [];
nsclist1 = [];
elist = {};

escsc1 = get(fdg.elabel, [sc1i, sci]);

while ~isempty(nsclist)
    nsc = nsclist(1);
    nsclist(1) = [];
    
    if sum(rsclist==nsc) > 0
        continue;
    end
    
    escnsc = get(fdg.elabel, [nsc, sci]);
    allindist = 1;
    i = 1;
    if size(escnsc, 1) ~= size(escsc1, 1)
        continue;
    end
    
    while i <= size(escsc1, 1) && allindist
        escsc1i = escsc1(i, :);
        for j = 1:size(escnsc, 1)
            escnscj = escnsc(j, :);
            if ~rd_indistinguishable(escsc1i, escnscj)
                allindist = 0;
            end
        end
        i = i + 1;
    end
    
    insclist = fdg_next_sc(fdg, nsc);
    if allindist && size(insclist, 2) == 1
        rule4sc = [rule4sc, nsc];
        elist = [elist; escnsc];
    else
        nsclist1 = [nsclist1, nsc];
    end
end

end

