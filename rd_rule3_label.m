function [ e ] = rd_rule3_label( e1, e2 )

e = {};
e{end+1} = [e1{1}, e2{1}];
e{end+1} = e1{2} + e2{2};
e{end+1} = e1{3} + e2{3};
e{end+1} = e1{4};

end

