ref_list.seq1.torque=load('20170724T1208-50ms-Trocar-Angles2.txt');% Nabe
ref_list.seq7.torque=load('20170724T1049-50ms-Trocar-Angles2.txt'); % Vicky
ref_list.seq8.torque=load('20170724T1514-50ms-Trocar-Angles2.txt'); % Cristian
ref_list.seq9.torque=load('20170724T1659-50ms-Trocar-Angles2.txt'); % Paul
%%
seq=ref_list.seq1;
position_xsens=seq.xsenspos;
position_xsens(:,end)=round(position_xsens(:,end));
annotations=round(seq.events(:,1)*1000);

a=zeros(length(position_xsens),1);
position_xsens = [position_xsens a];
j=1;
for i=2:10 % adding annotations
    ind=find(annotations(i,1)==position_xsens(:,end-1));
    position_xsens(ind,end)=j;
    j=j+1;
end

begin=min(find(position_xsens(:,end)==1));
endd=max(find(position_xsens(:,end)==9));
position_xsens=position_xsens(begin:endd,:);
phases=note_phase(position_xsens);
%% Torque
torque=seq.torque(begin:endd,3);
torque=[torque position_xsens(:,end) phases(:,end)];
% interpolates for missing values
x=1:length(torque);
for i=1:size(torque,2)
    ind=~isnan(torque(:,i));
    torque(:,i)=interp1(x(ind),torque(ind,i),x)';
    i=i+1;
end

% replace NaNs on outside of matrix by 0
for i=1:length(torque)
    a=isnan(torque(i,:));
    torque(i,a)=0;
    if any(a)
        torque(i,:)=zeros(1,size(torque,2)); % put zeros in whole row if there is NaN
    end
end

all(torque==0,2);
torque(ans,:)=[];

maxright=max(torque(:,1));
maxleft=min(torque(:,1));
nbacktozero=find(torque(:,1)>-10 & torque(:,1)<10);

%% Translation
trans=seq.torque(begin:endd,2);
trans=[trans position_xsens(:,end) phases(:,end)];
% interpolates for missing values
x=1:length(trans);
for i=1:size(trans,2)
    ind=~isnan(trans(:,i));
    trans(:,i)=interp1(x(ind),trans(ind,i),x)';
    i=i+1;
end

% replace NaNs on outside of matrix by 0
for i=1:length(trans)
    a=isnan(trans(i,:));
    trans(i,a)=0;
    if any(a)
        trans(i,:)=zeros(1,size(trans,2)); % put zeros in whole row if there is NaN
    end
end

all(trans==0,2);
trans(ans,:)=[];

phase1trans=trans(min(find(trans(:,end)==1)):max(find(trans(:,end)==1)),:);
phase2trans=trans(min(find(trans(:,end)==1)):max(find(trans(:,end)==2)),:);
phase3trans=trans(min(find(trans(:,end)==1)):max(find(trans(:,end)==3)),:);
phase4trans=trans(min(find(trans(:,end)==1)):max(find(trans(:,end)==4)),:);

% filtphase3=filter(B,A,phase3(:,1));
% filtphase3smooth=imgaussfilt(filtphase3,4);
% plot(find(phase3(:,1))./20,phase3);
figure, plot(find(phase3trans(:,3))./20,phase3trans(:,1)./10);
ylabel('distance [cm]');
xlabel('time [s]');
title('Translation - Duodenal pylorus intubation - Sequence 12');
legend('off');

%% prep visualization

phase1=torque(min(find(torque(:,end)==1)):max(find(torque(:,end)==1)),:);
phase2=torque(min(find(torque(:,end)==1)):max(find(torque(:,end)==2)),:);
phase3=torque(min(find(torque(:,end)==1)):max(find(torque(:,end)==3)),:);
phase4=torque(min(find(torque(:,end)==1)):max(find(torque(:,end)==4)),:);
% fit1=fit(find(torque(:,1)),torque(:,1),'linearinterp');
% figure,plot(fit1);
% figure,plot(fit(find(torque(:,1)),torque(:,1),'linearinterp'));

fc=0.1;
nfc=2*fc*0.5;
[B,A]=butter(2,nfc);
% filt2=filter(B,A,phase2(:,1));
% figure,plot(find(phase2(:,1))./20,filt2);
%% visualize pylorus intubation
filtphase3=filter(B,A,phase3(:,1));
filtphase3smooth=imgaussfilt(filtphase3,4);
% plot(find(phase3(:,1))./20,phase3);
figure, plot(find(phase3(:,1))./20,filtphase3smooth);
ylabel('degrees');
xlabel('time [s]');
title('Torque - Duodenal pylorus intubation - Sequence 12');
legend('off');
%% subplot phases
figure,subplot(2,2,1);
% fitphase1=fit(find(phase1(:,1))./20,phase1(:,1),'linearinterp');
filtphase1=filter(B,A,phase1(:,1));
plot(find(phase1(:,1))./20,phase1);
plot(find(phase1(:,1))./20,filtphase1);
ylabel('degrees');
xlabel('time');
title('insertion');
legend('off');
subplot(2,2,2);
% fitphase2=fit(find(phase2(:,1))./20,phase2(:,1),'linearinterp');
filtphase2=filter(B,A,phase2(:,1));
plot(find(phase2(:,1))./20,phase2);
plot(find(phase2(:,1))./20,filtphase2);
ylabel('degrees');
xlabel('time');
title('retroflexion and inspection');
legend('off');
subplot(2,2,3);
% fitphase3=fit(find(phase3(:,1))./20,phase3(:,1),'linearinterp');
filtphase3=filter(B,A,phase3(:,1));
plot(find(phase3(:,1))./20,phase3);
plot(find(phase3(:,1))./20,filtphase3);
ylabel('degrees');
xlabel('time');
title('intubation');
legend('off');
subplot(2,2,4);
% fitphase4=fit(find(phase4(:,1))./20,phase4(:,1),'linearinterp');
filtphase4=filter(B,A,phase4(:,1));
plot(find(phase4(:,1))./20,phase4);
plot(find(phase4(:,1))./20,filtphase4);
ylabel('degrees');
xlabel('time');
title('retraction');
legend('off');

%% right hand position
rh_position=[position_xsens(:,31:33) phases(:,end)];
rh_position_phase3=rh_position(min(find(rh_position(:,end)==3)):...
    max(find(rh_position(:,end)==3)),:);

figure, plot(find(rh_position_phase3(:,1))./20,rh_position_phase3(:,1));
hold on
figure, plot(find(rh_position_phase3(:,1))./20,rh_position_phase3(:,2));
figure, plot(find(rh_position_phase3(:,1))./20,rh_position_phase3(:,3));
ylabel('position [cm]');
xlabel('time [s]');
title('Right hand position - Duodenal pylorus intubation');