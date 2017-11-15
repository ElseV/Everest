%% prepeare sequences
function [AVG,AVG_org]=average(type,n,m,s)
% n = number of sequences
% type = xsens or aurora > different cpp application > different amount of
% colums / senors or segments
% m = mean (zscore)
% s = std (zscore)
%% Create average
switch type
    case 'xsens'
        system(['E:\Camma\build\testDTW\Debug\testDTW_xsens.exe E:\Camma\matlab\seq ' int2str(n)])
    case 'aurora'
        system(['E:\Camma\build\testDTW\Debug\testDTW_aurora.exe E:\Camma\matlab\seq ' int2str(n)])
end

%% Load average trajectory
AVG = dlmread(['seq-avg.txt']);

%% inverse zscore
AVG_s=mean(s);
AVG_m=mean(m);
AVG_org=AVG(:,2:end).*AVG_s+AVG_m; % inverse z-score
end
