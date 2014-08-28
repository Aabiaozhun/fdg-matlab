function [ ineq ] = domain_gen_inequality(t1, t2, v, pre)

% Generate the inequality t1 - t2 <= v
ineq = zeros(1, size(pre, 2)+1);

if t1 == 0 && t2 == 0
    return;
else
    if t1 ~= 0
        ineq(t1) = 1;
    end
    if t2 ~= 0
        ineq(t2) = -1;
    end
    ineq(end) = v;
end

return;

end

