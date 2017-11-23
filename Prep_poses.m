%% Prepare Poses data

xpo2_exp1=load('20170724T1049-50ms-Xsens-Poses.txt');
xpo2_exp1=[xpo2_exp1 xpo2_exp1(:,2)];
xpo2_exp1=xpo2_exp1(:,3:9);

xpo5_exp2=load('20170724T1212-50ms-Xsens-Poses.txt');
xpo5_exp2=[xpo5_exp2 xpo5_exp2(:,2)];
xpo5_exp2=xpo5_exp2(:,3:9);

xpo3_exp3=load('20170724T1514-50ms-Xsens-Poses.txt');
xpo3_exp3=[xpo3_exp3 xpo3_exp3(:,2)];
xpo3_exp3=xpo3_exp3(:,3:9);

xpo3_exp4=load('20170724T1659-50ms-Xsens-Poses.txt');
xpo3_exp4=[xpo3_exp4 xpo3_exp4(:,2)];


dlmwrite(['I:Camma\matlab\seq' int2str(1) '.txt'],xpo2_exp1,' ');
dlmwrite(['I:Camma\matlab\seq' int2str(2) '.txt'],xpo5_exp2,' ');
dlmwrite(['I:Camma\matlab\seq' int2str(3) '.txt'],xpo3_exp3,' ');

system('I:\Camma\build\testDTW\Debug\testDTW_test.exe I:\Camma\matlab\seq 3')

AVG = dlmread(['seq-avg.txt']);


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
plot3(xpo2_exp1(:,1), xpo2_exp1(:,2), xpo2_exp1(:,3),'LineWidth',2)
plot3(xpo5_exp2(:,1), xpo5_exp2(:,2), xpo5_exp2(:,3),'LineWidth',2)
plot3(xpo3_exp3(:,1), xpo3_exp3(:,2), xpo3_exp3(:,3),'LineWidth',2)

%Plot AVG
for k = 5 : size(AVG,1)-5
        
        plot3([AVG(k-1,2) AVG(k,2)], [AVG(k-1,3) AVG(k,3)], [AVG(k-1,4) AVG(k,4)],'-','color',cmap(k,:) ,'LineWidth',3);hold on;

end