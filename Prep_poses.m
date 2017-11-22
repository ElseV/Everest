%% Prepare Poses data

xpo2_exp1=load('20170724T1049-50ms-Xsens-Poses.txt');
xpo2_exp1=[xpo2_exp1 xpo2_exp1(:,2)];

xpo5_exp2=load('20170724T1212-50ms-Xsens-Poses.txt');
xpo5_exp2=[xpo5_exp2 xpo5_exp2(:,2)];

xpo3_exp3=load('20170724T1514-50ms-Xsens-Poses.txt');
xpo3_exp3=[xpo3_exp3 xpo3_exp3(:,2)];

xpo3_exp4=load('20170724T1659-50ms-Xsens-Poses.txt');
xpo3_exp4=[xpo3_exp4 xpo3_exp4(:,2)];


dlmwrite(['I:Camma\matlab\seq' int2str(1) '.txt'],xpo2_exp1,' ');
dlmwrite(['I:Camma\matlab\seq' int2str(2) '.txt'],xpo5_exp2,' ');
dlmwrite(['I:Camma\matlab\seq' int2str(3) '.txt'],xpo3_exp3,' ');

system('I:\Camma\build\testDTW\Debug\testDTW_test.exe I:\Camma\matlab\seq 3')

AVG = dlmread(['seq-avg.txt']);
