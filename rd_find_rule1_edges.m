function [ e, elist1 ] = rd_find_rule1_edges( e1, elist )

% find e2 in elist satisfy fun with e1 (indistinguishable, identical
% edges...)

% e : the list of found edge, found = ~isempty(e), not found = isempty(e)
% elist1 : remove e from elist

e = [];
elist1 = [];

for i = 1:size(elist, 1)
    ei = elist(i, :);
    if rd_indistinguishable(e1, ei)
        e = [e; ei];
    else
        elist1 = [elist1; ei];
    end
end

end

