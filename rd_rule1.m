function [ rfdg ] = rd_rule1( fdg )

% The first reduction rule.

W = 1:size(fdg.graph, 1);
flag = 1;

while ~isempty(W)
    sc = W(1);
    W = W(2:end);
    
    nsclist = unique(sort(fdg.graph(sc, fdg.graph(sc, :)>0)));
    i = 0;
    for nsc = nsclist
        i = i + 1;
        
    end
end

end

