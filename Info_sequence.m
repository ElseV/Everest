%% Info all sequences
load('data_list');
% determin mean time and path
for ii=1:26
    name=string('data_list.seq%d');
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
    name=string('data_list.seq%d');
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

% smoothness rate
[seq_rate,rate]=smooth_motion('data_list','data_list.seq%d',26); % % of non smoothness
 
Info=horzcat(T,Tstd,PathUB,PUBstd,PathRH,PRHstd,PathLH,PLHstd,rate);
columns={'time','std','pathUB','std1','pathRH','std2',...
    'pathLH','std3','smoothness'};
Tinfo=array2table(Info,'VariableNames',columns);
%% Endoscope path
load('data0724_list');
% determin mean time and path
for ii=1:15
    name=string('data0724_list.seq%d');
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=pos_aurora(seq,1,3);
    % path length
    Path(ii,1)=sum(sum(abs(diff(seq_prep(:,1:end-2))))); % in cm?
end
Pmean=mean(Path); % mean path length

for i=1:15
    name=string('data0724_list.seq%d');
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=pos_aurora(seq,1,3);
    % std from mean path
    Pstd(i,1)=Path(i,1)-Pmean;
end
%% boxplot beginners vs experts
beginners=[Info(1,1:8:9); Info(10:15,1:8:9)];
experts=[Info(2:9,1:8:9); Info(16:26,1:8:9)];

path_beginners=[Path(1);Path(10:15);NaN];
path_experts=Path(2:9);
path_plot=[path_experts path_beginners];

a=NaN(12,2);
beginners=[beginners;a];
time=[experts(:,1) beginners(:,1)];
rate=[experts(:,2) beginners(:,2)];

figure, subplot (1,3,1); boxplot(time,'Labels',{'experts','beginners'},...
    'MedianStyl','target','BoxStyle','filled');
title('Sequence time');
ylabel('time [s]');
subplot (1,3,2); boxplot(rate,'Labels',{'experts','beginners'},...
    'MedianStyl','target','BoxStyle','filled');
title('Smoothness rate');
ylabel('percentage [%]');
subplot (1,3,3); boxplot(path_plot,'Labels',{'experts','beginners'},...
    'MedianStyl','target','BoxStyle','filled');
title('Path lenght endoscope');
ylabel('distance [cm]');

%% Info ref 
load('ref_list');
% determin mean time and path
for ii=1:9
    name=string('ref_list.seq%d');
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % mean time
    T(ii,1)=length(seq_prep)/20; % in seconds (already cut mouth-mouth)
end
Tmean=mean(T);
%% Info per ref sequence
for i=1:9
    name=string('ref_list.seq%d');
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % std from mean time
    Tstd(i,1)=T(i)-Tmean;
    % most moved segments and in which direction
%     segments=segment_prep(seq);
%     segments=note_phase(segments); % make phases
%     for j=1:(size(segments,2)-2) % std of all columns > segments
%         std_column(1,j)=std(segments(:,j));%std1;
%     end
%     ind = floor(95/100*length(std_column)); % only top 5%
%     newarr = sort(std_column);
%     threshold = newarr(ind);
%     moved_columns= find(std_column>threshold);
%     moved_segments(i,:)=segments_moved(moved_columns);
%     moved_seg{i,:}=strjoin(moved_segments(i,:),' - ');
end
% smoothness rate
[seq_rate,rate]=smooth_motion('ref_list','ref_list.seq%d',9); % % of non smoothness
 

%% Endoscope path ref
% determin mean time and path

for ii=1:9
    name=string("ref_list.seq%d");
    n=char(sprintf(name,ii));
    seq=eval(n);
    if ii==1 || ii==7 || ii==8 || ii==9
        seq_prep=pos_aurora(seq,1,3);
    % path length
        Path(ii,1)=sum(sum(abs(diff(seq_prep(:,1:end-1))))); % in cm?
    end
end
Pmean=mean(Path); % mean path length

for i=1:9
    name=string("ref_list.seq%d");
    n=char(sprintf(name,i));
    seq=eval(n);
    if ii==1 || ii==7 || ii==8 || ii==9
%         seq_prep=pos_aurora_avg(seq,1,3);
    % std from mean path
        Pstd(i,1)=Path(i,1)-Pmean;
    end
end

Info=horzcat(T,Tstd,Path,Pstd,rate);
columns={'Time','stdT','Path','stdP','smoothnessrate'};
Tinfo=array2table(Info,'VariableNames',columns);