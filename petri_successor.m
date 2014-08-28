function [ m1 ] = petri_successor( m, t, pre, post )

% m [ t > m1

m1 = m - pre(:, t) + post(:, t);

end

