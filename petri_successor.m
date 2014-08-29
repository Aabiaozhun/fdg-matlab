function [ m1 ] = petri_successor( m, t, pn )

% m [ t > m1

m1 = m - pn.pre(:, t) + pn.post(:, t);

end

