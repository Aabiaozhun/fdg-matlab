function [ equal ] = sc_is_equal( sc1, sc2 )

% Two scs are equal if their markings and domains are the same,
% respectively.

[m1, d1] = sc_unpack(sc1);
[m2, d2] = sc_unpack(sc2);

equal = (isempty(find((m1==m2)==0, 1))) && domain_is_equal(d1, d2);

return;

end

