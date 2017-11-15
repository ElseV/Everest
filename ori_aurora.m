%% Funtion to load Aurora orienration data
% Specify time frames

function [orientation_aurora,old]=ori_aurora(seq,sensor_start,sensor_end)

orientation_aurora = seq.auroraori; 
orientation_aurora = [orientation_aurora(:,sensor_start:sensor_end) ...
    orientation_aurora(:,end)]; 

% interpolates for missing values
x=1:length(orientation_aurora);
for i=1:size(orientation_aurora,2)
    ind=~isnan(orientation_aurora(:,i));
    orientation_aurora(:,i)=interp1(x(ind),orientation_aurora(ind,i),x)';
    i=i+1;
end
% standardization with zscore, without taking NaNs into account
 orientation_aurora(:,1:end-1) = bsxfun(@minus,orientation_aurora(:,1:end-1),...
     nanmean(orientation_aurora(:,1:end-1),1));
 orientation_aurora(:,1:end-1) = bsxfun(@rdivide,orientation_aurora(:,1:end-1),...
     nanstd(orientation_aurora(:,1:end-1),[],1));

% remove row if NaNs on outer side of matrix (no interpolation possible)
for i=1:length(orientation_aurora)
    a=isnan(orientation_aurora(i,:));
    orientation_aurora(i,a)=0;
%     if any(a)
%         orientation_aurora(i,:)=zeros(1,size(orientation_aurora,2)); % put zeros in whole row if there is NaN
%     end
end
old = orientation_aurora;

% all(orientation_aurora==0,2);
% orientation_aurora(ans,:)=[];

orientation_aurora(:,end)=round(orientation_aurora(:,end));
annotations=round(seq.events(:,1)*1000);

a=zeros(length(orientation_aurora),1);
orientation_aurora = [orientation_aurora a];
j=1;
for i=2:10
    ind=find(annotations(i,1)==orientation_aurora(:,end-1));
    orientation_aurora(ind,end)=j;
    j=j+1;
end

begin=min(find(orientation_aurora(:,end)==1));
endd=max(find(orientation_aurora(:,end)==9));
orientation_aurora=orientation_aurora(begin:endd,:);

% orientation_aurora(:,1:end-2) = zscore(orientation_aurora(:,1:end-2)); % normailzation
% not normalize the time stamps at the end
end
