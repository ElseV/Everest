%% Prepare Poses data

a=load('20170724T1049-50ms-Xsens-Poses.txt');
xs1049=poses_prep(a);
aa=load('20170724T1153-50ms-Xsens-Poses.txt');
xs1054=poses_prep(aa);
bb=load('20170724T1200-50ms-Xsens-Poses.txt');
xs1200=poses_prep(bb);
d=load('20170724T1203-50ms-Xsens-Poses.txt');
xs1203=poses_prep(d);
e=load('20170724T1208-50ms-Xsens-Poses.txt');
xs1208=poses_prep(e);
b=load('20170724T1212-50ms-Xsens-Poses.txt');
xs1212=poses_prep(b);

k=load('20171010T1544-50ms-Xsens-Poses.txt');
xs1544=poses_prep(k);
l=load('20171010T1622-50ms-Xsens-Poses.txt');
xs1622=poses_prep(l);
m=load('20171010T1627-50ms-Xsens-Poses.txt');
xs1627=poses_prep(m);

f=load('20170724T1501-50ms-Xsens-Poses.txt');
xs1501=poses_prep(f);
g=load('20170724T1508-50ms-Xsens-Poses.txt');
xs1508=poses_prep(g);
c=load('20170724T1514-50ms-Xsens-Poses.txt');
xs1514=poses_prep(c);
h=load('20170724T1518-50ms-Xsens-Poses.txt');
xs1518=poses_prep(h);
i=load('20170724T1640-50ms-Xsens-Poses.txt');
xs1640=poses_prep(i);
j=load('20170724T1659-50ms-Xsens-Poses.txt');
xs1659=poses_prep(j);
%%
data0724_list.seq1.xsposes=xs1049;
data0724_list.seq2.xsposes=xs1054;
data0724_list.seq3.xsposes=xs1200;
data0724_list.seq4.xsposes=xs1203;
data0724_list.seq5.xsposes=xs1208;
data0724_list.seq6.xsposes=xs1212;
data0724_list.seq7.xsposes=xs1544;
data0724_list.seq8.xsposes=xs1622;
data0724_list.seq9.xsposes=xs1627;
data0724_list.seq10.xsposes=xs1501;
data0724_list.seq11.xsposes=xs1508;
data0724_list.seq12.xsposes=xs1514;
data0724_list.seq13.xsposes=xs1518;
data0724_list.seq14.xsposes=xs1640;
data0724_list.seq15.xsposes=xs1659;

%%
h=1;
for k=1:23
    range=h:h+6;
    j=1;
    for i=2:9
        if i ==3 || i==8
            continue
        end
        formatSpec=string("data0724_list.seq%d.xsposes");
        n=char(sprintf(formatSpec,i));
        seq=eval(n);
        dlmwrite(['I:Camma\matlab\seq' int2str(j) '.txt'],seq(:,range),' ');
        j=j+1;
    end
    % skip 1 and go until 12: aurora all
    % skip 3 & 8: aurora Nabe (2:9)

    system('I:\Camma\build\testDTW\Debug\testDTW_poses.exe I:\Camma\matlab\seq 6')

    avg_xsNabe_segment{k} = dlmread(['I:\Camma\matlab\seq-avg.txt']);
    h=h+7;
end
%% Extrapolate data if needed

x1=avg_xs_segment4;
x2=NaN(2,8);
x=[x1; x2];
x(3368:end,:) = [];

% Extrapolate to fill the empty elements: 
xm = interp1(x, 3368:3369, 'linear', 'extrap');

x_new=[x;xm];
avg_xs_segment4=x_new;
%%
avg_xsNabe_segments=[avg_xsNabe_segment{1}(:,2:end) avg_xsNabe_segment{2}(:,2:end) avg_xsNabe_segment{3}(:,2:end) avg_xsNabe_segment{4}(:,2:end) ...
    avg_xsNabe_segment{5}(:,2:end) avg_xsNabe_segment{6}(:,2:end) avg_xsNabe_segment{7}(:,2:end) avg_xsNabe_segment{7}(:,2:end) ...
    avg_xsNabe_segment{8}(:,2:end) avg_xsNabe_segment{9}(:,2:end) avg_xsNabe_segment{10}(:,2:end) avg_xsNabe_segment{11}(:,2:end) ...
    avg_xsNabe_segment{12}(:,2:end) avg_xsNabe_segment{13}(:,2:end) avg_xsNabe_segment{14}(:,2:end) avg_xsNabe_segment{15}(:,2:end) ...
    avg_xsNabe_segment{16}(:,2:end) avg_xsNabe_segment{17}(:,2:end) avg_xsNabe_segment{18}(:,2:end) avg_xsNabe_segment{19}(:,2:end) ...
    avg_xsNabe_segment{20}(:,2:end) avg_xsNabe_segment{21}(:,2:end) avg_xsNabe_segment{22}(:,2:end) avg_xsNabe_segment{23}(:,2:end)];

dlmwrite('I:Matlab_Everest\avg_xsNabe_segments.txt',avg_xsNabe_segments,' ');

%% Plot average trajectory
cmap = cool(size(avg_sensors,1)); 

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
for i=1:15
    if i==5
        continue
    end
    name=string('data0724_list.seq%d');
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=sensor_prep(seq,1,3);
    plot3(seq_prep(:,1), seq_prep(:,2), seq_prep(:,3),'LineWidth',2,'color',[0.8 0.8 0.8])
end

for i=5
    name=string('data0724_list.seq%d');
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=sensor_prep(seq,1,3);
    plot3(seq_prep(:,1), seq_prep(:,2), seq_prep(:,3),'LineWidth',2,'color','b')
end

%Plot AVG
plot3(avg_sensors(350:end-50,1), avg_sensors(350:end-50,2), avg_sensors(350:end-50,3),'-.','color','b','LineWidth',2)
% hold on
% plot3(avg_sensors(350:550,1), avg_sensors(350:550,2), avg_sensors(350:550,3),'color','g','LineWidth',2)
% for k = 250 : size(avg_sensors,1)-100
%         
%         plot3([avg_sensors(k-1,1) avg_sensors(k,1)], [avg_sensors(k-1,2) avg_sensors(k,2)],...
%             [avg_sensors(k-1,3) avg_sensors(k,3)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;
% 
% end

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])