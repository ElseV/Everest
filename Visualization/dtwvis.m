% Loop voor alles automatisch. Opnieuw PCA voor verschillende manoeuvres
%% Data structering 
% 1-5 = langzaam/slow. 6-10 = normal. 11-15 = snel/fast.
 
for i=1:15; % number measurement
    name = sprintf('M1-0%d.mat',i); % first manoeuvre
    load(name);
    total = 3:size(tree.subject.frames.frame,2); % 1 and 2 are the N-pose and T-pose
    nSamples = length(total);
    frame_start = total(1);
    frame_end = total (end);
    segment = 'Right Hand'; % Load the segment wanted
    M1_x{i} = position(tree, nSamples ,frame_start ,frame_end , segment);
end

M1_slow = [M1_x{1}; M1_x{2}; M1_x{3}; M1_x{4}; M1_x{5}];
M1_normal = [M1_x{6}; M1_x{7}; M1_x{8}; M1_x{9}; M1_x{10}];
M1_fast = [M1_x{11}; M1_x{12}; M1_x{13}; M1_x{14}; M1_x{15}];
M1 = [M1_slow; M1_normal; M1_fast];

for i=1:15;
    name = sprintf('M2-0%d.mat',i); % second manoeuvre
    load(name);
    total = 3:size(tree.subject.frames.frame,2); % 1 and 2 are the N-pose and T-pose
    nSamples = length(total);
    frame_start = total(1);
    frame_end = total (end);
    segment = 'Left Hand'; % Load the segment wanted
    M2_x{i} = position(tree, nSamples ,frame_start ,frame_end , segment);
end

M2_slow = [M2_x{1}; M2_x{2}; M2_x{3}; M2_x{4}; M2_x{5}];
M2_normal = [M2_x{6}; M2_x{7}; M2_x{8}; M2_x{9}; M2_x{10}];
M2_fast = [M2_x{11}; M2_x{12}; M2_x{13}; M2_x{14}; M2_x{15}];
M2 = [M2_slow; M2_normal; M2_fast];

for i=1:15;
    name = sprintf('M3-0%d.mat',i);
    load(name);
    total = 3:size(tree.subject.frames.frame,2); % 1 and 2 are the N-pose and T-pose
    nSamples = length(total);
    frame_start = total(1);
    frame_end = total (end);
    segment = 'Left Hand'; % Load the segment wanted
    M3_x{i} = position(tree, nSamples ,frame_start ,frame_end , segment);
end

M3_slow = [M3_x{1}; M3_x{2}; M3_x{3}; M3_x{4}; M3_x{5}];
M3_normal = [M3_x{6}; M3_x{7}; M3_x{8}; M3_x{9}; M3_x{10}];
M3_fast = [M3_x{11}; M3_x{12}; M3_x{13}; M3_x{14}; M3_x{15}];
M3 = [M3_slow; M3_normal; M3_fast];

figure, plot3(M3_slow(:,1),M3_slow(:,2),M3_slow(:,3)); title('M3 slow');
%% PCA per manoeuvre per velocity sort

[P,PCA_M1_slow,L]=pca(M1_slow);
[P,PCA_M1_normal,L]=pca(M1_normal);
[P,PCA_M1_fast,L]=pca(M1_fast);

[P,PCA_M2_slow,L]=pca(M2_slow);
[P,PCA_M2_normal,L]=pca(M2_normal);
[P,PCA_M2_fast,L]=pca(M2_fast);

[P,PCA_M3_slow,L]=pca(M3_slow);
[P,PCA_M3_normal,L]=pca(M3_normal);
[P,PCA_M3_fast,L]=pca(M3_fast);

figure, plot(PCA_M1_slow(:,1)); title('1 PC M1 slow');
figure, plot(PCA_M2_normal(:,1)); title('1 PC M2 normal');
figure, plot(PCA_M3_fast(:,1)); title('1 PC M3 fast');

%% PCA per manoeuvre
[P,PCA_M1,L]=pca(M1);
[P,PCA_M2,L]=pca(M2);
[P,PCA_M3,L]=pca(M3);

figure, plot(PCA_M1(:,1)); title('1 PC M1');
figure, plot(PCA_M2(:,1)); title('1 PC M2');
figure, plot(PCA_M3(:,1)); title('1 PC M3');
   
%% Performing PCA for 1 manoeuvre over the concenate of first PC's per velocity sort 
W = [PCA_M1_slow(:,1); PCA_M1_normal(:,1); PCA_M1_fast(:,1)];
[P,PCA_M1_PCAed,L]=pca(W);
figure, plot(PCA_M1_PCAed(:,1)); title('1 PC M1 PCAed');
% It is different since information is lost, but similar 
% Still not a good idea
%% DTW after PCA per velocity per manoeuvre
% now add in code just with first PC
figure, dtw(PCA_M3_normal(:,1)',PCA_M3_slow(:,1)')

% figure, plot(PCA_M1_fast(ix)); title('Warped PCA_M1_fast & slow');
% hold on; plot(PCA_M1_slow(iy));

