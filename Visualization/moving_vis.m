figure,
plot3(AVG_au_Phase{1}(5:end-5,2), AVG_au_Phase{1}(5:end-5,3), AVG_au_Phase{1}(5:end-5,4) ,'LineWidth',3);
%%
figure,
plot3(AVG_au_Phase{1}(5:end-5,2), AVG_au_Phase{1}(5:end-5,3), AVG_au_Phase{1}(5:end-5,4)...
    ,'LineWidth',1); grid on;
% xlabel('X');
% ylabel('Y');
hold on
dir=diff(AVG_au_Phase{1});
for i=10:20:(length(AVG_au_Phase{1}-20))
    quiver3(AVG_au_Phase{1}(i,2), AVG_au_Phase{1}(i,3), AVG_au_Phase{1}(i,4),...
        dir(i,2), dir(i,3), ...
        dir(i,4),30,'LineWidth',2,'MaxHeadSize',10);
    axis([-3  1    -2  2    -2  2])
    drawnow
    pause(0.3)
end

% figure,
%     quiver3(AVG_au_Phase{1}(10,2), AVG_au_Phase{1}(10,3), AVG_au_Phase{1}(10,4),...
%         dir(10,2), dir(10,3), ...
%         dir(10,4),20,'LineWidth',1,'MaxHeadSize',1);
%%
t_fast=[1:length(M1_011)]; % time dimension
t_slow=[1:length(M1_01)];
t_slow_warped=[1:length(ix)]; % incorrect?  
t_fast_warped=[1:length(iy)];
figure, 
scatter3(M1_fast_warped(:,1), M1_fast_warped(:,2), M1_fast_warped(:,3),30,t_fast_warped,'filled');
hold on
scatter3(M1_slow_warped(:,1), M1_slow_warped(:,2), M1_slow_warped(:,3),30,t_slow_warped,'filled');
% scatter3(M1_slow_warped_x(:,1), M1_slow_warped_x(:,2), M1_slow_warped_x(:,3),30,t_slow_warped,'filled');
% scatter3(M3_011_x(:,1), M3_011_x(:,2), M3_011_x(:,3),30,t_fast,'filled');
% scatter3(M3_01_x(:,1), M3_01_x(:,2), M3_01_x(:,3),30,t_slow,'filled');
hold on 
for i=1:(length(M1_slow_warped)/2) % lines between match points
line([M1_slow_warped(i,1) M1_fast_warped(i,1)],[M1_slow_warped(i,2) M1_fast_warped(i,2)],...
    [M1_slow_warped(i,3) M1_fast_warped(i,3)]);
end
% hold on
% for i=1:10:length(M1_fast_warped)
%     quiver3(M1_slow_warped(i,1), M1_slow_warped(i,2), M1_slow_warped(i,3), M1_slow_warped(i,4),...
%     M1_slow_warped(i,5), M1_slow_warped(i,6),0.01);
% end

xlabel('X'); ylabel('Y'); zlabel('Z');
cb = colorbar;
cb.Label.String = 'Time';