function [ fdgraph ] = fdg_full( m0, tpn, To, Tfc )

% compute the full fdg of a tpn

sc0 = sc_initial_state(m0, tpn);
fdgraph = fdg_init(sc0);
W = [get(fdgraph.sctoi, sc0)];

while ~isempty(W)
    sc = W(1);
    W = W(2:end);
    
    scgraph = scg(sc, tpn, To);
    [fdgraph, W] = fdg(fdgraph, scgraph, W, tpn, To, Tfc);
end

end

