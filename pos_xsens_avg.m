%% Funtion to load Xsens position data
% Specify segment and time frames

function position_xsens=pos_xsens_avg(seq)

position_xsens = seq.xsorg; 
position_xsens = zscore(position_xsens); % normailzation
% not normalization for time stamps
position_xsens = [position_xsens(:,1:3) position_xsens(:,22:45)];
% 1-3 = Pelvis, 22-45 = shoulder, upper arm, forearm & hand (see segments
% script)

a=zeros(length(position_xsens),1);
b=zeros(length(position_xsens),1);
position_xsens = [position_xsens a b];
end
