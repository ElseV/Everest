%% Info all sequences
load('data_list');
% determin mean time and path
for ii=1:26
    name=string("data_list.seq%d");
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % time % in seconds (already cut mouth-mouth)
    T(ii,1)=length(seq_prep)/20; % in seconds (already cut mouth-mouth)
    % path length
    PathUB(ii,1)=sum(sum(abs(diff(seq_prep(:,1:end-2))))); % in cm?
    PathRH(ii,1)=sum(sum(abs(diff(seq_prep(:,13:15)))));
    PathLH(ii,1)=sum(sum(abs(diff(seq_prep(:,25:27)))));
end
Tmean=mean(T); % mean time
PUBmean=mean(PathUB); % mean path length
PRHmean=mean(PathRH);
PLHmean=mean(PathLH);
%% Info per sequence
for i=1:26
    name=string("data_list.seq%d");
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % std from mean time
    Tstd(i,1)=T(i)-Tmean;
    % std from mean path
    PUBstd(i,1)=PathUB(i,1)-PUBmean;
    PRHstd(i,1)=PathRH(i,1)-PRHmean;
    PLHstd(i,1)=PathLH(i,1)-PLHmean;
end
 
Info=horzcat(T,Tstd,PathUB,PUBstd,PathRH,PRHstd,PathLH,PLHstd);
columns={'time','std','pathUB','std1','pathRH','std2',...
    'pathLH','std3'};
Tinfo=array2table(Info,'VariableNames',columns);

%% Info ref 
load('ref_list');
% determin mean time and path
for ii=1:9
    name=string("ref_list.seq%d");
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % mean time
    T(ii,1)=length(seq_prep)/20; % in seconds (already cut mouth-mouth)
    % mean path length
    PathUB(ii,1)=sum(sum(abs(diff(seq_prep(:,1:end-2))))); % in cm?
    PathRH(ii,1)=sum(sum(abs(diff(seq_prep(:,13:15)))));    
    PathLH(ii,1)=sum(sum(abs(diff(seq_prep(:,25:27)))));  
    % mean speed
    SpeedUB(ii,1)=PathUB(ii)/T(ii); % in cm/s?
    SpeedRH(ii,1)=PathRH(ii)/T(ii);
    SpeedLH(ii,1)=PathLH(ii)/T(ii);
end
Tmean=mean(T);
PUBmean=mean(PathUB);
PRHmean=mean(PathRH);
PLHmean=mean(PathLH);
SUBmean=mean(SpeedUB);
SRHmean=mean(SpeedRH);
SLHmean=mean(SpeedLH);
%% Info per avg sequence
for i=1:9
    name=string("ref_list.seq%d");
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % std from mean time
    Tstd(i,1)=T(i)-Tmean;
    % std from mean path
    PUBstd(i,1)=PathUB(i,1)-PUBmean;
    PRHstd(i,1)=PathRH(i,1)-PRHmean;
    PLHstd(i,1)=PathLH(i,1)-PLHmean;
    % std speed
    SUBstd(i,1)=SpeedUB(i,1)-SUBmean;
    SRHstd(i,1)=SpeedRH(i,1)-SRHmean;
    SLHstd(i,1)=SpeedLH(i,1)-SLHmean;
    % accelartion
    % std acceleration
    % most moved segments and in which direction
    segments=segment_prep(seq);
    segments=note_phase(segments); % make phases
    for j=1:(size(segments,2)-2) % std of all columns > segments
        std_column(1,j)=std(segments(:,j));%std1;
    end
    ind = floor(95/100*length(std_column)); % only top 5%
    newarr = sort(std_column);
    threshold = newarr(ind);
    moved_columns= find(std_column>threshold);
    moved_segments(i,:)=segments_moved(moved_columns);
    moved_seg{i,:}=strjoin(moved_segments(i,:),' - ');
end
% smoothness rate
[seq_rate,rate]=smooth_motion("ref_list","ref_list.seq%d",9); % % of non smoothness
 
Info2=horzcat(num2cell(T),num2cell(Tstd),num2cell(PathUB),num2cell(PUBstd),...
    num2cell(PathRH),num2cell(PRHstd),num2cell(PathLH),num2cell(PLHstd),...
    num2cell(SpeedUB),num2cell(SUBstd),num2cell(SpeedRH),num2cell(SRHstd),...
    num2cell(SpeedLH),num2cell(SLHstd),(moved_seg),num2cell(rate));
columns={'Time','stdT','PathUB','stdPUB','PathRH','stdRH','PathLH','stdLH',...
    'SpeedUB','stdSUB','SpeedRH','stdSRH','SpeedLH','stdSLH','Segments','smoothnessrate'};
Tinfo2=array2table(Info2,'VariableNames',columns);
