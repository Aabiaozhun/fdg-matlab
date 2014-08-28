function [gl, gu] = fdg_firing_domain(scsigma, tsigma, pre, I)

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
[~, d1] = sc_unpack(sc1);

for i = fliplr(1:lengtsigma)
    ti = tsigma(i);
    % ti is enabled after the first state or not
    flag = 0;
    for j = fliplr(2:lengtsigma)
        % j-th state
        [mj, dj] = sc_unpack(scsigma{j});
        [mj1, ~] = sc_unpack(scsigma{j-1});
        % ti becomes enabled at mj?
        enmj = petri_enabled_trans(mj, pre);
        enmj1 = petri_enabled_trans(mj1, pre);
        if enmj(ti) > 0 && enmj1(ti) == 0
            [l, u] = domain_firing_interval(dj, ti);
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
        [l, u] = domain_firing_interval(d1, ti);
        cons1 = lengtzeros;
        cons1(1, i) = 1;
        cons = [cons; cons1];
        b = [b; u];
        
        cons = [cons; -cons1];
        b = [b; -l];
    end
    
    % transitions disabled by firing ti
    [mi, di] = sc_unpack(scsigma{i});
    mi1 = mi - pre(:, ti);
    enmi = petri_enabled_trans(mi, pre);
    enmi1 = petri_enabled_trans(mi1, pre);
    distlist = setdiff(find(enmi>0), [find(enmi1>0), ti]);
    
    for tq = distlist
        % tq is becomes enabled at the first state or not?
        flagq = 0;
        for q = fliplr(2:i)
            [mq, dq] = sc_unpack(scsigma{q});
            [mq1, ~] = sc_unpack(scsigma{q-1});
            enmq = petri_enabled_trans(mq, pre);
            enmq1 = petri_enabled_trans(mq1, pre);
            if enmq(tq) > 0 && enmq1(tq) == 0
                [~, u] = domain_firing_interval(dq, tq);
                cons1 = lengtzeros;
                cons1(1, i) = 1;
                cons1(1, q-1) = -1;
                cons = [cons; cons1];
                b = [b; u];
                flagq = 1;
            end
        end
        
        if flagq == 0
            [~, u] = domain_firing_interval(d1, tq);
            cons1 = lengtzeros;
            cons1(1, i) = 1;
            cons = [cons; cons1];
            b = [b; u];
        end
    end
end

[ml, dl] = sc_unpack(scsigma{lengtsigma});
enml = petri_enabled_trans(ml, pre);
enml(tsigma(end)) = 0;
for ti = find(enml>0)
    flagj = 0;
    for j = fliplr(2:lengtsigma)
        % j-th state
        [mj, dj] = sc_unpack(scsigma{j});
        % j-1 -th state
        [mj1, ~] = sc_unpack(scsigma{j-1});
        % ti becomes enabled at mj?
        enmj = petri_enabled_trans(mj, pre);
        enmj1 = petri_enabled_trans(mj1, pre);
        if enmj(ti) > 0 && enmj1(ti) == 0
            [~, u] = domain_firing_interval(dj, ti);
            cons1 = lengtzeros;
            cons1(1, lengtsigma) = 1;
            cons1(1, j-1) = -1;
            cons = [cons; cons1];
            b = [b; u];
            flagj = 1;
        end
    end
    if flagj == 0
        [~, u] = domain_firing_interval(d1, ti);
        cons1 = lengtzeros;
        cons1(1, lengtsigma) = 1;
        cons = [cons; cons1];
        b = [b; u];
    end
end

% solve
[~, fmin, ~, ~] = glpk(f, cons, b, I(:, 1), I(:, 2));
gl = fmin;
[~, fmin, ~, ~] = glpk(-f, cons, b, I(:, 1), I(:, 2));
gu = -fmin;

return;

end

