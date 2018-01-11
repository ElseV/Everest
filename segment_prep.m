function [segments]=segment_prep(seq)
%% Prepare sequence

position_xsens = seq.xsenspos; 
% position_xsens(:,1:end-1) = normc(position_xsens(:,1:end-1));
% position_xsens = [position_xsens(:,1:3) position_xsens(:,31:33) ...
%     position_xsens(:,43:45) position_xsens(:,end)];
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
segments=position_xsens(begin:endd,:);%% Prepare sequence

end