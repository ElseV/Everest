%% Funtion to load Xsens position data
% Specify segment and time frames

function position_xsens=pos_xsens(seq)

position_xsens = seq.xsenspos; 
position_xsens(:,1:end-1) = zscore(position_xsens(:,1:end-1)); % normailzation
% not normalization for time stamps
position_xsens = [position_xsens(:,1:3) position_xsens(:,22:45) ...
    position_xsens(:,end)];
% 1-3 = Pelvis, 22-45 = shoulder, upper arm, forearm & hand (see segments
% script)

position_xsens(:,end)=round(position_xsens(:,end));
annotations=round(seq.events(:,1)*1000);

a=zeros(length(position_xsens),1);
position_xsens = [position_xsens a];
j=1;
for i=2:10 % adding annotations
    ind=find(annotations(i,1)==position_xsens(:,end-1));
    position_xsens(ind,end)=j;
    j=j+1;
end

begin=min(find(position_xsens(:,end)==1));
endd=max(find(position_xsens(:,end)==9));
position_xsens=position_xsens(begin:endd,:);

end
