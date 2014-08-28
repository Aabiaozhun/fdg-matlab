function [ equal ] = domain_is_equal( d1, d2 )

% Two domains are the same or not

if (size(d1, 1) ~= size(d2, 1))
    equal = 0;
    return;
end

% Compare column by column
while ~isempty(d1)
    d1 = sortrows(d1, 1);
    d2 = sortrows(d2, 1);
    d1_1 = d1(:, 1);
    d2_1 = d2(:, 1);
    if ~isempty(find((d1_1==d2_1)==0, 1))
        equal = 0;
        return;
    end
    d1 = d1(:, 2:end);
    d2 = d2(:, 2:end);
end

equal = 1;
return;

end

