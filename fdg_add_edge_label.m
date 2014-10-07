function [ fdg ] =...
    fdg_add_edge_label(fdg, sc1, sc2, domain, sigma, tpn, To, Tfc)

% Compute the observable transition and diagnosis information and associte
% them with the edge in fdg.elabel

to = intersect(sigma, find(To>0));

D = zeros(1, size(Tfc, 2));
for i = 1:size(Tfc, 2)
    if ~isempty(intersect(Tfc{i}, sigma))
        D(i) = 1;
    end
end

vsigma = zeros(1, size(tpn.pre, 2));
for i = sigma
    vsigma(i) = vsigma(i) + 1;
end

sc1i = get(fdg.sctoi, sc1);
sc2i = get(fdg.sctoi, sc2);
v = get(fdg.elabel, [sc1i, sc2i]);
v = [v; {to, domain, vsigma, D, sigma}];
fdg.elabel = put(fdg.elabel, [sc1i, sc2i], v);

end

