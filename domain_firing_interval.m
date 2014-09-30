function [ tl, tu ] = domain_firing_interval( d, t, I )

f = zeros(1, size(d, 2)-1);
A = d(:, 1:end-1);
b = d(:, end);


% tl
f(t) = 1;
[~, tl, ~, ~] = glpk(f, A, b);
% [~, tl, ~, ~] = linprog(f, A, b);

% tu
f(t) = -1;
[~, tu, ~, ~] = glpk(f, A, b);
% [~, tu, ~, ~] = linprog(f, A, b);
tu = -tu;

return;

end

