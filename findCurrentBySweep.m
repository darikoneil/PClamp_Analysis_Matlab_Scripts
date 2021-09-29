function [eStack] = findCurrentBySweep(eStack)

%importing information
numConditions = size(eStack.Conditions,2); %number of conditions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for a = 1:numConditions %iterate by condition
    eStack.Conditions{2,a}.holdingCurrent = eStack.Conditions{2,a}.meta.DACEpoch.fEpochInitLevel(1); %holding current
    startCurrent = eStack.Conditions{2,a}.meta.DACEpoch.fEpochInitLevel(2); %start current
    deltaCurrent = eStack.Conditions{2,a}.meta.DACEpoch.fEpochLevelInc(2); %delta current per step
    numSweeps = eStack.Conditions{2,a}.numSweep; %number of sweeps
    
    currentInjection = nan(1,numSweeps); %preallocate current
    for b = 1:numSweeps
        currentInjection(b)=startCurrent+(deltaCurrent*(b-1)); %solve for current at each step
    end
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Save for exports / exporting specific information
    eStack.Conditions{2,a}.currentInjection = currentInjection;
    eStack.Conditions{2,a}.startCurrent = startCurrent;
    eStack.Conditions{2,a}.deltaCurrent = deltaCurrent;
end

 
    