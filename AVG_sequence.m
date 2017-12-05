%% AVG of AVG phase 3

dlmwrite('I:Camma\matlab\seq1.txt',phase1avg1,' ');
dlmwrite('I:Camma\matlab\seq2.txt',phase1avg2,' ');
dlmwrite('I:Camma\matlab\seq3.txt',phase1avg3,' ');
dlmwrite('I:Camma\matlab\seq4.txt',phase1refavg,' ');

system('I:\Camma\build\testDTW\Debug\testDTW_aurora.exe I:\Camma\matlab\seq 4')
AVGavg_auphase1 = dlmread('seq-avg.txt');
%% AVG of AVG
clear sequences; clear position_org; clear stys; clear mi; clear m; clear s; clear si
load('data0724_list');
n_sequences=0;
j=1;
for i=1:15
%     if i==6 || i==2 || i==3 || i==4 || i==5 
%         continue
%     end
    name1=string("data0724.seq%d");
    part1=char(sprintf(name1,i));
    seq=eval(part1);
    dlmwrite(['I:Camma\matlab\seq' int2str(j) '.txt'],seq,' ');
    n_sequences=n_sequences+1;
    j=j+1;
end
%%
system('I:\Camma\build\testDTW\Debug\testDTW_aurora.exe I:\Camma\matlab\seq 4')
AVG = dlmread(['seq-avg.txt']);
%% prepeare xsens sequences
clear sequences; clear position_org; clear stys; clear mi; clear m; clear s; clear si
load('data0724_list');
n_sequences=0;
j=1;
for i=1:15
    name1=string("data0724_list.seq%d");
    part1=char(sprintf(name1,i));
    seq=eval(part1);
    position=sensor_prep(seq);
    position_org{j}=position(:,1:end-2);
    [sequences{j},mi,si] = zscore(position(:,1:end-2)); 
    m(j,:)=mi;
    s(j,:)=si;
%     positionXS_neworg{i}=positionXS.*si+mi; % inverse z-score
    dlmwrite(['I:Camma\matlab\seq' int2str(j) '.txt'],position_org{j},' ');
    n_sequences=n_sequences+1;
    j=j+1;
end
%% average xsens
system(['I:\Camma\build\testDTW\Debug\testDTW_aurora.exe I:\Camma\matlab\seq 15']);% int2str(n_sequences)])
AVG_xs_org = dlmread('I:\Camma\matlab\seq-avg.txt');
%%
figure,
plot3(AVG_au_org(10:500,2),AVG_au_org(10:500,3),AVG_au_org(10:500,3));
%% prepare aurora sequences
clear sequences; clear position_org; clear stys; clear mi; clear m; clear s; clear si
n_sequences=0;
j=1;
for i=23:26
    name1=string("data_list.seq%d");
    part1=char(sprintf(name1,i));
    seq=eval(part1);
    position=sensor_prep(seq,1,21);
    position_org{j}=position(:,1:end-2);
    [sequences{j},mi,si] = zscore(position(:,1:end-2)); 
    m(j,:)=mi;
    s(j,:)=si;
%     positionXS_neworg{i}=positionXS.*si+mi; % inverse z-score
    dlmwrite(['I:Camma\matlab\seq' int2str(j) '.txt'],sequences{1,j},' ');
    n_sequences=n_sequences+1;
    j=j+1;
end
%% average aurora
[AVG_au_Lee,AVGorg_au_Lee]=average('aurora',n_sequences,m,s);
%% Save average sequences
AVG.Nabe.xsnorm=AVG_xs_Nabe;
AVG.Nabe.xsorg=AVGorg_xs_Nabe;
AVG.Nabe.aunorm=AVG_au_Nabe;
AVG.Nabe.auorg=AVGorg_au_Nabe;

dlmwrite('I:Camma\matlab\avgNabe_aurora_position.txt',AVG.Nabe.auorg,' ');
dlmwrite('I:Camma\matlab\avgNabe_xsens_position.txt',AVG.Nabe.xsorg,' ');

AVG.Cristian.xsnorm=AVG_xs_Cristian;
AVG.Cristian.xsorg=AVGorg_xs_Cristian;
AVG.Cristian.aunorm=AVG_au_Cristian;
AVG.Cristian.auorg=AVGorg_au_Cristian;

AVG.Paul.xsnorm=AVG_xs_Paul;
AVG.Paul.xsorg=AVGorg_xs_Paul;
AVG.Paul.aunorm=AVG_au_Paul;
AVG.Paul.auorg=AVGorg_au_Paul;

AVG.Shingo.xsnorm=AVG_xs_Shingo;
AVG.Shingo.xsorg=AVGorg_xs_Shingo;
AVG.Shingo.aunorm=AVG_au_Shingo;
AVG.Shingo.auorg=AVGorg_au_Shingo;

AVG.Ivo.xsnorm=AVG_xs_Ivo;
AVG.Ivo.xsorg=AVGorg_xs_Ivo;
AVG.Ivo.aunorm=AVG_au_Ivo;
AVG.Ivo.auorg=AVGorg_au_Ivo;

AVG.Eran.xsnorm=AVG_xs_Eran;
AVG.Eran.xsorg=AVGorg_xs_Eran;
AVG.Eran.aunorm=AVG_au_Eran;
AVG.Eran.auorg=AVGorg_au_Eran;

AVG.Lee.xsnorm=AVG_xs_Lee;
AVG.Lee.xsorg=AVGorg_xs_Lee;
AVG.Lee.aunorm=AVG_au_Lee;
AVG.Lee.auorg=AVGorg_au_Lee;
%% Plot average trajectory
cmap = cool(size(AVG,1)); 

stys{1} = ':';
stys{2} = ':';
stys{3} = '-.';
stys{4} = '-.';
stys{5} = '--';
stys{6} = '--';

figure();hold on;
grid on;
cols = ['r' ;'g'; 'b' ;'y' ; 'c' ; 'm'];

%Plot individual sequences
% plot3(sequences{1,1}(:,1), sequences{1,1}(:,2), sequences{1,1}(:,3),'LineWidth',2)
% plot3(sequences{1,2}(:,1), sequences{1,2}(:,2), sequences{1,2}(:,3),'LineWidth',2)
% plot3(sequences{1,3}(:,1), sequences{1,3}(:,2), sequences{1,3}(:,3),'LineWidth',2)

%Plot AVG
for k = 5 : size(AVG,1)-5
        
        plot3([AVG(k-1,2) AVG(k,2)], [AVG(k-1,3) AVG(k,3)],...
            [AVG(k-1,4) AVG(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end

%% AVG org plot
figure; hold on; grid on;
plot3(position_org{1}(:,1), position_org{1}(:,2), position_org{1}(:,3),'LineWidth',2)
plot3(position_org{2}(:,1), position_org{2}(:,2), position_org{2}(:,3),'LineWidth',2)
plot3(position_org{3}(:,1), position_org{3}(:,2), position_org{3}(:,3),'LineWidth',2)
plot3(AVGorg_au_Eran(:,1), AVGorg_au_Eran(:,2), AVGorg_au_Eran(:,3),'LineWidth',2)
