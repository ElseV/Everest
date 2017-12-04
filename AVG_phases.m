% 
avg_phase1.seq1=seq;% phase1avg1; %
avg_phase1.seq2=seq1;% phase1avg2; 
avg_phase1.seq3=seq2;% phase1avg3; %
avg_phase1.seq4=seq3;% phase1refavg; %

n_sequences=0;
for i=1:4
    name1=string("avg_phase1.seq%d");
    part1=char(sprintf(name1,i));
    seq=eval(part1);
    [position{i},mi,si]=zscore(seq(:,1:end-1));
    m(i,:)=mi;
    s(i,:)=si;
    n_sequences=n_sequences+1;
    dlmwrite(['I:Camma\matlab\seq' int2str(i) '.txt'],seq,' ');
end
% system('I:\Camma\build\testDTW\Debug\testDTW_aurora.exe I:\Camma\matlab\seq 4')
[AVGavg_au,AVGavgorg_au]=average('aurora',n_sequences,m,s);
% AVGavg_au_2 = dlmread(['seq-avg.txt']);
% AVG_s=mean(s);
% AVG_m=mean(m);
% AVGavgorg_au_phase1=AVGavg_au_phase1(:,2:end).*AVG_s+AVG_m; % inverse z-score
%% Create four phases xsens
clear phases; clear phases_org; clear mi; clear m; clear s; clear si
load('data0724_list');
event=1;
for phase=1:4
    j=1;
    n_sequences=0;
    for i=1:15
        name1=string('data0724_list.seq%d');
        part1=char(sprintf(name1,i));
        seq=eval(part1);
        position=sensor_prep(seq,1,21);
        if event==7
           ind1=min(find(position(:,end)==event));
           ind2=max(find(position(:,end)==event+2));
           position(ind1:ind2,end)=phase;
        else 
            ind1=min(find(position(:,end)==event));
            ind2=min(find(position(:,end)==event+2));
            position(ind1:ind2-1,end)=phase;
        end
        phases_org{phase,j}=position(ind1:ind2-1,1:end-2);
        [phases{phase,j},mi,si]=zscore(position(ind1:ind2-1,1:end-2));
        m(j,:)=mi;
        s(j,:)=si;
        n_sequences=n_sequences+1;  
        
%         dlmwrite(['I:Camma\matlab\seq' int2str(j) '.txt'],phases_org{phase,j},' ');
        j=j+1;
    end
    event=event+2;
%     phase1_org{phase}=phases_org{1};
%     phase2_org{phase}=phases_org{2};
%     phase3_org{phase}=phases_org{3};
%     phase4_org{phase}=phases_org{4};
%      
%     phase1{phase}=phases{1};
%     phase2{phase}=phases{2};
%     phase3{phase}=phases{3};
%     phase4{phase}=phases{4};
    
%    [AVG_au_phases_exp4{phase},~]=average('aurora',n_sequences,m,s);
end
% for j=1:2
% dlmwrite(['I:Camma\matlab\seq' int2str(j) '.txt'],phases_org{4,j},' ');
% end
% system(['I:\Camma\build\testDTW\Debug\testDTW_aurora.exe I:\Camma\matlab\seq 2']);% int2str(n_sequences)])
% AVG_au_phases_exp4{4} = dlmread(['seq-avg.txt']);
%% avg avg
dlmwrite(['I:\Camma\matlab\seq1.txt'],AVG_au_phases_exp1{1},' ');
dlmwrite(['I:\Camma\matlab\seq2.txt'],AVG_au_phases_exp2{1}(:,2:end),' ');
dlmwrite(['I:\Camma\matlab\seq3.txt'],AVG_au_phases_exp3{1}(:,2:end),' ');
dlmwrite(['I:\Camma\matlab\seq4.txt'],AVG_au_phases_exp4{1}(:,2:end),' ');

system(['I:\Camma\build\testDTW\Debug\testDTW_aurora.exe I:\Camma\matlab\seq 4']);% int2str(n_sequences)])
AVG_au_phases_avgexp{1} = dlmread(['seq-avg.txt']);

%% Vis original, avg & ref insertion
%Plot individual sequences
figure();hold on;
grid on;

