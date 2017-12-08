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
%     PathUB(ii,1)=sum(sum(abs(diff(seq_prep(:,1:end-2))))); % in cm?
%     PathRH(ii,1)=sum(sum(abs(diff(seq_prep(:,13:15)))));
%     PathLH(ii,1)=sum(sum(abs(diff(seq_prep(:,25:27)))));
end
Tmean=mean(T); % mean time
%% Info per sequence
for i=1:26
    name=string('data_list.seq%d');
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % std from mean time
    Tstd(i,1)=T(i)-Tmean;
end

% smoothness rate
[seq_rate,rate]=Smooth_motion('data_list','data_list.seq%d',26); % % of non smoothness
smoothnessrate=1-rate; 

Info=horzcat(T,Tstd,smoothnessrate);
columns={'time','std','smoothness'};
Tinfo=array2table(Info,'VariableNames',columns);

%% Endoscope path
load('data0724_list');
% determin mean time and path
for ii=1:15
    name=string('data0724_list.seq%d');
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=sensor_prep(seq,1,3);
    seq_prep=seq_prep(:,1:3);
    % path length
    Path(ii,1)=arclength(seq_prep(:,1),seq_prep(:,2),seq_prep(:,3));
end

%% smoothness rate endoscope
% Calculate acceleration for all columns 
clear sm; clear dy3;
for ii=1:15
    if ii==3
        continue
    end
    name=string('data0724_list.seq%d');
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=sensor_prep(seq,1,3);
    columns=seq_prep;
    t2=[1:length(columns)]';
    t=repmat(t2,1,size(columns,2));
    y=columns;
    y3=diff(columns,3);
    dt=diff(t);
    dy3{ii}=y3./dt(1:end-2,:);
%     ax{i}=(abs(diff(columns)))/(length(columns)/20)/(length(columns)/20);
end

for i=1:15
    if i==3
        continue
    end
    sm(i)=sqrt((sum(dy3{i}(:,1))).^2+(sum(dy3{i}(:,2))).^2+(sum(dy3{i}(:,3))).^2);
end
max_change=max(sm);
new_rate=sm/max_change;
rate_smooth_endo = 1-new_rate';
%%
clear sm; clear dy3;
for ii=1:26
    name=string('data_list.seq%d');
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=segment_prep(seq);
    columns=seq_prep;
    t2=[1:length(columns)]';
    t=repmat(t2,1,size(columns,2));
    y=columns;
    y3=diff(columns,3);
    dt=diff(t);
    dy3{ii}=y3./dt(1:end-2,:);
%     ax{i}=(abs(diff(columns)))/(length(columns)/20)/(length(columns)/20);
end
for i=1:26
    sm(i)=sqrt((sum(dy3{i}(:,1))).^2+(sum(dy3{i}(:,2))).^2+(sum(dy3{i}(:,3))).^2+...
    (sum(dy3{i}(:,1))).^2+(sum(dy3{i}(:,1))).^2+(sum(dy3{i}(:,1))).^2+...
        (sum(dy3{i}(:,1))).^2+(sum(dy3{i}(:,1))).^2+(sum(dy3{i}(:,1))).^2);
end
% sqrt(sum(diff(data,[],1).^2,2));

max_change=max(sm);
new_rate=sm/max_change;
rate_smooth_ub = 1-new_rate';

% % Calculate variance(std) of acceleration
% for j=1:15
%     for i=1:size(ax{1,j},2)
%         std1=std(ax{1,j}(:,i));
%         std_column(1,i)=std1;
%     end
%     var_ax{j}=std_column;
% end
% 
% var_ax_tot=0;
% for i=1:15
%     var_ax_tot=[var_ax_tot var_ax{1,i}];
% % var_ax_tot=[var_ax{1,1} var_ax{1,2} var_ax{1,3} var_ax{1,4} var_ax{1,5} var_ax{1,6}...
% %     var_ax{1,7} var_ax{1,8} var_ax{1,9} var_ax{1,10} var_ax{1,11} var_ax{1,12}...
% %     var_ax{1,13} var_ax{1,14} var_ax{1,15}];
% end
% var_ax_tot=var_ax_tot(:,2:end);
% 
% [~, order] = sort(var_ax_tot);
% % first is smoothest, last is most non smooth
% for i=1:length(order)
% if mod(order(:,i),3)~=0
%    smoothness_order(:,i)=floor(order(:,i)/3)+1;
% else
%    smoothness_order(:,i)=floor(order(:,i)/3);
% end
% end
% 
% % Rate of non smoothness
% % Each sequence (15) exists 3 times in the vector (1 sensor in xyz). 
% smoothness_order=smoothness_order(:,1:length(var_ax_tot));
% for i=1:length(var_ax_tot)/3
%     rate(i,:)=((sum(find(smoothness_order==i))/length(var_ax_tot))/3);
% end
% smoothnessrate_endo=1-rate;
% 
% [~,seq_rate]=sort(rate);
% % first is smoothest, last is most non smooth

%% boxplot beginners vs experts
a=NaN(12,1);
t_beginners=[T(1);T(10:15);a];
t_experts=[T(2:9); T(16:26)];
time=[t_experts t_beginners];

rate_beginners=[rate_smooth_ub(1);rate_smooth_ub(10:15);a];
rate_experts=[rate_smooth_ub(2:9); rate_smooth_ub(16:26)];
rate=[rate_experts rate_beginners];

path_beginners=[Path(1);Path(10:15);NaN];
path_experts=Path(2:9);
path_plot=[path_experts path_beginners];

endo_rate_beginners=[rate_smooth_endo(1);rate_smooth_endo(10:15);NaN];
endo_rate_experts=[rate_smooth_endo(2:9)];
endo_rate=[endo_rate_experts endo_rate_beginners];

figure, subplot(1,4,1); boxplot(time,'Labels',{'experts','beginners'},...
    'MedianStyl','target','BoxStyle','filled');
title('Sequence time');
ylabel('time [s]');
subplot(1,4,2); boxplot(rate*100,'Labels',{'experts','beginners'},...
    'MedianStyl','target','BoxStyle','filled');
title({'Smoothness rate';'upper body'});
ylabel('percentage [%]');
subplot(1,4,3); boxplot(endo_rate*100,'Labels',{'experts','beginners'},...
    'MedianStyl','target','BoxStyle','filled');
title({'Smoothness rate';'endoscope'});
ylabel('percentage [%]');
subplot(1,4,4); boxplot(path_plot/10,'Labels',{'experts','beginners'},...
    'MedianStyl','target','BoxStyle','filled');
title({'Path lenght';'endoscope'});
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