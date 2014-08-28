function [ tl, tu ] = domain_firing_interval( d, t, I )

f = zeros(1, size(d, 2)-1);
A = d(:, 1:end-1);
b = d(:, end);

% tl
f(t) = 1;
[~, tl, ~, ~] = glpk(f, A, b, I(1, :)', I(2, :)');

% tu
f(t) = -1;
[~, tu, ~, ~] = glpk(f, A, b, I(1, :)', I(2, :)');
tu = -tu;

return;

end

