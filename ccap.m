
wcap = [];
for a = 1:10
    wcap = [wcap str2num(WSTACKS.ALL{a}.cellStats.Capacitance)];
end

ccap = [];
for a = 1:7
    ccap = [ccap str2num(CSTACKS.ALL{a}.cellStats.Capacitance)];
end

