function [ fdg ] =...
    fdg_reset_edge_label(fdg, sc1, sc2, domain, sigma, tpn, To, Tfc)

fdg.elabel = put(fdg.elabel, [sc1, sc2], []);
fdg = fdg_add_edge_label(fdg, sc1, sc2, domain, sigma, tpn, To, Tfc);

end

