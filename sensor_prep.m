%% Funtion to load Aurora position data
% Specify time frames

function position_aurora=sensor_prep(seq,sensor_start,sensor_end)

position_aurora = seq.aurorapos; 
position_aurora = [position_aurora(:,sensor_start:sensor_end)...
    position_aurora(:,end)]; 

% interpolates for missing values
x=1:length(position_aurora);
for i=1:size(position_aurora,2)
    ind=~isnan(position_aurora(:,i));
    position_aurora(:,i)=interp1(x(ind),position_aurora(ind,i),x)';
    i=i+1;
end

% replace NaNs on outside of matrix by 0
for i=1:length(position_aurora)
    a=isnan(position_aurora(i,:));
    position_aurora(i,a)=0;
%     if any(a)
%         position_aurora(i,:)=zeros(1,size(position_aurora,2)); % put zeros in whole row if there is NaN
%     end
end

position_aurora(:,end)=round(position_aurora(:,end));
annotations=round(seq.events(:,1)*1000);

a=zeros(length(position_aurora),1);
position_aurora = [position_aurora a];
j=1;
for i=2:10
    ind=find(annotations(i,1)==position_aurora(:,end-1));
    position_aurora(ind,end)=j;
    j=j+1;
end

begin=min(find(position_aurora(:,end)==1));
endd=max(find(position_aurora(:,end)==9));
position_aurora=position_aurora(begin:endd,:);

% position_aurora(:,1:end-2) = zscore(position_aurora(:,1:end-2));
% not normalize the timestamps
end