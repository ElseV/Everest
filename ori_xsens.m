%% Funtion to load Xsens orientation data
% Specify segment and time frames
% quaternions

function orientation_xsens=ori_xsens(seq)

orientation_xsens = seq.xsensori; 
orientation_xsens(:,1:end-1) = zscore(orientation_xsens(:,1:end-1)); % normailzation
orientation_xsens = [orientation_xsens(:,1:4) ...
    orientation_xsens(:,29:60) orientation_xsens(:,end)];
% 1-4 = Pelvis, 24-47 = shoulder, upper arm, forearm & hand (see segmentsO
% script)

orientation_xsens(:,end)=round(orientation_xsens(:,end));
annotations=round(seq.events(:,1)*1000);

a=zeros(length(orientation_xsens),1);
orientation_xsens = [orientation_xsens a];
j=1;
for i=2:10
    ind=find(annotations(i,1)==orientation_xsens(:,end-1));
    orientation_xsens(ind,end)=j;
    j=j+1;
end

begin=min(find(orientation_xsens(:,end)==1));
endd=max(find(orientation_xsens(:,end)==9));
orientation_xsens=orientation_xsens(begin:endd,:);
end