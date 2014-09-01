function [ d ] = domain_eliminate_trans(d, tf)

% Eliminate the transition tf from domain d using fourier-Moxxxx method

% display('----IN domain_eliminate_trans----');


d1 = domain_exchange_trans(d, 1, tf);

A = d1(:, 1:end-1);
b = d1(:, end);
nvar = size(A, 2) - 1;
[A, b] = fourmotz(A, b, nvar);
A = [zeros(size(A, 1), 1), A];
d2 = domain_exchange_trans(A, 1, tf);

d = [];
for i = 1:size(d2, 1)
    if ~all(~d2(i, :))
        d = [d; [d2(i, :), b(i)]];
    end
end


% display('----OUT domain_eliminate_trans----');
end