plot3(phases_org{1,1}(:,1), phases_org{1,1}(:,2), phases_org{1,1}(:,3),'LineWidth',2,'color',[0.3 0.3 0.3])
plot3(phases_org{1,2}(:,1), phases_org{1,2}(:,2), phases_org{1,2}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{1,3}(10:end,1), phases_org{1,3}(10:end,2), phases_org{1,3}(10:end,3),'LineWidth',2,'color',[0.5 0.5 0.5])
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{1,5}(:,1), phases_org{1,5}(:,2), phases_org{1,5}(:,3),'LineWidth',2,'color',[0.7 0.7 0.7])
plot3(phases_org{1,6}(:,1), phases_org{1,6}(:,2), phases_org{1,6}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{1,7}(:,1), phases_org{1,7}(:,2), phases_org{1,7}(:,3),'LineWidth',2,'color','k')
plot3(phases_org{1,8}(:,1), phases_org{1,8}(:,2), phases_org{1,8}(:,3),'LineWidth',2,'color',[0.3 0.3 0.3])
plot3(phases_org{1,9}(:,1), phases_org{1,9}(:,2), phases_org{1,9}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{1,10}(:,1), phases_org{1,10}(:,2), phases_org{1,10}(:,3),'LineWidth',2,'color',[0.5 0.5 0.5])
plot3(phases_org{1,11}(:,1), phases_org{1,11}(:,2), phases_org{1,11}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{1,12}(10:end,1), phases_org{1,12}(10:end,2), phases_org{1,12}(10:end,3),'LineWidth',2,'color',[0.7 0.7 0.7])
plot3(phases_org{1,13}(:,1), phases_org{1,13}(:,2), phases_org{1,13}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{1,14}(:,1), phases_org{1,14}(:,2), phases_org{1,14}(:,3),'LineWidth',2,'color','k')
plot3(phases_org{1,15}(:,1), phases_org{1,15}(:,2), phases_org{1,15}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])

%Plot REF
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),'LineWidth',2,'color','g')

%Plot AVG
for k = 5 : size(AVG_au_phases{1},1)-5
        
        plot3([AVG_au_phases{1}(k-1,2) AVG_au_phases{1}(k,2)], [AVG_au_phases{1}(k-1,3) AVG_au_phases{1}(k,3)],...
            [AVG_au_phases{1}(k-1,4) AVG_au_phases{1}(k,4)],'-','color','b' ,'LineWidth',3);hold on;

end
 
hold on

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])
%% Plot avg per exp & avg avg
figure();hold on;
grid on;
%Plot AVG exp 2
plot3(AVG_au_phases_exp2{1}(5:end-5,2), AVG_au_phases_exp2{1}(5:end-5,3), AVG_au_phases_exp2{1}(5:end-5,4),...
    'LineWidth',3,'color',[0.3 0.3 0.3])
% for k = 5 : size(AVG_au_phases_exp2{1},1)-5
%         
%         plot3([AVG_au_phases_exp2{1}(k-1,2) AVG_au_phases_exp2{1}(k,2)], [AVG_au_phases_exp2{1}(k-1,3) AVG_au_phases_exp2{1}(k,3)],...
%             [AVG_au_phases_exp2{1}(k-1,4) AVG_au_phases_exp2{1}(k,4)],'-','color','b' ,'LineWidth',3);hold on;
% 
% end
%Plot AVG exp 2
plot3(AVG_au_phases_exp3{1}(5:end-5,2), AVG_au_phases_exp3{1}(5:end-5,3), AVG_au_phases_exp3{1}(5:end-5,4),...
    'LineWidth',3,'color',[0.5 0.5 0.5])
%Plot AVG exp 2
plot3(AVG_au_phases_exp4{1}(5:end-5,2), AVG_au_phases_exp4{1}(5:end-5,3), AVG_au_phases_exp4{1}(5:end-5,4),...
    'LineWidth',3,'color',[0.7 0.7 0.7])
%Plot exp 1 = ref avg
plot3(AVG_au_phases_exp1{1}(1:end-100,1), AVG_au_phases_exp1{1}(1:end-100,2), AVG_au_phases_exp1{1}(1:end-100,3),...
    'LineWidth',3,'color','g','LineStyle','--')
