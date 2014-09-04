function [ e ] = rd_merge_indist_edges( e1, e2 )

e = {};
e{1} = e1{1};
e{2} = e1{2};
e{3} = []; % firing count vector
e{4} = rd_merge_D(e1{4}, e2{4});


end

