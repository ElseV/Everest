%% Funtion to load Aurora position data
% Specify time frames

function [position_aurora]=pos_aurora_avg(seq,sensor_start,sensor_end)

position_aurora = seq.auorg;
% position_aurora(:,1)=[];
position_aurora = [position_aurora(:,sensor_start:sensor_end) position_aurora(:,end)]; 

% interpolates for missing values
x=1:length(position_aurora);
for i=1:size(position_aurora,2)
    ind=~isnan(position_aurora(:,i));
    position_aurora(:,i)=interp1(x(ind),position_aurora(ind,i),x)';
end

 % standardization with zscore, without taking NaNs into account
 position_aurora(:,1:end-1) = bsxfun(@minus,position_aurora(:,1:end-1),...
     nanmean(position_aurora(:,1:end-1),1));
 position_aurora(:,1:end-1) = bsxfun(@rdivide,position_aurora(:,1:end-1),...
     nanstd(position_aurora(:,1:end-1),[],1));

end