%% DTW after PCA per manoeuvre 
figure, dtw(PCA_M2(:,1)',PCA_M3(:,1)')

%% DTW without PCA preprocessing
[dist,ix,iy]=dtw(M1_fast',M1_slow');

%% Visualization M3 fast & slow
load('M3-01');
    total = 3:size(tree.subject.frames.frame,2); % 1 and 2 are the N-pose and T-pose
    nSamples = length(total);
    frame_start = total(1);
    frame_end = total (end);
    segment = 'Right Hand'; % Load the segment wanted
    M3_01 = position(tree, nSamples ,frame_start ,frame_end , segment);
load('M3-011');  
    total = 3:size(tree.subject.frames.frame,2); % 1 and 2 are the N-pose and T-pose
    nSamples = length(total);
    frame_start = total(1);
    frame_end = total (end);
    segment = 'Right Hand'; % Load the segment wanted
    M3_011 = position(tree, nSamples ,frame_start ,frame_end , segment);

[dist,ix,iy]=dtw(M3_01',M3_011'); % transpose because dtw works with rows
M3_slow_warped = M3_01(ix,:);
M3_fast_warped = M3_011(iy,:);
% figure, scatter3(M3_slow_warped(:,1), M3_slow_warped(:,2), M3_slow_warped(:,3),30);
% hold on
% scatter3(M3_fast_warped(:,1), M3_fast_warped(:,2), M3_fast_warped(:,3),30);
% scatter3(M3_slow(:,1), M3_slow(:,2), M3_slow(:,3),'g');
% scatter3(M3_fast(:,1), M3_fast(:,2), M3_fast(:,3),'y');

xform = [1 0 0; 0 1 0 ; 0.1 0 1];
M3_01_x=M3_01*xform; % add small tranformation for visualization
M3_011_x=M3_011*xform;

t_fast=[1:length(M3_011)]; % time dimension
t_slow=[1:length(M3_01)];
t_slow_warped=[1:length(ix)]; % incorrect?  
t_fast_warped=[1:length(iy)];
figure, 
scatter3(M3_slow_warped(:,1), M3_slow_warped(:,2), M3_slow_warped(:,3),30,t_slow_warped,'filled');
hold on
scatter3(M3_fast_warped(:,1), M3_fast_warped(:,2), M3_fast_warped(:,3),30,t_fast_warped,'filled');
% scatter3(M3_011_x(:,1), M3_011_x(:,2), M3_011_x(:,3),30,t_fast,'filled');
% scatter3(M3_01_x(:,1), M3_01_x(:,2), M3_01_x(:,3),30,t_slow,'filled');
hold on 
for i=1:(length(M3_slow_warped)/2); % lines between match points
line([M3_slow_warped(i,1) M3_fast_warped(i,1)],[M3_slow_warped(i,2) M3_fast_warped(i,2)],...
    [M3_slow_warped(i,3) M3_fast_warped(i,3)]);
end

xlabel('X'); ylabel('Y'); zlabel('Z');
cb = colorbar;
cb.Label.String = 'Time';

%% Visualization M1 fast and slow
load('M1-01');
    total = 3:size(tree.subject.frames.frame,2); % 1 and 2 are the N-pose and T-pose
    nSamples = length(total);
    frame_start = total(1);
    frame_end = total (end);
    segment = 'Right Hand'; % Load the segment wanted
    pos_M1_01 = position(tree, nSamples ,frame_start ,frame_end , segment);
    [~, eul_M1_01]=orientation(tree,nSamples,frame_start,frame_end,segment);
load('M1-011');  
    total = 3:size(tree.subject.frames.frame,2); % 1 and 2 are the N-pose and T-pose
    nSamples = length(total);
    frame_start = total(1);
    frame_end = total (end);
    segment = 'Right Hand'; % Load the segment wanted
    pos_M1_011 = position(tree, nSamples ,frame_start ,frame_end , segment);
    [~, eul_M1_011]=orientation(tree,nSamples,frame_start,frame_end,segment);

M1_01= [pos_M1_01 eul_M1_01'];   
M1_011= [pos_M1_011 eul_M1_011'];  
[dist,ix,iy]=dtw(M1_01',M1_011'); % transpose because dtw works with rows
M1_slow_warped = M1_01(ix,:);
M1_fast_warped = M1_011(iy,:);
% figure, scatter3(M3_slow_warped(:,1), M3_slow_warped(:,2), M3_slow_warped(:,3),30);
% hold on
% scatter3(M3_fast_warped(:,1), M3_fast_warped(:,2), M3_fast_warped(:,3),30);
% scatter3(M3_slow(:,1), M3_slow(:,2), M3_slow(:,3),'g');
% scatter3(M3_fast(:,1), M3_fast(:,2), M3_fast(:,3),'y');

% xform = [1 0 0; 0 1 0 ; 0.1 0 1];
% M1_01_x=M1_01*xform; % add small tranformation for visualization
% M1_011_x=M1_011*xform;

% xform = [1 0.1 0; 0 1 0 ; 0 0 1];
% M1_slow_warped_x=M1_slow_warped*xform; % add small to get the 2 manoeuvres closer together

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

