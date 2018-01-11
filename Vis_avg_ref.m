%% Create four phases xsens
clear phases; clear phases_org; clear mi; clear m; clear s; clear si
load('data0724_list');
load('data_list');
event=1;
for phase=1:4
    j=1;
    n_sequences=0;
    for i=1:15 %insertion, retroflexion+inspect, intubation, retraction
%         if i==3 
%            continue
%         end
        name1=string("data0724_list.seq%d");
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
    phase1_org{phase}=phases_org{1};
    phase2_org{phase}=phases_org{2};
    phase3_org{phase}=phases_org{3};
    phase4_org{phase}=phases_org{4};
%     
%     phase1{phase}=phases{1};
%     phase2{phase}=phases{2};
%     phase3{phase}=phases{3};
%     phase4{phase}=phases{4};
    
%     [AVG_xs_phases{phase},~]=average('xsens',n_sequences,m,s);
     % really the original aurora phases
end
% system('I:\Camma\build\testDTW\Debug\testDTW_aurora.exe I:\Camma\matlab\seq 4')
%% Vis original, avg & ref insertion
%Plot individual sequences
figure();hold on;
grid on;

plot3(phases_org{1,1}(:,1), phases_org{1,1}(:,2), phases_org{1,1}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{1,2}(:,1), phases_org{1,2}(:,2), phases_org{1,2}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{1,3}(:,1), phases_org{1,3}(:,2), phases_org{1,3}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{1,5}(:,1), phases_org{1,5}(:,2), phases_org{1,5}(:,3),'LineWidth',2,'color','k')
plot3(phases_org{1,6}(:,1), phases_org{1,6}(:,2), phases_org{1,6}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{1,7}(:,1), phases_org{1,7}(:,2), phases_org{1,7}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{1,8}(:,1), phases_org{1,8}(:,2), phases_org{1,8}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{1,9}(:,1), phases_org{1,9}(:,2), phases_org{1,9}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{1,10}(:,1), phases_org{1,10}(:,2), phases_org{1,10}(:,3),'LineWidth',2,'color','k')
plot3(phases_org{1,11}(:,1), phases_org{1,11}(:,2), phases_org{1,11}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{1,12}(10:end,1), phases_org{1,12}(10:end,2), phases_org{1,12}(10:end,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{1,13}(:,1), phases_org{1,13}(:,2), phases_org{1,13}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{1,14}(:,1), phases_org{1,14}(:,2), phases_org{1,14}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{1,15}(:,1), phases_org{1,15}(:,2), phases_org{1,15}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
%Plot REF
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),'LineWidth',2,'color','g')

%Plot AVG
for k = 5 : size(AVG_au_phases{1},1)-5
        
        plot3([AVG_au_phases{1}(k-1,2) AVG_au_phases{1}(k,2)], [AVG_au_phases{1}(k-1,3) AVG_au_phases{1}(k,3)],...
            [AVG_au_phases{1}(k-1,4) AVG_au_phases{1}(k,4)],'-','color','b' ,'LineWidth',3);hold on;

end

% % ref avg
% plot3(phase1refavg(10:end-10,1),phase1refavg(10:end-10,2),phase1refavg(10:end-10,3),...
%     'LineWidth',2,'color','r');
% grid on;
% hold on
% % avgs
% plot3(phase1avg1(10:end-10,1),phase1avg1(10:end-10,2),phase1avg1(10:end-10,3),...
%     'LineWidth',2,'color','m');
% plot3(phase1avg2(10:end-10,1),phase1avg2(10:end-10,2),phase1avg2(10:end-10,3),...
%     'LineWidth',2,'color','m');
% plot3(phase1avg3(10:end-10,1),phase1avg3(10:end-10,2),phase1avg3(10:end-10,3),...
%     'LineWidth',2,'color','m');

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])

%%
avgref=AVG_Seq_all.seq9.auorg;
phase1refavg=avgref(min(find(avgref(:,end)==1)):max(find(avgref(:,end)==1)),:);

