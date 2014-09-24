function [ scpaths, tpaths ] = scg_paths( scg, src, dest )

% find all paths from src to dest in scg
% to replace scg_all_sc_paths and relevant functions

% display('---IN scg_paths---');

scpaths = {[get(scg.sctoi, src)]};
scpathpos = 1;
tpaths = {[]};
desti = get(scg.sctoi, dest);
pathstop = 0;
allpathstop = 0;

while ~all(pathstop)
    curscpath = scpaths{1};
    curscpathpos = scpathpos(1);
    scpaths = scpaths(2:end);
    scpathpos = scpathpos(2:end);
    
    curtpath = tpaths{1};
    tpaths = tpaths(2:end);
    
    curpathstop = pathstop(1);
    pathstop = pathstop(2:end);
    
    if ~curpathstop
        laststate = curscpath(curscpathpos);
        if laststate <= size(scg.graph, 1)
            nextt = find(scg.graph(laststate, :)>0);
        else
            nextt = [];
        end
        for i = nextt
            nscl = scg.graph(laststate, i);
            if ~isempty(nscl)
                for nsc = nscl
                    nonext = 0;
                    curtpath(curscpathpos) = i;
                    curscpath(curscpathpos+1) = nsc;
                    scpaths{end+1} = curscpath;
                    tpaths{end+1} = curtpath;
                    scpathpos(end+1) = curscpathpos + 1;
                    if nsc == desti
                        pathstop(end+1) = 1;
                    else
                        pathstop(end+1) = curpathstop;
                    end
                end
            end
        end
    else
        curpathstop = 1;
        scpaths{end+1} = curscpath;
        tpaths{end+1} = curtpath;
        scpathpos(end+1) = curscpathpos;
        pathstop(end+1) = curpathstop;
    end
end


% display('---OUT scg_paths---');
end

