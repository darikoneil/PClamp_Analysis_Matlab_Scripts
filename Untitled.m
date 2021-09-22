function [rheoT,rheoA,rheoFWHM,maxFiringRate] = do_comp(STACKS);

numExperiments = size(STACKS.ALL,2);
numConditions = size(STACKS.ALL{1,1}.Conditions,2);

rheoT=nan(numConditions,numExperiments;
rheoA=nan(numConditions,numExperiments);
rheoFWHM=nan(numConditions,numExperiments);
maxFiringRate=zeros(numConditions,numExperiments);


for a = 1:numExperiments
    for b = 1:numConditions
        rheoT(b,a)=STACKS.ALL{a}.Conditions{2,b}.rheoThreshold;
        rheoA(b,a)=STACKS.ALL{a}.Conditions{2,b}.rheoAmplitude;
        rheoFWHM(b,a)=STACKS.ALL{a}.Conditions{2,b}.rheoFWHM;
        maxFiringRate(b,a)=max(cell2mat(STACKS.ALL{a}.Conditions{2,b}.firingRate));
    end
end




end