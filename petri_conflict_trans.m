function [ ctrans ] = petri_conflict_trans( t, m, pre )

% Transitions in ctrans are conflicting with t at marking m.

% enabling transitions at m
mtrans = En(m, pre);
% enable transitions when tokens in the input places of t are consumed
m1 = m - pre(:, t);
m1trans = En(m1, pre);
% compute which transitions are disabled
ctrans = mtrans - m1trans;

end