avg1=AVG_Seq_all.seq1.auorg;
phase1avg1=avg1(min(find(avg1(:,end)==1)):max(find(avg1(:,end)==1)),:);
avg2=AVG_Seq_all.seq8.auorg;
phase1avg2=avg2(min(find(avg2(:,end)==1)):max(find(avg2(:,end)==1)),:);
avg3=AVG_Seq_all.seq7.auorg;
phase1avg3=avg3(min(find(avg3(:,end)==1)):max(find(avg3(:,end)==1)),:);
%%
figure,
%Plot AVGavg
% phase1avgavg=AVGavg_aurora(min(find(AVGavg_aurora(:,end)==1)):max(find(AVGavg_aurora(:,end)==1)),:);
% plot3(phase1avgavg(10:end-10,1),phase1avgavg(10:end-10,2),phase1avgavg(10:end-10,3),...
%     'LineWidth',2,'color','r');

% ref avg
plot3(phase1refavg(10:end-100,1),phase1refavg(10:end-100,2),phase1refavg(10:end-100,3),...
    'LineWidth',2,'color','r');
grid on;
hold on
% avgs
plot3(phase1avg1(10:end-100,1),phase1avg1(10:end-100,2),phase1avg1(10:end-100,3),...
    'LineWidth',2,'color',[0.5 0.5 0.5]);
plot3(phase1avg2(10:end-100,1),phase1avg2(10:end-100,2),phase1avg2(10:end-100,3),...
    'LineWidth',2,'color',[0.3 0.3 0.3]);
plot3(phase1avg3(10:end-100,1),phase1avg3(10:end-100,2),phase1avg3(10:end-100,3),...
    'LineWidth',2,'color',[0.7 0.7 0.7]);

%Plot REF
plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),'LineWidth',2,'color','g')

%Plot AVG
for k = 5 : size(test{1},1)-5
        
        plot3([test{1}(k-1,2) test{1}(k,2)], [test{1}(k-1,3) test{1}(k,3)],...
            [test{1}(k-1,4) test{1}(k,4)],'-','color','b' ,'LineWidth',3);hold on;

end
%Plot AVG

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])

