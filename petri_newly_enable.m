% author: Xu Wang (xuwang@unizar.es)

function [newentrans] = petri_newly_enable(pn, m, tf)
%
% Compute new enabled transitions after firing tf, which is new enabled at m1
% m[tf>m1
%

% display('----IN petri_newly_enable---');

sizepre = size(pn.pre);
newentrans = zeros(1, sizepre(2));

mentrans = petri_enabled_trans(m, pn);
m1 = m - pn.pre(:, tf) + pn.post(:, tf);
[m1entrans] = petri_enabled_trans(m1, pn);
% m2 = m1 - pn.post(:, tf);
% m2entrans = petri_enabled_trans(m2, pn);


% for i = 1:1:sizepre(2)
%     if m1entrans(i) == 1
%         for j = 1:1:sizepre(1)
%             if pn.pre(j, i) > 0 && m(j) > m2(j)
%                 newentrans(i) = 1;
%             elseif pn.pre(j, i) > 0 && m1(j) > m2(j)
%                 newentrans(i) = 1;
%             end
%         end
%     end
% end

for i = 1:size(pn.pre, 2)
    if m1entrans(i) == 1 && i ~= tf
        if mentrans(i) == 0
            newentrans(i) = 1;
        end
    end
end

if m1entrans(tf) == 1
    newentrans(tf) = 1;
end

% display('----OUT petri_newly_enable----');
end