%Plot avg 
plot3(AVG_au_phases{1}(5:end-5,2), AVG_au_phases{1}(5:end-5,3), AVG_au_phases{1}(5:end-5,4),...
     'LineWidth',3,'color','b')
%Plot avg avg
plot3(AVG_au_phases_avgexp{1}(5:end-5,2), AVG_au_phases_avgexp{1}(5:end-5,3), AVG_au_phases_avgexp{1}(5:end-5,4),...
     'LineWidth',3,'color','b','LineStyle','--')

% Plot ref
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),...
    'LineWidth',2,'color','g')

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])
%% Plot with ref per exp
figure();hold on;
grid on;
%Plot REF
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),'LineWidth',2,'color','g')
hold on
%Plot avg 
plot3(AVG_au_phases{1}(5:end-5,2), AVG_au_phases{1}(5:end-5,3), AVG_au_phases{1}(5:end-5,4),...
     'LineWidth',3,'color','b')

%Plot exp 1 = ref avg
plot3(AVG_au_phases_exp1{1}(1:end-100,1), AVG_au_phases_exp1{1}(1:end-100,2), AVG_au_phases_exp1{1}(1:end-100,3),...
    'LineWidth',3,'color','g','LineStyle','--')

%Plot avg avg
% plot3(AVG_au_phases_avgexp{1}(5:end-5,2), AVG_au_phases_avgexp{1}(5:end-5,3), AVG_au_phases_avgexp{1}(5:end-5,4),...
%      'LineWidth',3,'color','b','LineStyle','--')

% Plot other refs
ref1=sensor_prep(ref_list.seq1,1,9);
ref1=note_phase(ref1);
ref1_phase1=ref1(min(find(ref1(:,end)==1)):max(find(ref1(:,end)==1)),:);
plot3(ref1_phase1(:,1),ref1_phase1(:,2),ref1_phase1(:,3),'color',[0.7 0.7 0.7],'LineWidth',3)

ref7=sensor_prep(ref_list.seq7,1,9);
ref7=note_phase(ref7);
ref7_phase1=ref7(min(find(ref7(:,end)==1)):max(find(ref7(:,end)==1)),:);
% plot3(ref7_phase1(:,1),ref7_phase1(:,2),ref7_phase1(:,3),'color',[0.5 0.5 0.5],'LineWidth',3)

ref8=sensor_prep(ref_list.seq8,1,9);
ref8=note_phase(ref8);
ref8_phase1=ref8(min(find(ref8(:,end)==1)):max(find(ref8(:,end)==1)),:);
plot3(ref8_phase1(20:end,1),ref8_phase1(20:end,2),ref8_phase1(20:end,3),'color',[0.3 0.3 0.3],'LineWidth',3)

ref9=sensor_prep(ref_list.seq9,1,9);
ref9=note_phase(ref9);
ref9_phase1=ref9(min(find(ref9(:,end)==1)):max(find(ref9(:,end)==1)),:);
plot3(ref9_phase1(:,1),ref9_phase1(:,2),ref9_phase1(:,3),'color',[0.6 0.6 0.6],'LineWidth',3)
 
set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])
%% Plot refs & avgs
figure();hold on;
grid on;
plot3(ref1_phase1(:,1),ref1_phase1(:,2),ref1_phase1(:,3),'color',[0.5 0.5 0.5],'LineWidth',3)
plot3(ref7_phase1(1:end-100,1),ref7_phase1(1:end-100,2),ref7_phase1(1:end-100,3),'color',[0.5 0.5 0.5],'LineWidth',3)
plot3(ref8_phase1(20:end,1),ref8_phase1(20:end,2),ref8_phase1(20:end,3),'color',[0.5 0.5 0.5],'LineWidth',3)
plot3(ref9_phase1(:,1),ref9_phase1(:,2),ref9_phase1(:,3),'color',[0.5 0.5 0.5],'LineWidth',3)
plot3(AVG_au_phases_exp2{1}(5:end-5,2), AVG_au_phases_exp2{1}(5:end-5,3), AVG_au_phases_exp2{1}(5:end-5,4),...
    'LineWidth',3,'color','k','LineStyle','--')
