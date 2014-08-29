function [firable] = sc_is_firable(sc, t, tpn, I)

% Algorithm 1 isFirable in the paper...
% [m, d] = sc_unpack(sc);

firable = 0;
if isempty(find(petri_enabled_trans(sc.m, tpn)==t, 1))
    return;
end

d1 = domain_alg1_step4(sc.m, sc.d, t, tpn);
a = d1(:, 1:end-1);
b = d1(:, end);

c = zeros(1, size(b, 2));

ctype = '';
vartype = '';
for i = 1:length(b, 2)
    ctype = ctype + 'U';
    vartype = vartype + 'C';
end

param.msglev = 0;

[~, ~, status, ~] = glpk(c, a, b, I(1, :)', I(2, :)', ctype,...
    vartype, 1, param);

if status == 3
    return;
else
    firable = 1;
    return;
end

end

