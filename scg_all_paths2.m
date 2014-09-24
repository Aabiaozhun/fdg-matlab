function [ rscpaths, rtpaths ] = scg_all_paths2(scg, src)


[scpathsi, tpaths] = scg_paths2(scg, src);

% convert index of scs in scpathsi into sc
scpaths = {};

rscpaths = hashtable;
rtpaths = hashtable;

for p = 1:size(scpathsi, 2)
    scp = {};
    scpi = scpathsi{p};
    srci = scpi(1);
    for i = 1:size(scpi, 2)
        scp{end+1} = get(scg.itosc, scpi(i));
    end
    scpaths{end+1} = scp;   
    desti = scpi(end);
    srcdestscp = get(rscpaths, [srci, desti]);
    srcdestscp{end+1} = scp;
    rscpaths = put(rscpaths, [srci, desti], srcdestscp);
    srcdesttp = get(rtpaths, [srci, desti]);
    srcdesttp{end+1} = tpaths{p};
    rtpaths = put(rtpaths, [srci, desti], srcdesttp);
end



end

