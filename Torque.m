ref_list.seq1.data=load('20170724T1208-50ms-Trocar-Angles2.txt');% Nabe
ref_list.seq7.data=load('20170724T1049-50ms-Trocar-Angles2.txt'); % Vicky
ref_list.seq8.data=load('20170724T1514-50ms-Trocar-Angles2.txt'); % Cristian
ref_list.seq9.data=load('20170724T1659-50ms-Trocar-Angles2.txt'); % Paul
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
%%
data=seq.wheel(begin:endd,3);
data=[data position_xsens(:,end) phases(:,end)];
% interpolates for missing values
x=1:length(data);
for i=1:size(data,2)
    ind=~isnan(data(:,i));
    data(:,i)=interp1(x(ind),data(ind,i),x)';
    i=i+1;
end

% replace NaNs on outside of matrix by 0
for i=1:length(data)
    a=isnan(data(i,:));
    data(i,a)=0;
    if any(a)
        data(i,:)=zeros(1,size(data,2)); % put zeros in whole row if there is NaN
    end
end

all(data==0,2);
data(ans,:)=[];

maxright=max(data(:,1));
maxleft=min(data(:,1));
nbacktozero=find(data(:,1)>-10 & data(:,1)<10);

%% visualization

phase1=data(min(find(data(:,end)==1)):max(find(data(:,end)==1)),:);
phase2=data(min(find(data(:,end)==1)):max(find(data(:,end)==2)),:);
phase3=data(min(find(data(:,end)==1)):max(find(data(:,end)==3)),:);
phase4=data(min(find(data(:,end)==1)):max(find(data(:,end)==4)),:);
% fit1=fit(find(data(:,1)),data(:,1),'linearinterp');
% figure,plot(fit1);
% figure,plot(fit(find(data(:,1)),data(:,1),'linearinterp'));

fc=0.1;
nfc=2*fc*0.5;
[B,A]=butter(2,nfc);
% filt2=filter(B,A,phase2(:,1));
% figure,plot(find(phase2(:,1))./20,filt2);

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