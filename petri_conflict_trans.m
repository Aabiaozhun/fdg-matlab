function [ ctrans ] = petri_conflict_trans( t, m, pn )

% Transitions in ctrans are conflicting with t at marking m.

% display('----IN petri_conflict_trans----');

% enabling transitions at m
mtrans = petri_enabled_trans(m, pn);

m1 = m - pn.pre(:, t);
m1trans = petri_enabled_trans(m1, pn);
% % enable transitions when tokens in the input places of t are consumed
% m1 = m - pn.pre(:, t);
% m1trans = petri_enabled_trans(m1, pn);
% % compute which transitions are disabled
% 
% ctrans = mtrans - m1trans;

% Input places of t
pin = find(pn.pre(:, t)>0)';
% Output transitions of pin
tout = [];
for i = pin
    tout = [tout, find(pn.pre(i, :)>0)];
end
tout = unique(tout);
% Transitions in tout which were enabled at m
ctrans = zeros(1, size(pn.pre, 2));
for t1 = tout
    if m1trans(t1) == 0
        ctrans(t1) = mtrans(t1);
    end
end
% ctrans(t) = 0;

% display('----OUT petri_conflict_trans----');
end

