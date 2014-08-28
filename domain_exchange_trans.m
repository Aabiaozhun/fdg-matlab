function [d] = domain_exchange_trans(d, ti, tj)

% Exchange the columns according to ti and tj

if ti == tj
    return;
end

temp = d(:, ti);
d(:, ti) = d(:, tj);
d(:, tj) = temp;
return;

end