plot3(AVG_au_phases_exp3{1}(5:end-5,2), AVG_au_phases_exp3{1}(5:end-5,3), AVG_au_phases_exp3{1}(5:end-5,4),...
    'LineWidth',3,'color','k','LineStyle','--')
plot3(AVG_au_phases_exp4{1}(5:end-5,2), AVG_au_phases_exp4{1}(5:end-5,3), AVG_au_phases_exp4{1}(5:end-5,4),...
    'LineWidth',3,'color','k','LineStyle','--')
plot3(AVG_au_phases_exp1{1}(1:end-100,1), AVG_au_phases_exp1{1}(1:end-100,2), AVG_au_phases_exp1{1}(1:end-100,3),...
    'LineWidth',3,'color','k','LineStyle','--')
set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])
%% Add final ref and avg
figure();hold on;
grid on;
plot3(ref1_phase1(:,1),ref1_phase1(:,2),ref1_phase1(:,3),'color',[0.8 0.8 0.8],'LineWidth',3)
plot3(ref7_phase1(1:end-100,1),ref7_phase1(1:end-100,2),ref7_phase1(1:end-100,3),'color',[0.8 0.8 0.8],'LineWidth',3)
plot3(ref8_phase1(20:end,1),ref8_phase1(20:end,2),ref8_phase1(20:end,3),'color',[0.8 0.8 0.8],'LineWidth',3)
plot3(ref9_phase1(:,1),ref9_phase1(:,2),ref9_phase1(:,3),'color',[0.8 0.8 0.8],'LineWidth',3)
plot3(AVG_au_phases_exp2{1}(5:end-5,2), AVG_au_phases_exp2{1}(5:end-5,3), AVG_au_phases_exp2{1}(5:end-5,4),...
    'LineWidth',3,'color',[0.7 0.7 0.7],'LineStyle','--')
plot3(AVG_au_phases_exp3{1}(5:end-5,2), AVG_au_phases_exp3{1}(5:end-5,3), AVG_au_phases_exp3{1}(5:end-5,4),...
    'LineWidth',3,'color',[0.7 0.7 0.7],'LineStyle','--')
plot3(AVG_au_phases_exp4{1}(5:end-5,2), AVG_au_phases_exp4{1}(5:end-5,3), AVG_au_phases_exp4{1}(5:end-5,4),...
    'LineWidth',3,'color',[0.7 0.7 0.7],'LineStyle','--')
plot3(AVG_au_phases_exp1{1}(1:end-100,1), AVG_au_phases_exp1{1}(1:end-100,2), AVG_au_phases_exp1{1}(1:end-100,3),...
    'LineWidth',3,'color',[0.7 0.7 0.7],'LineStyle','--')
%Plot REF
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),'LineWidth',2,'color','g')
hold on
%Plot avg 
plot3(AVG_au_phases{1}(5:end-5,2), AVG_au_phases{1}(5:end-5,3), AVG_au_phases{1}(5:end-5,4),...
     'LineWidth',3,'color','b')

%Plot exp 1 = ref avg
plot3(AVG_au_phases_exp1{1}(1:end-100,1), AVG_au_phases_exp1{1}(1:end-100,2), AVG_au_phases_exp1{1}(1:end-100,3),...
    'LineWidth',3,'color','g','LineStyle','--')

%Plot avg avg
% plot3(AVG_au_phases_avgexp{1}(5:end-5,2), AVG_au_phases_avgexp{1}(5:end-5,3), AVG_au_phases_avgexp{1}(5:end-5,4),...
%      'LineWidth',3,'color','b','LineStyle','--')
set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])
%% Plot ref avg
seq=AVG_Seq_all.seq9.auorg;
% seq(:,1:end-1)=(seq(:,1:end-1));
phase1refavg=seq(min(find(seq(:,end)==1)):max(find(seq(:,end)==1)),:);

seq1=AVG_Seq_all.seq1.auorg;
phase1avg1=seq1(min(find(seq1(:,end)==1)):max(find(seq1(:,end)==1)),:);
seq2=AVG_Seq_all.seq8.auorg;
phase1avg2=seq2(min(find(seq2(:,end)==1)):max(find(seq2(:,end)==1)),:);
seq3=AVG_Seq_all.seq7.auorg;
phase1avg3=seq3(min(find(seq3(:,end)==1)):max(find(seq3(:,end)==1)),:);

