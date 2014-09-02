function [ Diagoutput, time, timeupdate, timediag ] =...
    DiagnosisFDG( m0, tpn, To, Tfc, observation )


% show debug information or not
show = 1;

time = [];
timeupdate = [];
timediag = [];

Diagoutput = [];

Dw = ones(1, size(Tfc, 2)) * -1;
Dnormal = zeros(1, size(Tfc, 2));
Dempty = Dw;

tic;
sc0 = sc_initial_state(m0, tpn);
fdgraph = fdg_init(sc0);
scgraph = scg(sc0, tpn, To);

[fdgraph, W] = fdg(fdgraph, scgraph, [], tpn, To, Tfc);

%initial the set of consistent states
S = put(hashtable, get(fdgraph.sctoi, sc0), Dnormal);
timeupdate = [timeupdate; toc];
% diagnose using output edges of scfi
tic;
Diagoutput = [Diagoutput; get(fdgraph.vlabel, get(fdgraph.sctoi, sc0))];
timediag = [timediag; toc];
time = [time; timeupdate(end)+timediag(end)];

sizeSCP = [1];
sizeS1 = [1];
observation = [[0;0], observation];
for i = 2:size(observation, 2)
    tic;
    tj = observation(1, i);
    tauj = observation(2, i);
    deltaj = tauj - observation(2, i-1);
    % Ssclist is a list of sc indices
    [Ssclist, ~] = dump(S);
    for j = 1:size(Ssclist, 1)
        sc = Ssclist{j};
        nextsclist = find(fdgraph.graph(sc, :)==tj);
        if ~isempty(nextsclist)
            for nextscfi = nextsclist
                % pos should be empty or an integer
                pos = find(W==nextscfi);
                if ~isempty(pos)
                    scgraph = scg(get(fdgraph.itosc, W(pos)), tpn, To);
                    [fdgraph, W] = fdg(fdgraph, scgraph, W, tpn, To, Tfc);
                    W = [W(1:pos-1), W(pos+1:end)];
                end
            end
        end
    end
    timeupdate = [timeupdate; toc];
    tic;
    [Dw, S] = fdg_diag(fdgraph, S, tj, deltaj, Tfc);
    timediag = [timediag; toc];
    time = [time; timeupdate(end)+timediag(end)];
    Diagoutput = [Diagoutput; Dw];
    sizeSCP = [sizeSCP, size(fdgraph.graph, 1)];
    sizeS1 = [sizeS1; count(S)];
    if show
        disp('to tau diagnosis -- -- time -- timeupdate -- timediag');
        disp([Diagoutput, time, timeupdate, timediag, sizeS1]);
    end
end