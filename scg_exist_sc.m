function [ exist ] = scg_exist_sc( scg, sc )

[~, ~, ~, sctoi] = scg_unpack(scg);
if isempty(get(sctoi, sc))
    exist = 0;
else
    exist = 1;
end

return;

end

