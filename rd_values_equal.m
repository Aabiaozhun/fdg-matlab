function [ eq ] = rd_values_equal( v1, v2 )

verysmall = 0.00001;

if abs(v1 - v2) <= verysmall
    eq = 1;
else
    eq = 0;
end

end

