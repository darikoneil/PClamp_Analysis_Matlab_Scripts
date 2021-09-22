function [SynFilt] = anisotropicDiffusion(SynROIs,gT)

%Darik O'Neil MBL Neuro 2021 Team Hoppa
%Makes Time Vector

SynROIs = transpose(SynROIs);
SynFilt = zeros(size(SynROIs));
for i = 1:size(SynFilt,1)
    temp=[];
    gradThresh = range(SynROIs(i,:))*(gT/100);
    temp = imdiffusefilt(SynROIs(i,:),'ConductionMethod','quadratic','GradientThreshold',gradThresh);
    %temp = temp/max(temp);
    %temp = max(temp,0);
    %InNoiseThr = 2*std(temp);
    %temp(temp<=InNoiseThr)=0;
    SynFilt(i,:)=temp;
end

SynFilt = transpose(SynFilt);

end
