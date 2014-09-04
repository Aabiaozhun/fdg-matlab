function [ d ] = rd_merge_D( d1, d2 )

d = d1;
for i = 1:size(d, 2)
    if d1(i) ~= d2(i)
        d(i) = 2;
    end
end

end

