function [ satisfy ] = rd_indistinguishable( e1, e2 )

% 

to1 = e1{1};
to2 = e2{1};
I1 = e1{2};
I2 = e2{2};

if to1 == to2 && rd_values_equal(I1(1), I2(1))...
        && rd_values_equal(I1(2), I2(2))
    satisfy = 1;
else
    satisfy = 0;
end

end

