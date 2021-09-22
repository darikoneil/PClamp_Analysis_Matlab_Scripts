data=eStack.Conditions{2,1}.data(:,1,a);

dFdT = [0; diff(data)];

valuesFit = transpose([1:1000]);

Xvalues = fit(valuesFit,data,'smoothingspline','SmoothingParam',0.999999999999);
Yvalues = fit(valuesFit,dFdT,'smoothingspline','SmoothingParam',0.999999999999);


vv = [1:0.01:1000];
splineX = Xvalues(vv);
splineY = Yvalues(vv);
%Yxx = Yvalues(splineValuesDxx);
%splineXxx = Xvalues(splineValuesDxx);

%Yxx = (splineYxx/0.01)*10;

figure
plot(splineX,splineY);
hold on
%plot(eStack.Conditions{2,1}.unprunedData(:,1,a),[0;diff(eStack.Conditions{2,1}.unprunedData(:,1,a))])
plot(eStack.Conditions{2,1}.data(:,1,a),[0;diff(eStack.Conditions{2,1}.data(:,1,a))])
hold off