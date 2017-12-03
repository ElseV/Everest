%% Prepare Poses data

a=load('20170724T1049-50ms-Aurora-Poses.txt');
a=a(:,3:end);
% interpolates for missing values
x=1:length(a);
for i=1:size(a,2)
    ind=~isnan(a(:,i));
    a(:,i)=interp1(x(ind),a(ind,i),x)';
    i=i+1;
end
% replace NaNs on outside of matrix by 0
for i=1:length(a)
    x=isnan(a(i,:));
    a(i,x)=0;

end

b=load('20170724T1212-50ms-Aurora-Poses.txt');
b=b(:,3:end);
% interpolates for missing values
x=1:length(b);
for i=1:size(b,2)
    ind=~isnan(b(:,i));
    b(:,i)=interp1(x(ind),b(ind,i),x)';
    i=i+1;
end
% replace NaNs on outside of matrix by 0
for i=1:length(b)
    x=isnan(b(i,:));
    b(i,x)=0;

end

c=load('20170724T1514-50ms-Aurora-Poses.txt');
c=c(:,3:end);
% interpolates for missing values
x=1:length(c);
for i=1:size(c,2)
    ind=~isnan(c(:,i));
    c(:,i)=interp1(x(ind),c(ind,i),x)';
    i=i+1;
end
% replace NaNs on outside of matrix by 0
for i=1:length(c)
    x=isnan(c(i,:));
    c(i,x)=0;

end

% xpo3_exp4=load('20170724T1659-50ms-Aurora-Poses.txt');
% xpo3_exp4=[xpo3_exp4 xpo3_exp4(:,2)];
% xpo3_exp4=xpo3_exp4(:,3:9);


dlmwrite(['I:Camma\matlab\seq' int2str(1) '.txt'],a,' ');
dlmwrite(['I:Camma\matlab\seq' int2str(2) '.txt'],b,' ');
dlmwrite(['I:Camma\matlab\seq' int2str(3) '.txt'],c,' ');

system('I:\Camma\build\testDTW\Debug\testDTW_aurora_poses.exe I:\Camma\matlab\seq 3')

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