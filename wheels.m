%% Wheels

load('angles.txt');
load('angles2.txt');
wheels=xlsread('angles2.xlsx'); % Leonardo

% annotations phase 3: 1713590 (1209) - 1715279 (2537)

wheels_phase3=[wheels(1209:2537,1) wheels(1209:2537,4)]; % first large, second small wheel

figure, plot(find(wheels_phase3(:,1))./20,wheels_phase3(1:end-3,1));
ylabel('angle [degrees]');
xlabel('time [s]');
title('Wheel rotation - Duodenal pylorus intubation - Sequence 12');
legend('off');