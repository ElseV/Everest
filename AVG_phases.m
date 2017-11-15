
%% Create four phases xsens
clear phases; clear phases_org; clear mi; clear m; clear s; clear si
load('data_list');
event=1;
for phase=1:4
    j=1;
    n_sequences=0;
    for i=1:26 %insertion, retroflexion+inspect, intubation, retraction
        name1=string("data_list.seq%d");
        part1=char(sprintf(name1,i));
        seq=eval(part1);
        position=segment_prep(seq);
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
        
        dlmwrite(['E:Camma\matlab\seq' int2str(j) '.txt'],phases{j},' ');
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
    
     [AVG_xs_Phase{phase},AVGorg_xs_Phase{phase}]=average('xsens',n_sequences,m,s);
end

%% Plot average trajectory
cmap = cool(size(AVG_xs_Phase{1},1)); 

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
plot3(phases{1,1}(:,1), phases{1,1}(:,2), phases{1,1}(:,3),'LineWidth',2)
plot3(phases{1,2}(:,1), phases{1,2}(:,2), phases{1,2}(:,3),'LineWidth',2)
plot3(phases{1,3}(:,1), phases{1,3}(:,2), phases{1,3}(:,3),'LineWidth',2)
plot3(phases{1,4}(:,1), phases{1,4}(:,2), phases{1,4}(:,3),'LineWidth',2)
plot3(phases{1,5}(:,1), phases{1,5}(:,2), phases{1,5}(:,3),'LineWidth',2)
plot3(phases{1,6}(:,1), phases{1,6}(:,2), phases{1,6}(:,3),'LineWidth',2)

%Plot AVG
for k = 5 : size(AVG_xs_Phase{1},1)-5
        
        plot3([AVG_xs_Phase{1}(k-1,2) AVG_xs_Phase{1}(k,2)], [AVG_xs_Phase{1}(k-1,3) AVG_xs_Phase{1}(k,3)],...
            [AVG_xs_Phase{1}(k-1,4) AVG_xs_Phase{1}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
%% Plot average trajectory
cmap = cool(size(AVG_xs_Phase{2},1)); 

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
for k = 5 : size(AVG_xs_Phase{2},1)-5
        
        plot3([AVG_xs_Phase{2}(k-1,2) AVG_xs_Phase{2}(k,2)], [AVG_xs_Phase{2}(k-1,3) AVG_xs_Phase{2}(k,3)],...
            [AVG_xs_Phase{2}(k-1,4) AVG_xs_Phase{2}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
%% Plot average trajectory
cmap = cool(size(AVG_xs_Phase{3},1)); 

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
for k = 5 : size(AVG_xs_Phase{3},1)-5
        
        plot3([AVG_xs_Phase{3}(k-1,2) AVG_xs_Phase{3}(k,2)], [AVG_xs_Phase{3}(k-1,3) AVG_xs_Phase{3}(k,3)],...
            [AVG_xs_Phase{3}(k-1,4) AVG_xs_Phase{3}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
%% Plot average trajectory
cmap = cool(size(AVG_xs_Phase{4},1)); 

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
plot3(phases{4,1}(:,1), phases{4,1}(:,2), phases{4,1}(:,3),'LineWidth',2)
plot3(phases{4,2}(:,1), phases{4,2}(:,2), phases{4,2}(:,3),'LineWidth',2)
% plot3(sequences{1,3}(:,1), sequences{1,3}(:,2), sequences{1,3}(:,3),'LineWidth',2)

%Plot AVG
for k = 5 : size(AVG_xs_Phase{4},1)-5
        
        plot3([AVG_xs_Phase{4}(k-1,2) AVG_xs_Phase{4}(k,2)], [AVG_xs_Phase{4}(k-1,3) AVG_xs_Phase{4}(k,3)],...
            [AVG_xs_Phase{4}(k-1,4) AVG_xs_Phase{4}(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end
%% AVG org plot
figure; hold on; grid on;
plot3(phases_org{1,1}(:,1), phases_org{1,1}(:,2), phases_org{1,1}(:,3),'LineWidth',2)
plot3(phases_org{1,2}(:,1), phases_org{1,2}(:,2), phases_org{1,2}(:,3),'LineWidth',2)
% plot3(phases_org{1,3}(:,1), phases_org{1,3}(:,2), phases_org{1,3}(:,3),'LineWidth',2)
plot3(AVGorg_xs_Phase{1}(:,1), AVGorg_xs_Phase{1}(:,2), AVGorg_xs_Phase{1}(:,3),'LineWidth',2)

