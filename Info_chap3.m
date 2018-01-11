%% Time
Tavg_exp1=length(AVG_au_phases_exp1{1})/20; %Vicky = ref
Tavg_exp2=length(AVG_au_phases_exp2{1})/20; %Nabe
Tavg_exp3=length(AVG_au_phases_exp3{1})/20; %Christian
Tavg_exp4=length(AVG_au_phases_exp4{1})/20; %Paul
Tavg_exps=length(AVG_au_phases_avgexp{1})/20;
Tavg=length(AVG_au_phases{1})/20;

Tref_exp1=length(ref7_phase1)/20; %Vicky
Tref_exp2=length(ref1_phase1)/20; %Nabe
Tref_exp3=length(ref8_phase1)/20; %Christian
Tref_exp4=length(ref9_phase1)/20; %Paul
Tref=length(phases_org{1,4})/20;

T_all=[Tavg_exp1;Tavg_exp2;Tavg_exp3;Tavg_exp4;Tavg_exps;Tavg;Tref_exp1;Tref_exp2;...
    Tref_exp3;Tref_exp4;Tref];

% T original sequences
for i=1:15
    t(i)=length(phases_org{1,i})/20;
end

T_all=[T_all;t'];

%% Path endoscope tip

for ii=1:4
    name=string('AVG_au_phases_exp%d{1}');
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep{ii}=seq(:,1:3);
    % path length
    Path(ii,1)=arclength(seq_prep{ii}(:,1),seq_prep{ii}(:,2),seq_prep{ii}(:,3));
end

seq_prep{5}=AVG_au_phases_avgexp{1}(:,2:4);
Path(5,1)=arclength(seq_prep{5}(:,1),seq_prep{5}(:,2),seq_prep{5}(:,3));

% seq_prep{6}=AVG_au_phases{1}(:,2:4);
seq_prep{6}=avg_sensors(:,1:3);
Path(6,1)=arclength(seq_prep{6}(350:560,1),seq_prep{6}(350:560,2),seq_prep{6}(350:560,3));

seq_prep{7}=ref7_phase1(:,1:3);
Path(7,1)=arclength(seq_prep{7}(:,1),seq_prep{7}(:,2),seq_prep{7}(:,3));

seq_prep{8}=ref1_phase1(:,1:3);
Path(8,1)=arclength(seq_prep{8}(:,1),seq_prep{8}(:,2),seq_prep{8}(:,3));

seq_prep{9}=ref8_phase1(:,1:3);
Path(9,1)=arclength(seq_prep{9}(:,1),seq_prep{9}(:,2),seq_prep{9}(:,3));

seq_prep{10}=ref9_phase1(:,1:3);
Path(10,1)=arclength(seq_prep{10}(:,1),seq_prep{10}(:,2),seq_prep{10}(:,3));

seq_prep{11}=phases_org{1,4}(:,1:3);
Path(11,1)=arclength(seq_prep{11}(:,1),seq_prep{11}(:,2),seq_prep{11}(:,3));

% T original sequences
h=12;
for i=1:15
    seq_prep{h}=phases_org{1,i}(:,1:3);
    Path(h,1)=arclength(seq_prep{h}(:,1),seq_prep{h}(:,2),seq_prep{h}(:,3));
    h=h+1;
end

%% Smoothness rate
% Calculate acceleration for all columns 
% for i=1:26
%     columns=seq_prep{i};
%     ax{i}=(abs(diff(columns)))/(length(columns)/20)/(length(columns)/20);
% end

for i=1:26
%     if i==6
%         continue
%     end
    columns=seq_prep{i};
    t2=[1:length(columns)]';
    t=repmat(t2,1,size(columns,2));
    y=columns;
    y3=diff(columns,3);
    dt=diff(t);
    dy3{i}=y3./dt(1:end-2,:);
end

for i=1:26
%     if i==6
%         continue
%     end
    sm(i)=sqrt((sum(dy3{i}(:,1))).^2+(sum(dy3{i}(:,2))).^2+(sum(dy3{i}(:,3))).^2);
end
% sqrt(sum(diff(data,[],1).^2,2));

max_change=max(sm);
new_rate=sm/max_change;
new_rate_smooth = 1-new_rate;

%%
t_avg=[T_all(1:6);NaN(9,1)];
t_ref=[T_all(7:11);NaN(10,1)];
t_org=T_all(12:26);
t_tot=[t_avg t_ref t_org];

path_box=[[Path(1:6);NaN(9,1)] [Path(7:11);NaN(10,1)] Path(12:26)];

rate_box=[[new_rate_smooth(1:6);NaN(9,1)] [new_rate_smooth(7:11);NaN(10,1)]...
    new_rate_smooth(12:26)];

figure, subplot(1,3,1); boxplot(t_tot,'Labels',{'avg','ref','org'},...
    'MedianStyl','target','BoxStyle','filled');
title('Sequence time');
ylabel('time [s]');
subplot(1,3,2); boxplot(rate_box*100,'Labels',{'avg','ref','org'},...
    'MedianStyl','target','BoxStyle','filled');
title({'Smoothness rate';'endoscope'});
ylabel('percentage [%]');
subplot(1,3,3); boxplot(path_box/10,'Labels',{'avg','ref','org'},...
    'MedianStyl','target','BoxStyle','filled');
title({'Path lenght';'endoscope'});
ylabel('distance [cm]');
%%
% Calculate variance(std) of acceleration
% for j=1:26
%     for i=1:size(ax{1,j},2)
%         std1=std(ax{1,j}(:,i));
%         std_column(1,i)=std1;
%     end
%     var_ax{j}=std_column;
% end
% 
% var_ax_tot=0;
% for i=1:26
%     var_ax_tot=[var_ax_tot var_ax{1,i}];
% end
% var_ax_tot=var_ax_tot(:,2:end);
% 
% [a, order] = sort(var_ax_tot);
% % first is smoothest, last is most non smooth
% for i=1:length(order)
% if mod(order(:,i),3)~=0
%    smoothness_order(:,i)=floor(order(:,i)/3)+1;
%    smoothness_order(2,i)=a(i);
% else
%    smoothness_order(:,i)=floor(order(:,i)/3);
%    smoothness_order(2,i)=a(i);
% end
% end
% 
% % Rate of non smoothness
% % Each sequence exists 3 times in the vector (1 sensor in xyz). 
% smoothness_order=smoothness_order(1,1:length(var_ax_tot));
% for i=1:length(var_ax_tot)/3
%     rate(i,:)=((sum(find(smoothness_order(1,:)==i))/length(var_ax_tot))/3);
% end
% smoothnessrate=1-rate;
% 
% [~,seq_rate]=sort(rate);
% first is smoothest, last is most non smooth


