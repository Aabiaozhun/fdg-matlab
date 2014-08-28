function [ d ] = domain_eliminate_trans(d, tf)

% Eliminate the transition tf from domain d using fourier-Moxxxx method

d1 = domain_exchange_trans(d, 1, tf);
A = d1(:, 1:end-1);
b = d1(:, end);
nvar = size(b, 2) - 1;
[A, b] = fourmotz(A, b, nvar);
A = [zeros(size(A, 1)), A];
d = domain_exchange_trans(d1, 1, tf);

end

