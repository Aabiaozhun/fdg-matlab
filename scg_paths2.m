function [ rscpaths, rtpaths ] = scg_paths2( scg, src )

% find all paths from src to all state classes in scg
% to replace scg_all_sc_paths and relevant functions

% display('---IN scg_paths---');

scpaths = {[get(scg.sctoi, src)]};
tpaths = {[]};

rscpaths = {scpaths{1}};
rtpaths = {tpaths{1}};

while ~isempty(scpaths)
    curscpath = scpaths{1};
    scpaths = scpaths(2:end);
    
    curtpath = tpaths{1};
    tpaths = tpaths(2:end);
    
    
    laststate = curscpath(end);
    if laststate <= size(scg.graph, 1)
        nextt = find(scg.graph(laststate, :)>0);
    else
        nextt = [];
    end
    for i = nextt
        nscl = scg.graph(laststate, i);
        if ~isempty(nscl)
            for nsc = nscl
                ntpath = curtpath;
                ntpath(end+1) = i;
                nscpath = curscpath;
                nscpath(end+1) = nsc;
                scpaths{end+1} = nscpath;
                tpaths{end+1} = ntpath;
                
                rscpaths{end+1} = nscpath;
                rtpaths{end+1} = ntpath;
                
%                 
%                 curtpath(curscpathpos) = i;
%                 curscpath(curscpathpos+1) = nsc;
%                 scpaths{end+1} = curscpath;
%                 tpaths{end+1} = curtpath;
%                 scpathpos(end+1) = curscpathpos + 1;
%                 
%                 rscpaths{end+1} = curscpath;
%                 rtpaths{end+1} = curtpath;
            end
        end
    end
end


% display('---OUT scg_paths---');
end

