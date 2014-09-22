function [firable] = sc_is_firable(sc, t, tpn)

% Algorithm 1 isFirable in the paper...
% [m, d] = sc_unpack(sc);

% display('----IN sc_is_firable----');

firable = 0;
fti = find(petri_enabled_trans(sc.m, tpn)>0);
if isempty(find(fti==t, 1))
    return;
end

d1 = domain_alg1_step4(sc.m, sc.d, t, tpn);
a = d1(:, 1:end-1);
b = d1(:, end);

c = zeros(size(tpn.pre, 2), 1);


% ctype = '';
% vartype = '';
% for i = 1:size(b, 1)
%     ctype = ctype + 'U';
%     vartype = vartype + 'C';
% end

% param.msglev = 0;
% 
% [~, ~, status, ~] = glpk(c, a, b, tpn.I(1, :)', tpn.I(2, :)', ctype,...
%     vartype, 1, param);

[~, ~, status, ~] = glpk(c, a, b);


% [~, ~, status] = linprog(c, a, b);


if status == 5
    firable = 1;
end

% display('----OUT sc_is_firable----');
% 
end

