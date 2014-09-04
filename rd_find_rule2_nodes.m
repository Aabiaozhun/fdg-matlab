function [ rule2sc, nsclist1, elist ]...
    = rd_find_rule2_nodes( fdg, sc, sc1, nsclist, rsclist )

rule2sc = [];
nsclist1 = [];
elist = {};

escsc1 = get(fdg.elabel, [sc, sc1]);

while ~isempty(nsclist)
    nsc = nsclist(1);
    nsclist(1) = [];
    
    if ~isempty(find(rsclist==nsc, 1))
        continue;
    end
    
    escnsc = get(fdg.elabel, [sc, nsc]);
    allindist = 1;
    i = 1;
    if size(escnsc, 1) ~= size(escsc1, 1)
        continue;
    end
    
    while i <= size(escsc1, 1) && allindist
        escsc1i = escsc1(i);
        for j = 1:size(escnsc, 1)
            escnscj = escnsc(j);
            if ~rd_indistinguishable(escsc1i, escnscj)
                allindist = 0;
            end
        end
        i = i + 1;
    end
    
    insclist = fdg_input_sc(nsc, fdg);
    if allindist && size(insclist, 2) == 1
        rule2sc = [rule2sc, nsc];
        elist = [elist; escnsc];
    else
        nsclist1 = [nsclist1, nsc];
    end
end

end

