function [data,dFdT,splinesX,splinesY,splinesValues,FitValues,idx1,idx2,T1,T2] = makeSplinePlot(eStack,ID)

rheoIdx = eStack.Conditions{2,ID}.rheoIdx;
data = eStack.Conditions{2,ID}.unprunedData(:,1,rheoIdx);
dFdT = [0;diff(data)];


FitValues = [1:1600];
splinesValues = [1:0.01:1600];

splinesX = pchip(FitValues,data,splinesValues);
splinesY = pchip(FitValues,dFdT,splinesValues);

idx1 = find(splinesValues==276);
idx2 = find(splinesValues==1275);
figure
subplot(2,2,1:2)
plot(data)
subplot(2,2,3)
plot(splinesX,splinesY)
subplot(2,2,4)
plot(splinesX(idx1:idx2),splinesY(idx1:idx2));

T1 = splinesX(idx1:idx2);
T2 = splinesY(idx1:idx2);
end