figure,
hold on; grid on;
% ref avg
plot3(phase1refavg(10:end-10,1),phase1refavg(10:end-10,2),phase1refavg(10:end-10,3),...
    'LineWidth',2,'color','g');

hold on;
% avgs
plot3(phase1avg1(10:end-10,1),phase1avg1(10:end-10,2),phase1avg1(10:end-10,3),...
    'LineWidth',2,'color',[0.5 0.5 0.5]);
plot3(phase1avg2(10:end-10,1),phase1avg2(10:end-10,2),phase1avg2(10:end-10,3),...
    'LineWidth',2,'color',[0.3 0.3 0.3]);
plot3(phase1avg3(10:end-10,1),phase1avg3(10:end-10,2),phase1avg3(10:end-10,3),...
    'LineWidth',2,'color',[0.7 0.7 0.7]);

AVGavg_au_phase1=zscore(AVGavgorg_au(10:660,:));
% avg avg
plot3(AVGavg_au_phase1(10:end-10,2),AVGavg_au_phase1(10:end-10,3),AVGavg_au_phase1(10:end-10,4),...
    'LineWidth',2,'color','b'); % tm 660 if whole seq

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])

%% Plot average trajectory
cmap = cool(size(AVG_au_Phase{1},1)); 

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
plot3(phases{1,7}(:,1), phases{1,7}(:,2), phases{1,7}(:,3),'LineWidth',2,'color',[0.5 0.5 0.5])
plot3(phases{1,8}(:,1), phases{1,8}(:,2), phases{1,8}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases{1,3}(:,1), phases{1,3}(:,2), phases{1,3}(:,3),'LineWidth',2,'color',[0.3 0.3 0.3])
plot3(phases{1,4}(:,1), phases{1,4}(:,2), phases{1,4}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases{1,5}(:,1), phases{1,5}(:,2), phases{1,5}(:,3),'LineWidth',2,'color',[0.1 0.1 0.1])
plot3(phases{1,6}(:,1), phases{1,6}(:,2), phases{1,6}(:,3),'LineWidth',2,'color',[0.7 0.7 0.7])
% plot3(phases{1,1}(:,1), phases{1,1}(:,2), phases{1,1}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
% plot3(phases{1,2}(:,1), phases{1,2}(:,2), phases{1,2}(:,3),'LineWidth',2,'color',[0.7 0.7 0.7])
% plot3(phases{1,9}(:,1), phases{1,9}(:,2), phases{1,9}(:,3),'LineWidth',2,'color',[0.3 0.3 0.3])
% plot3(phases{1,10}(:,1), phases{1,10}(:,2), phases{1,10}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
% plot3(phases{1,11}(:,1), phases{1,11}(:,2), phases{1,11}(:,3),'LineWidth',2,'color',[0.1 0.1 0.1])
% % plot3(phases{1,12}(:,1), phases{1,12}(:,2), phases{1,12}(:,3),'LineWidth',2,'color','k')
% plot3(phases{1,13}(:,1), phases{1,13}(:,2), phases{1,13}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
% plot3(phases{1,14}(:,1), phases{1,14}(:,2), phases{1,14}(:,3),'LineWidth',2,'color',[0.5 0.5 0.5])
% plot3(phases{1,15}(:,1), phases{1,15}(:,2), phases{1,15}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])

%Plot AVG
for k = 5 : size(AVG_au_Phase{1},1)-5
        
        plot3([AVG_au_Phase{1}(k-1,2) AVG_au_Phase{1}(k,2)], [AVG_au_Phase{1}(k-1,3) AVG_au_Phase{1}(k,3)],...
            [AVG_au_Phase{1}(k-1,4) AVG_au_Phase{1}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])

%% Plot average trajectory
cmap = cool(size(AVG_au_Phase{1},1)); 

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
plot3(phases_org{1,7}(:,1), phases_org{1,7}(:,2), phases_org{1,7}(:,3),'LineWidth',2,'color',[0.5 0.5 0.5])
plot3(phases_org{1,8}(:,1), phases_org{1,8}(:,2), phases_org{1,8}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{1,3}(:,1), phases_org{1,3}(:,2), phases_org{1,3}(:,3),'LineWidth',2,'color',[0.3 0.3 0.3])
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{1,5}(:,1), phases_org{1,5}(:,2), phases_org{1,5}(:,3),'LineWidth',2,'color',[0.1 0.1 0.1])
plot3(phases_org{1,6}(:,1), phases_org{1,6}(:,2), phases_org{1,6}(:,3),'LineWidth',2,'color',[0.7 0.7 0.7])

%Plot AVG
for k = 5 : size(AVG_au_Phase{1},1)-5
        
        plot3([AVG_au_Phase{1}(k-1,2) AVG_au_Phase{1}(k,2)], [AVG_au_Phase{1}(k-1,3) AVG_au_Phase{1}(k,3)],...
            [AVG_au_Phase{1}(k-1,4) AVG_au_Phase{1}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])
%% Plot average trajectory
cmap = cool(size(AVG_au_Phase{2},1)); 

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
plot3(phases{2,1}(:,1), phases{2,1}(:,2), phases{2,1}(:,3),'LineWidth',2)
plot3(phases{2,2}(:,1), phases{2,2}(:,2), phases{2,2}(:,3),'LineWidth',2)
% plot3(sequences{1,3}(:,1), sequences{1,3}(:,2), sequences{1,3}(:,3),'LineWidth',2)

%Plot AVG
for k = 5 : size(AVG_au_Phase{2},1)-5
        
        plot3([AVG_au_Phase{2}(k-1,2) AVG_au_Phase{2}(k,2)], [AVG_au_Phase{2}(k-1,3) AVG_au_Phase{2}(k,3)],...
            [AVG_au_Phase{2}(k-1,4) AVG_au_Phase{2}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
%% Plot average trajectory
cmap = cool(size(AVG_au_Phase{3},1)); 

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
plot3(phases{3,1}(:,1), phases{3,1}(:,2), phases{3,1}(:,3),'LineWidth',2)
plot3(phases{3,2}(:,1), phases{3,2}(:,2), phases{3,2}(:,3),'LineWidth',2)
% plot3(sequences{1,3}(:,1), sequences{1,3}(:,2), sequences{1,3}(:,3),'LineWidth',2)

%Plot AVG
for k = 5 : size(AVG_au_Phase{3},1)-5
        
        plot3([AVG_au_Phase{3}(k-1,2) AVG_au_Phase{3}(k,2)], [AVG_au_Phase{3}(k-1,3) AVG_au_Phase{3}(k,3)],...
            [AVG_au_Phase{3}(k-1,4) AVG_au_Phase{3}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
%% Plot average trajectory
cmap = cool(size(AVG_au_phases{4},1)); 

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
plot3(phases_org{4,1}(:,1), phases_org{4,1}(:,2), phases_org{4,1}(:,3),'LineWidth',2)
plot3(phases_org{4,2}(:,1), phases_org{4,2}(:,2), phases_org{4,2}(:,3),'LineWidth',2)
% plot3(sequences{1,3}(:,1), sequences{1,3}(:,2), sequences{1,3}(:,3),'LineWidth',2)

%Plot AVG
for k = 5 : size(AVG_au_phases{4},1)-5
        
        plot3([AVG_au_phases{4}(k-1,2) AVG_au_phases{4}(k,2)], [AVG_au_phases{4}(k-1,3) AVG_au_phases{4}(k,3)],...
            [AVG_au_phases{4}(k-1,4) AVG_au_phases{4}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
%% AVG org plot
figure; hold on; grid on;
plot3(phases_org{1,1}(:,1), phases_org{1,1}(:,2), phases_org{1,1}(:,3),'LineWidth',2)
plot3(phases_org{1,2}(:,1), phases_org{1,2}(:,2), phases_org{1,2}(:,3),'LineWidth',2)
% plot3(phases_org{1,3}(:,1), phases_org{1,3}(:,2), phases_org{1,3}(:,3),'LineWidth',2)
plot3(AVGorg_au_Phase{1}(:,1), AVGorg_au_Phase{1}(:,2), AVGorg_au_Phase{1}(:,3),'LineWidth',2)

