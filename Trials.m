%% Plot phase 2
figure();hold on;
grid on;

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
% plot3(phases_org{4,15}(1:120,1), phases_org{4,15}(1:120,2), phases_org{4,15}(1:120,3),'LineWidth',2,'color',[0.4 0.4 0.4])

hold on
%Plot AVG

plot3(AVG_au_phases{4}(10:end-10,2), AVG_au_phases{4}(10:end-10,3), AVG_au_phases{4}(10:end-10,4),'LineWidth',3,'color','b')

set(gca,'XTicklabel',[])
set(gca,'YTicklabel',[])
set(gca,'ZTicklabel',[])