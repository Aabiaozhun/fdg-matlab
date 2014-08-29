function [ ctrans ] = petri_conflict_trans( t, m, pn )

% Transitions in ctrans are conflicting with t at marking m.

% enabling transitions at m
mtrans = petri_enabled_trans(m, pn);
% enable transitions when tokens in the input places of t are consumed
m1 = m - pn.pre(:, t);
m1trans = petri_enabled_trans(m1, pn);
% compute which transitions are disabled
ctrans = mtrans - m1trans;

end