%% Plot phase 2
cmap = cool(size(AVG_au_phases{2},1)); 

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
plot3(phases_org{2,1}(1:length(phases_org{2,1})/2,1), phases_org{2,1}(1:length(phases_org{2,1})/2,2),...
    phases_org{2,1}(1:length(phases_org{2,1})/2,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{2,2}(1:length(phases_org{2,2})/2,1), phases_org{2,2}(1:length(phases_org{2,2})/2,2),...
    phases_org{2,2}(1:length(phases_org{2,2})/2,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{2,3}(1:length(phases_org{2,3})/2,1), phases_org{2,3}(1:length(phases_org{2,3})/2,2),...
    phases_org{2,3}(1:length(phases_org{2,3})/2,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{2,4}(1:length(phases_org{2,4})/2,1), phases_org{2,4}(1:length(phases_org{2,4})/2,2),...
    phases_org{2,4}(1:length(phases_org{2,4})/2,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{2,5}(1:length(phases_org{2,5})/2,1), phases_org{2,5}(1:length(phases_org{2,5})/2,2),...
    phases_org{2,5}(1:length(phases_org{2,5})/2,3),'LineWidth',2,'color','k')
plot3(phases_org{2,6}(1:length(phases_org{2,6})/2,1), phases_org{2,6}(1:length(phases_org{2,6})/2,2),...
    phases_org{2,6}(1:length(phases_org{2,6})/2,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{2,7}(1:length(phases_org{2,7})/2,1), phases_org{2,7}(1:length(phases_org{2,7})/2,2),...
    phases_org{2,7}(1:length(phases_org{2,7})/2,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{2,8}(1:length(phases_org{2,8})/2,1), phases_org{2,8}(1:length(phases_org{2,8})/2,2),...
    phases_org{2,8}(1:length(phases_org{2,8})/2,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{2,9}(1:length(phases_org{2,9})/2,1), phases_org{2,9}(1:length(phases_org{2,9})/2,2),...
    phases_org{2,9}(1:length(phases_org{2,9})/2,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{2,10}(1:length(phases_org{2,10})/2,1), phases_org{2,10}(1:length(phases_org{2,10})/2,2),...
    phases_org{2,10}(1:length(phases_org{2,10})/2,3),'LineWidth',2,'color','k')
plot3(phases_org{2,11}(1:length(phases_org{2,11})/2,1), phases_org{2,11}(1:length(phases_org{2,11})/2,2),...
    phases_org{2,11}(1:length(phases_org{2,11})/2,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{2,12}(10:length(phases_org{2,12})/2,1), phases_org{2,12}(10:length(phases_org{2,12})/2,2),...
    phases_org{2,12}(10:length(phases_org{2,12})/2,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{2,13}(1:length(phases_org{2,13})/2,1), phases_org{2,13}(1:length(phases_org{2,13})/2,2),...
    phases_org{2,13}(1:length(phases_org{2,13})/2,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{2,14}(1:length(phases_org{2,14})/2,1), phases_org{2,14}(1:length(phases_org{2,14})/2,2),...
    phases_org{2,14}(1:length(phases_org{2,14})/2,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{2,15}(1:length(phases_org{2,15})/2,1), phases_org{2,15}(1:length(phases_org{2,15})/2,2),...
    phases_org{2,15}(1:length(phases_org{2,15})/2,3),'LineWidth',2,'color',[0.4 0.4 0.4])

%Plot AVG
% for k = 5 : size(AVG_au_phases{2},1)-5
%         
%         plot3([AVG_au_phases{2}(k-1,2) AVG_au_phases{2}(k,2)], [AVG_au_phases{2}(k-1,3) AVG_au_phases{2}(k,3)],...
%             [AVG_au_phases{2}(k-1,4) AVG_au_phases{2}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;
% 
% end

plot3(AVG_au_phases{2}(10:length(AVG_au_phases{2})/2,2),AVG_au_phases{2}(10:length(AVG_au_phases{2})/2,3),...
    AVG_au_phases{2}(10:length(AVG_au_phases{2})/2,4),...
    'LineWidth',3,'color','b');
%% Plot phase 3
cmap = cool(size(AVG_au_phases{3},1)); 

stys{1} = ':';
stys{2} = ':';
stys{3} = '-.';
stys{4} = '-.';
stys{5} = '--';
stys{6} = '--';

figure();hold on;
grid on;
cols = ['r' ;'g'; 'b' ;'y' ; 'c' ; 'm'];

%Plot original sequences
plot3(phases_org{3,1}(:,1), phases_org{3,1}(:,2), phases_org{3,1}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{3,2}(:,1), phases_org{3,2}(:,2), phases_org{3,2}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{3,3}(:,1), phases_org{3,3}(:,2), phases_org{3,3}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{3,4}(:,1), phases_org{3,4}(:,2), phases_org{3,4}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{3,5}(:,1), phases_org{3,5}(:,2), phases_org{3,5}(:,3),'LineWidth',2,'color','k')
plot3(phases_org{3,6}(:,1), phases_org{3,6}(:,2), phases_org{3,6}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{3,7}(:,1), phases_org{3,7}(:,2), phases_org{3,7}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{3,8}(:,1), phases_org{3,8}(:,2), phases_org{3,8}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{3,9}(:,1), phases_org{3,9}(:,2), phases_org{3,9}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{3,10}(:,1), phases_org{3,10}(:,2), phases_org{3,10}(:,3),'LineWidth',2,'color','k')
plot3(phases_org{3,11}(:,1), phases_org{3,11}(:,2), phases_org{3,11}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{3,12}(10:end,1), phases_org{3,12}(10:end,2), phases_org{3,12}(10:end,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{3,13}(:,1), phases_org{3,13}(:,2), phases_org{3,13}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{3,14}(:,1), phases_org{3,14}(:,2), phases_org{3,14}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{3,15}(:,1), phases_org{3,15}(:,2), phases_org{3,15}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])

%Plot AVG
for k = 5 : size(AVG_au_phases{3},1)-5
        
        plot3([AVG_au_phases{3}(k-1,2) AVG_au_phases{3}(k,2)], [AVG_au_phases{3}(k-1,3) AVG_au_phases{3}(k,3)],...
            [AVG_au_phases{3}(k-1,4) AVG_au_phases{3}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
%% Plot phase 4
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
plot3(phases_org{4,1}(:,1), phases_org{4,1}(:,2), phases_org{4,1}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{4,2}(:,1), phases_org{4,2}(:,2), phases_org{4,2}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{4,3}(:,1), phases_org{4,3}(:,2), phases_org{4,3}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{4,4}(:,1), phases_org{4,4}(:,2), phases_org{4,4}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{4,5}(:,1), phases_org{4,5}(:,2), phases_org{4,5}(:,3),'LineWidth',2,'color','k')
plot3(phases_org{4,6}(:,1), phases_org{4,6}(:,2), phases_org{4,6}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{4,7}(:,1), phases_org{4,7}(:,2), phases_org{4,7}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{4,8}(:,1), phases_org{4,8}(:,2), phases_org{4,8}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{4,9}(:,1), phases_org{4,9}(:,2), phases_org{4,9}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{4,10}(:,1), phases_org{4,10}(:,2), phases_org{4,10}(:,3),'LineWidth',2,'color','k')
plot3(phases_org{4,11}(:,1), phases_org{4,11}(:,2), phases_org{4,11}(:,3),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{4,12}(10:end,1), phases_org{4,12}(10:end,2), phases_org{4,12}(10:end,3),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{4,13}(:,1), phases_org{4,13}(:,2), phases_org{4,13}(:,3),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{4,14}(:,1), phases_org{4,14}(:,2), phases_org{4,14}(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{4,15}(:,1), phases_org{4,15}(:,2), phases_org{4,15}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])

%Plot AVG
for k = 5 : size(AVG_au_phases{4},1)-5
        
        plot3([AVG_au_phases{4}(k-1,2) AVG_au_phases{4}(k,2)], [AVG_au_phases{4}(k-1,3) AVG_au_phases{4}(k,3)],...
            [AVG_au_phases{4}(k-1,4) AVG_au_phases{4}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end

%% Plot phase 4
cmap = cool(size(AVG_xs_phases{2},1)); 

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
plot3(phases_org{2,1}(1:120,31), phases_org{2,1}(1:120,32), phases_org{2,1}(1:120,33),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{2,2}(1:120,31), phases_org{2,2}(1:120,32), phases_org{2,2}(1:120,33),'LineWidth',2,'color',[0.4 0.4 0.4])
%plot3(phases_org{4,3}(1:120,31), phases_org{4,3}(1:120,32), phases_org{4,3}(1:120,33),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{2,4}(1:120,31), phases_org{2,4}(1:120,32), phases_org{2,4}(1:120,33),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{2,5}(1:120,31), phases_org{2,5}(1:120,32), phases_org{2,5}(1:120,33),'LineWidth',2,'color','k')
plot3(phases_org{2,6}(1:120,31), phases_org{2,6}(1:120,32), phases_org{2,6}(1:120,33),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{2,7}(1:120,31), phases_org{2,7}(1:120,32), phases_org{2,7}(1:120,33),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{2,8}(1:120,31), phases_org{2,8}(1:120,32), phases_org{2,8}(1:120,33),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{2,9}(1:120,31), phases_org{2,9}(1:120,32), phases_org{2,9}(1:120,33),'LineWidth',2,'color',[0.8 0.8 0.8])
plot3(phases_org{2,10}(1:120,31), phases_org{2,10}(1:120,32), phases_org{2,10}(1:120,33),'LineWidth',2,'color','k')
plot3(phases_org{2,11}(1:120,31), phases_org{2,11}(1:120,32), phases_org{2,11}(1:120,33),'LineWidth',2,'color',[0.2 0.2 0.2])
plot3(phases_org{2,12}(10:120,31), phases_org{2,12}(10:120,32), phases_org{2,12}(10:120,33),'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{2,13}(1:120,31), phases_org{2,13}(1:120,32), phases_org{2,13}(1:120,33),'LineWidth',2,'color',[0.6 0.6 0.6])
plot3(phases_org{2,14}(1:120,31), phases_org{2,14}(1:120,32), phases_org{2,14}(1:120,33),'LineWidth',2,'color',[0.8 0.8 0.8])
%plot3(phases_org{4,15}(:,1), phases_org{4,15}(:,2), phases_org{4,15}(:,3),'LineWidth',2,'color',[0.4 0.4 0.4])

hold on
%Plot AVG

plot3(AVG_xs_phases{2}(1:120,32), AVG_xs_phases{2}(1:120,33), AVG_xs_phases{2}(1:120,34),'LineWidth',3,'color','b')

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])

