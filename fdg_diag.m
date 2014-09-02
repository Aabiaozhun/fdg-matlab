function [ Dw, S ] = fdg_diag( fdg, S, tj, delta, Tfc )

Sf = hashtable;
Dempty = ones(1, size(Tfc, 2)) * -1;
Dw = Dempty;

[Ssclist, ~] = dump(S);
verysmall = 0.00001;

for i = 1:size(Ssclist, 1)
    % sc is an index
    sc = Ssclist{i};
    Dsc = get(S, sc);
    
    sctlist = find(fdg.graph(sc, :)==tj);
    while ~isempty(sctlist)
        sct = sctlist(1);
        sctlist = sctlist(2:end);
        
        elabels = get(fdg.elabel, [sc, sct]);
        
        Dsct = Dempty;
        Dtosct = Dempty;
        
        Dsctall = Dempty;
        for j = 1:size(elabels, 1)
            elabelj = elabels(j, :);
            Ito = elabelj{2};
            fto = elabelj{1};
            dsigma = elabelj{4};
            esigma = elabelj{3};
            if Ito(1) - verysmall <= delta...
                    && delta <= Ito(2) + verysmall
                for tfi = 1:size(Tfc, 2)
                    tfs = Tfc{tfi};
                    if sum(esigma(tfs)) > 0
                        if Dtosct(tfi) == -1 || Dtosct(tfi, 2) == 1
                            Dtosct(tfi) = 1;
                        else
                            Dtosct(tfi) = 2;
                        end
                    else
                        if Dtosct(tfi) == -1 || Dtosct(tfi) == 0
                            Dtosct(tfi) = 0;
                        else
                            Dtosct(tfi) = 2;
                        end
                    end
                end
            end
        end
        for tfi = 1:size(Tfc, 2)
            if Dsc(tfi) == 1 || Dtosct(tfi) == 1
                Dsct(tfi) = 1;
            elseif Dsct(tfi) == 0 && Dtosct(tfi) == 0
                Dsct(tfi) = 0;
            else
                Dsct(tfi) = 2;
            end
            
            if Dsct(tfi) == 1
                Dsctall(tfi) = 1;
            else
               
                sctvlabel = get(fdg.vlabel, sct);
                if sctvlabel(tfi) == 0
                    firetfs = 0;
                    notfiretfs = 1;
                elseif sctvlabel(tfi) == 1
                    firetfs = 1;
                    notfiretfs = 0;
                else
                    firetfs = 1;
                    notfiretfs = 1;
                end
                if firetfs == 0 && notfiretfs == 1
                    Dsctall(tfi) = 0;
                elseif firetfs == 1 && notfiretfs == 1
                    Dsctall(tfi) = 2;
                else
                    Dsctall(tfi) = 1;
                end
            end
            if Dw(tfi) == -1
                Dw(tfi) = Dsctall(tfi);
            elseif Dw(tfi) ~= Dsctall(tfi)
                Dw(tfi) = 2;
            end
        end
        Sf = put(Sf, sct, Dsct);
    end
end

return;
end

