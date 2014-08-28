% author: Xu Wang (xuwang@unizar.es)

function [en_trans] = petri_enabled_trans(m, pre)
% Return enabling transitions at m
% m : marking
% pre : pre-matrix
% en_trans : a vector, its size is |T|. If t_i is enabled, en_trans(i) = 1
% The number of rows of pre must be the same of m.

sizepre = size(pre);
nt = sizepre(2); % number of transitions

en_trans = zeros(1,nt);
for i = 1:1:nt
    if m >= pre(:,i)
        en_trans(i) = 1;
    end
end
