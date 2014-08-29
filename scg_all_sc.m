function [ sclist ] = scg_all_sc( scg )

% Return all state classes in scg
% [~, ~, ~, sctoi] = scg_unpack(scg);
[sclist, ~] = dump(scg.sctoi);

end

