%% Plot phase 2
figure();hold on;
grid on;

%Plot individual sequences
plot3(phases_org{1,1}(:,1), phases_org{1,1}(:,2), phases_org{1,1}(:,3),...
    'LineWidth',2,'color',[0.2 0.2 0.2])
% plot3(phases_org{1,2}(:,1), phases_org{1,2}(:,2), phases_org{1,2}(:,3),...
%     'LineWidth',2,'color',[0.4 0.4 0.4])
plot3(phases_org{1,3}(:,1), phases_org{1,3}(:,2), phases_org{1,3}(:,3),...
    'LineWidth',2,'color',[0.6 0.6 0.6])
% plot3(phases_org{1,4}(:,1), phases_org{1,4}(:,2), phases_org{1,4}(:,3),...
%     'LineWidth',2,'color',[0.8 0.8 0.8])
% plot3(phases_org{1,5}(:,1), phases_org{1,5}(:,2), phases_org{1,5}(:,3),...
%     'LineWidth',2,'color','k')
% plot3(phases_org{1,6}(:,1), phases_org{1,6}(:,2), phases_org{1,6}(:,3),...
%     'LineWidth',2,'color','g')
% plot3(phases_org{1,7}(:,1), phases_org{1,7}(:,2), phases_org{1,7}(:,3),...
%     'LineWidth',2,'color','r')
% plot3(phases_org{1,8}(:,1), phases_org{1,8}(:,2), phases_org{1,8}(:,3),...
%     'LineWidth',2,'color','b')
% plot3(phases_org{1,9}(:,1), phases_org{1,9}(:,2), phases_org{1,9}(:,3),...
% 'LineWidth',2,'color','m')
plot3(phases_org{1,10}(:,1), phases_org{1,10}(:,2), phases_org{1,10}(:,3),...
    'LineWidth',2,'color','y')
% plot3(phases_org{1,11}(:,1), phases_org{1,11}(:,2), phases_org{1,11}(:,3),...
%     'LineWidth',2,'color',[0 0 0.5])
% plot3(phases_org{1,12}(10:end,1), phases_org{1,12}(10:end,2), phases_org{1,12}(10:end,3),...
%     'LineWidth',2,'color',[0.5 0 0])
% plot3(phases_org{1,13}(:,1), phases_org{1,13}(:,2), phases_org{1,13}(:,3),...
%     'LineWidth',2,'color',[0 0.5 0])
% plot3(phases_org{1,14}(:,1), phases_org{1,14}(:,2), phases_org{1,14}(:,3),...
%     'LineWidth',2,'color',[0.5 0.5 0])
% plot3(phases_org{4,15}(1:120,1), phases_org{1,15}(1:120,2), phases_org{1,15}(1:120,3),...
%'LineWidth',2,'color',[0.4 0.4 0.4])

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])

a=phases_org{1,1}(1:end-100,:);
b=phases_org{1,7}(:,:);
c=phases_org{1,10}(1:end-100,:);
%% changed selection >> b
dlmwrite(['I:\Camma\matlab\seq1.txt'],a,' ');
dlmwrite(['I:\Camma\matlab\seq2.txt'],b,' ');
dlmwrite(['I:\Camma\matlab\seq3.txt'],c,' ');

system(['I:\Camma\build\testDTW\Debug\testDTW_aurora.exe I:\Camma\matlab\seq 3']);% int2str(n_sequences)])
avg_abc = dlmread(['I:\Camma\matlab\seq-avg.txt']);
%% vis
figure();hold on;
grid on;
plot3(a(:,1), a(:,2), a(:,3),...
'LineWidth',2,'color','r')
plot3(b(:,1), b(:,2), b(:,3),...
'LineWidth',2,'color','b')
plot3(c(:,1), c(:,2), c(:,3),...
'LineWidth',2,'color','g')

plot3(avg_abc(:,2), avg_abc(:,3), avg_abc(:,4),...
'LineWidth',2,'color','k')

%% DTW between 2

[dist,ix,iy]=dtw(c',b');

t_c=[1:length(c)]; % time dimension
t_b=[1:length(b)];
t_c_warped=[1:length(ix)]; % incorrect?  
t_b_warped=[1:length(iy)];

c_dtw=c(ix,:);
b_dtw=b(iy,:);

%%
figure, 
scatter3(c_dtw(:,1), c_dtw(:,2), c_dtw(:,3),30,t_c_warped,'filled');
hold on
scatter3(b_dtw(:,1), b_dtw(:,2), b_dtw(:,3),30,t_b_warped,'filled');
% scatter3(M1_slow_warped_x(:,1), M1_slow_warped_x(:,2), M1_slow_warped_x(:,3),30,t_slow_warped,'filled');
% scatter3(M3_011_x(:,1), M3_011_x(:,2), M3_011_x(:,3),30,t_fast,'filled');
% scatter3(M3_01_x(:,1), M3_01_x(:,2), M3_01_x(:,3),30,t_slow,'filled');
hold on 
for i=1:(length(c_dtw)/2) % lines between match points
line([c_dtw(i,1) b_dtw(i,1)],[c_dtw(i,2) b_dtw(i,2)],...
    [c_dtw(i,3) b_dtw(i,3)]);
end

plot3(a(:,1), a(:,2), a(:,3),...
'LineWidth',2,'color','r')
plot3(b(:,1), b(:,2), b(:,3),...
'LineWidth',2,'color','b')
