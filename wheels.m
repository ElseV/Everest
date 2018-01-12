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
wheels=xlsread('angles_1058.xlsx'); % Ivo

% annotations phase 3: 1058579 (422) - 1059254 (835)

wheels_phase3=[wheels(422:835,1) wheels(422:835,2)]; % first large, second small wheel

fc=0.1;
nfc=2*fc*0.5;
[B,A]=butter(2,nfc);
a=filter(B,A,wheels_phase3(:,1));
b=filter(B,A,wheels_phase3(:,2));
wheels_phase3_big=imgaussfilt(a,4);
wheels_phase3_small=imgaussfilt(b,4);
% c=filter(B,A,wheels_phase3(:,1));
% d=imgaussfilt(c,4);

figure, subplot(1,2,1);
plot(find(wheels_phase3_big(:,1))./20,wheels_phase3_big(:,1));
ylabel('angle [degrees]');
xlabel('time [s]');
title('Big wheel rotation');
legend('off');
ylim([0 380])

subplot(1,2,2);
plot(find(wheels_phase3_small(:,1))./20,wheels_phase3_small(:,1));
ylabel('angle [degrees]');
xlabel('time [s]');
title('Small wheel rotation');
legend('off');
ylim([0 380])

figure, plot(wheels(:,1));
figure, plot(wheels(:,2));

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
plot(find(wheels_phase3(:,2))./3.4615,wheels_phase3(:,2));
ylabel('angle [degrees]');
xlabel('time [s]');
title('Small wheel rotation');
legend('off');

figure, plot(wheels_phase3(:,2));
figure, plot(wheels(:,1));
figure, plot(wheels(:,2));