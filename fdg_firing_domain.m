function [gl, gu] = fdg_firing_domain(scsigma, tsigma, tpn)

% compute the firing domain of a firing sequence

lengtsigma = length(tsigma);
lengtzeros = zeros(1, lengtsigma);
cons = [];
b = [];
f = lengtzeros';
f(1, end) = 1;

for i = 1:lengtsigma
    cons1 = lengtzeros;
    cons1(1, i) = -1;
    if i > 1
        cons1(1, i-1) = 1;
    end
    cons = [cons; cons1];
    b = [b; 0];
end

% the first state
sc1 = scsigma{1};
% [~, sc1.d] = sc_unpack(sc1);

for i = fliplr(1:lengtsigma)
    ti = tsigma(i);
    % ti is enabled after the first state or not
    flag = 0;
    for j = fliplr(2:lengtsigma)
        % j-th state
        scj = scsigma{j};
        scj1 = scsigma{j-1};
        % [scj.m, scj.d] = sc_unpack(scsigma{j});
        % [scj1.m, ~] = sc_unpack(scsigma{j-1));
        % ti becomes enabled at scj.m?
        enscj = petri_enabled_trans(scj.m, tpn);
        enscj1 = petri_enabled_trans(scj1.m, tpn);
        if enscj(ti) > 0 && enscj1(ti) == 0
            [l, u] = domain_firing_interval(scj.d, ti, tpn.I);
            cons1 = lengtzeros;
            cons1(1, i) = 1;
            cons1(1, j-1) = -1; % j-th state is reached by
                                % firing j-1 transition
            cons = [cons; cons1];
            b = [b; u];
            
            cons = [cons; -cons1];
            b = [b; -l];
            flag = 1;
        end
    end
    
    % ti is enabled at the first state
    if flag == 0
        [l, u] = domain_firing_interval(sc1.d, ti, tpn.I);
        cons1 = lengtzeros;
        cons1(1, i) = 1;
        cons = [cons; cons1];
        b = [b; u];
        
        cons = [cons; -cons1];
        b = [b; -l];
    end
    
    % transitions disabled by firing ti
    sci = scsigma{i};
    % [mi, di] = sc_unpack(scsigma{i));
    mi1 = petri_successor(sci.m, ti, tpn);
    enmi = petri_enabled_trans(sci.m, tpn);
    enmi1 = petri_enabled_trans(mi1, tpn);
    distlist = setdiff(find(enmi>0), [find(enmi1>0), ti]);
    
    for tq = distlist
        % tq is becomes enabled at the first state or not?
        flagq = 0;
        for q = fliplr(2:i)
            scq = scsigma{q};
            scq1 = scsigma{q-1};
            % [mq, dq] = sc_unpack(scsigma{q));
            % [mq1, ~] = sc_unpack(scsigma{q-1));
            enmq = petri_enabled_trans(scq.m, tpn);
            enmq1 = petri_enabled_trans(scq1.m, tpn);
            if enmq(tq) > 0 && enmq1(tq) == 0
                [~, u] = domain_firing_interval(scq.d, tq);
                cons1 = lengtzeros;
                cons1(1, i) = 1;
                cons1(1, q-1) = -1;
                cons = [cons; cons1];
                b = [b; u];
                flagq = 1;
            end
        end
        
        if flagq == 0
            [~, u] = domain_firing_interval(sc1.d, tq, tpn.I);
            cons1 = lengtzeros;
            cons1(1, i) = 1;
            cons = [cons; cons1];
            b = [b; u];
        end
    end
end

scl = scsigma{lengtsigma};
% [ml, dl] = sc_unpack(scsigma{lengtsigma});
enml = petri_enabled_trans(scl.m, tpn);
enml(tsigma(end)) = 0;
for ti = find(enml>0)
    flagj = 0;
    for j = fliplr(2:lengtsigma)
        % j-th state
        scj = scsigma{j};
        scj1 = scsigma{j-1};
        % [scj.m, scj.d] = sc_unpack(scsigma{j));
        % j-1 -th state
        % [scj1.m, ~] = sc_unpack(scsigma{j-1));
        % ti becomes enabled at scj.m?
        enscj = petri_enabled_trans(scj.m, tpn);
        enscj1 = petri_enabled_trans(scj1.m, tpn);
        if enscj(ti) > 0 && enscj1(ti) == 0
            [~, u] = domain_firing_interval(scj.d, ti, tpn.I);
            cons1 = lengtzeros;
            cons1(1, lengtsigma) = 1;
            cons1(1, j-1) = -1;
            cons = [cons; cons1];
            b = [b; u];
            flagj = 1;
        end
    end
    if flagj == 0
        [~, u] = domain_firing_interval(sc1.d, ti, tpn.I);
        cons1 = lengtzeros;
        cons1(1, lengtsigma) = 1;
        cons = [cons; cons1];
        b = [b; u];
    end
end

% solve

[~, fmin, ~, ~] = glpk(f, cons, b);
gl = fmin;
[~, fmin, ~, ~] = glpk(-f, cons, b);
gu = -fmin;
return;

end

