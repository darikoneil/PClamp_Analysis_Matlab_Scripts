function [eStack] = findSpikeThresholdBatch_PCHIP(eStack)

%Piecewise Cubic Hermite Interpolating Polynomial (PCHIP)

sThresh=eStack.sThresh;
cellID = eStack.cellID; %Import Cell
numConditions = size(eStack.Conditions,2); %Determine # of Plots Condition


for a = 1:numConditions %for all conditions
    unprunnedFrames = eStack.Conditions{2,a}.unprunnedFrames;
    firstDataFrame = (eStack.Conditions{2,a}.EIndices(2))+1;
    lastDataFrame = eStack.Conditions{2,a}.EIndices(3);
    tempBuffer_V=eStack.Conditions{2,a}.unprunedData(:,1,:);
    tempNumSweeps = eStack.Conditions{2,a}.numSweep; %Sweeps\
    tempBuffer_V=reshape(tempBuffer_V,unprunnedFrames,tempNumSweeps);
    fitValues = [1:unprunnedFrames];
    splineValues = [1:0.01:unprunnedFrames]; %num frame

    
    threshBySweep = nan(1,tempNumSweeps); %Preallocate Thresholds
    threshLoc = nan(1,tempNumSweeps); %Locations to extract Values
    noSpikesIdx = ones(1,tempNumSweeps); %Index Bad Sweeps
    rheoAmps = nan(1,tempNumSweeps);
    storedFits = cell(2,tempNumSweeps);
    for b = 1:tempNumSweeps
        tempBuffer_dVdT = [0;diff(reshape(eStack.Conditions{2,a}.unprunedData(:,1,b),unprunnedFrames,1))]; %1600 = num frames
        splinesX = pchip(fitValues,tempBuffer_V(:,b),splineValues);
        splinesY = pchip(fitValues,tempBuffer_dVdT,splineValues).*10;
        storedFits{1,b}=splinesX;
        storedFits{2,b}=splinesY;
        idx1=find(splineValues==firstDataFrame); %this needs to be d
        idx2=find(splineValues==lastDataFrame);%this needs to be d
        splinesX=splinesX(idx1:idx2);
        splinesY=splinesY(idx1:idx2);
     
        sLoc = find(splinesY>=sThresh,1);
        if numel(sLoc)>0 & max(tempBuffer_V(:,b))>=0 %make sure above zero mV
            sVal = splinesX(sLoc); %voltage at spike (spike threshold)
            rheoAmps(b)= max(splinesX); %spike amplitude
            threshLoc(b)=round(splineValues(sLoc),0); %location on the original, non-upscaled frames
            threshBySweep(b)=sVal; %store it
            noSpikesIdx(b)=0; %did spike
            %rheoAmps(b) = max(tempBuffer_V(:,b));
        else
            noSpikesIdx(b)=1; %didn't spike  
        end
        
        
    %Export
    eStack.Conditions{2,a}.threshBySweep=threshBySweep;
    eStack.Conditions{2,a}.threshLoc = threshLoc;
    eStack.Conditions{2,a}.noSpikesIdx=noSpikesIdx;
    eStack.Conditions{2,a}.rheoAmps=rheoAmps;
    eStack.Conditions{2,a}.storedFits=storedFits;
    end
end

for a = 1:numConditions
    [M,I] = maxk(~(double(eStack.Conditions{2,a}.noSpikesIdx)),1);
    eStack.Conditions{2,a}.rheoIdx = I; %Find Index of First Spike
    eStack.Conditions{2,a}.rheoThreshold = eStack.Conditions{2,a}.threshBySweep(I);
    eStack.Conditions{2,a}.AvgRheo = mean(eStack.Conditions{2,a}.threshBySweep(~isnan(eStack.Conditions{2,a}.threshBySweep)));
    eStack.Conditions{2,a}.rheoAmp = eStack.Conditions{2,a}.rheoAmps(I);
end

end

