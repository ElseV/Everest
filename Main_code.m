%% Main script
     
%% Load data 
load('data0724');

%% DTW Experiments 
% exp: Xsens_Pos, Xsens_Ori, Xsens_P&O, Aurora_Pos, Aurora_Ori, Aurora_P&O
%      Position, Orientation, P&O

[dist,ix,iy,sync_error,sync_error_per,...
    accuracy,s1new,s2new,old1,old2]=test_dtw('Xsens_Pos'...
    ,data0724.exp2.seq5,data0724.exp3.seq4);

% now aurora has less sum of errors due to cut matrix
% automatic cut xsens matrix to aurora matrix size in case of combo
%% write to table
metric={'dist','error','error_per','accuracy'};
config={'bla'};
t=table(dist,sync_error,sync_error_per,...
    accuracy,'VariableNames',metric,'RowNames',config);
% tableDistance = array2table(distance,'RowNames',seq,'VariableNames', exp);

%%
filename = 'ExampleResults.xlsx';
writetable(t,filename,'Sheet',1,'Range','B29');

%% Visualization
DTWVisualization(ix,iy,s1new,s2new,'Xsens_Pos')
%% Visualization bar
bar_visualization(s1new,s2new,old1,old2,'')
%% Test loop
load('data0724');
results =zeros(4,4);
for i=1:4
    formatSpec=string("data0724.exp%d%s");
    A1=i;
    A2='.seq2';
    n=char(sprintf(formatSpec,A1,A2));
    [dist,~,~,sync_error_distance,sync_error_distance_per,sync_error_distance_max,...
    sync_error_distance_max_per,sync_error_duration,sync_error_duration_per,...
    accuracy,s1new,s2new,~,~]=test_dtw('Orientation',data0724.exp4.seq3,eval(n));
    results(i,1)=dist;
    results(i,2)=sync_error_distance;
    results(i,3)=sync_error_distance_per;
    results(i,4)=sync_error_distance_max;
    results(i,5)=sync_error_distance_max_per;
    results(i,6)=sync_error_duration;
    results(i,7)=sync_error_duration_per;
    results(i,8)=accuracy;  
end
exp={'exp1','exp2','exp3','exp4'};
metrics={'dist','error_mean','error_mean_per','error_max','error_max_per',...
    'error_dur','error_dur_per','accuracy'};
results_exp4seq3expseq2_ori=table(results,'RowNames',exp);%,'VariableNames',metrics);

%% Test loop list
load('data0724_list');
Metrics=zeros(15,3);
sumMetrics=zeros(15,3);
MetricsTot=zeros(15,3,15);
for j=3
for i=1:15
    formatSpec=string("data0724_list.seq%d");
    A1=i;
    A2=j;
    n1=char(sprintf(formatSpec,A1));
    n2=char(sprintf(formatSpec,A2));
    [dist,ix,iy,sync_error,sync_error_per,...
    accuracy,s1new,s2new,old1,old2]=test_dtw('Aurora_Pos',eval(n2),eval(n1));

    warps=[ix iy];
    nom=string("Seq%d");
    nom2=string("seq%d");
    path={char(sprintf(nom,j)),char(sprintf(nom2,A1))};
    Warp=array2table(warps,'VariableNames',path);
    filename='WarpingPaths2.xlsx'; 
    writetable(Warp,filename,'Sheet',i,'Range','C3');
%     Metrics(i,1)=sync_error;
%     Metrics(i,2)=sync_error_per;
%     Metrics(i,3)=accuracy;
end
% MetricsTot(:,:,j)=Metrics;
% sumMetrics=sumMetrics+Metrics;
% avgMetrics=sumMetrics/15;
% avgMetrics(16,:)=sum(avgMetrics)/15;
end
% metrics={'SyncError','SyncErrorPer','accuracy'};
% tMetrics=array2table(avgMetrics,'VariableNames',metrics);
% filename='ConfigResults.xlsx';
% writetable(tMetrics,filename,'Sheet',9,'Range','B1');