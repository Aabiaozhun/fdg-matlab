% author: Xu Wang (xuwang@unizar.es)

function [newentrans] = petri_newly_enable(pre, post, m, tf)
%
% Compute new enabled transitions after firing tf, which is new enabled at m1
% m[tf>m1
%

sizepre = size(pre);
newentrans = zeros(1, sizepre(2));

m1 = m - pre(:, tf) + post(:, tf);
[m1entrans] = petri_enabled_trans(m1, pre);
m2 = m1 - post(:, tf);


for i = 1:1:sizepre(2)
    if m1entrans(i) == 1
        for j = 1:1:sizepre(1)
            if pre(j, i) > 0 && m(j) > m2(j)
                newentrans(i) = 1;
            elseif pre(j, i) > 0 && m1(j) > m2(j)
                newentrans(i) = 1;
            end
        end
    end
end

end