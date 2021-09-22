T1A=cell(1,20);
T2A=cell(1,20);
for a = 1:20
    [data,dFdT,splinesX,splinesY,splinesValues,FitValues,idx1,idx2,T1,T2] = makeSplinePlot(WARM.ALL{a},1);
    T1A{a}=T1;
    T2A{a}=T2;
end

V1 = nan(1,10);
for a = 1:10
    V1(a)= COOL.ALL{a}.Conditions{2,1}.unprunedData(1,1,COOL.ALL{a}.Conditions{2,1}.rheoIdx);
    %figure
    %plot(V1(a));
end

V1

B1 = [];
for a  = 1:COOL.ALL{b}.Conditions{2,3}.numSweep
    B1 = [B1 COOL.ALL{b}.Conditions{2,3}.unprunedData(1,1,a)];
end

B1
    