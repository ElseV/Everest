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

%%
wheels =load('20170724T1208-newAngles2.txt'); % total reference

% annotate seq > phase 3: 1209180 (1056) - 1209300 (1295)
% length wheels is 880, lenght seq5 is 2361. 2361/880 = 2.6830

wheels_phase3=wheels(round(1056/2.683):round(1295/2.683),:);

figure, subplot(1,2,1);
plot(find(wheels_phase3(:,1))./3.4615,wheels_phase3(:,1));
ylabel('angle [degrees]');
xlabel('time [s]');
title('Big wheel rotation');
legend('off');

subplot(1,2,2);
plot(find(wheels_phase3(:,1))./3.4615,wheels_phase3(:,2));
ylabel('angle [degrees]');
xlabel('time [s]');
title('Small wheel rotation');
legend('off');

figure, plot(wheels_phase3(:,2));
figure, plot(wheels(:,1));
figure, plot(wheels(:,2));