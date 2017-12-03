%% Funtion to load Xsens position data
% Specify segment and time frames

function position_xsens=pos_xsens_avg(seq)

position_xsens = seq.xsorg; 
position_xsens(:,1:end-1) = zscore(position_xsens(:,1:end-1)); % normailzation
% not normalization for time stamps
a=zeros(length(position_xsens),1);
position_xsens = [position_xsens(:,1:3) position_xsens(:,22:45) a position_xsens(:,end)];
% 1-3 = Pelvis, 22-45 = shoulder, upper arm, forearm & hand (see segments
% script)

end
