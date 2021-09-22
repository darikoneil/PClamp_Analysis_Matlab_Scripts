function [rheoT,rheoA,rheoFWHM,maxFiringRate,Capacitance] = do_comp(STACKS)

numExperiments = size(STACKS.ALL,2);
numConditions = size(STACKS.ALL{1,1}.Conditions,2);

rheoT=nan(numConditions,numExperiments);
rheoA=nan(numConditions,numExperiments);
rheoFWHM=nan(numConditions,numExperiments);
maxFiringRate=zeros(numConditions,numExperiments);

Capacitance=[];
for a = 1:numExperiments
    Capacitance = [Capacitance str2num(STACKS.ALL{a}.cellStats.Capacitance)];
    for b = 1:numConditions
        rheoT(b,a)=STACKS.ALL{a}.Conditions{2,b}.rheoThreshold;
        rheoA(b,a)=STACKS.ALL{a}.Conditions{2,b}.rheoAmplitude;
        rheoFWHM(b,a)=STACKS.ALL{a}.Conditions{2,b}.rheoFWHM;
        if cell2mat(STACKS.ALL{a}.Conditions{2,b}.firingRate)>0
            maxFiringRate(b,a)=max(cell2mat(STACKS.ALL{a}.Conditions{2,b}.firingRate));
        else
            maxFiringRate(b,a)=0;
        end
    end
end

%data_correction

dcIdx = logical(maxFiringRate);

rheoT=rheoT.*dcIdx;
rheoT(rheoT==0)=NaN;
rheoA=rheoA.*dcIdx;
rheoA(rheoA==0)=NaN;
rheoFWHM=rheoFWHM.*dcIdx;
rheoFWHM(rheoFWHM==0)=NaN;

rheoT(2,:)=[];
rheoA(2,:)=[];
rheoFWHM(2,:)=[];
maxFiringRate(2,:)=[];


end