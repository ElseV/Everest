%% Function that calculates the reference signal for using DTW out of a batch of measurements.
% With  means of DTW the reference measurements for DTW is obtained.
% All input measurements are once taken as the reference measurement and compared to all other signals. 
% The sum of all the DTW values for one measurement is taken and then the
% measurement which shows the lowest sum of DTW values is chosen as
% reference measurement.
%
% All values are normalized to zero mean and unit variance
%
% Output = reference signal number
% Input: N1 is the number of the measurement at which the measurement comparison should 
% start and N2 is the total number of measurements. Maneuver is the
% maneuver that one wants to compare.

% function reference_signal = expert_reference(N1,N2,maneuver)

clear all;
% load orginal data list or new list of references
% load('data_list');
load('AVG_Seq_all');
% ref_list.seq1=data_list.seq5; % Nabe
% ref_list.seq2=data_list.seq17; % Shingo
% ref_list.seq3=data_list.seq18; % Ivo
% ref_list.seq4=data_list.seq20; % Eran
% ref_list.seq5=data_list.seq22; % Leonardo
% ref_list.seq6=data_list.seq25; % Lee
% ref_list.seq7=data_list.seq1; % Vicky
% ref_list.seq8=data_list.seq12; % Cristian
% ref_list.seq9=data_list.seq15; % Paul

N1=1; 
N2=7; % amount of experts
nn=1;

for i = N1:N2
n=1;  
name=string("AVG_Seq_all.seq%d"); % data list
A1=i;
part1=char(sprintf(name,A1));
seq_ref=eval(part1);

position_xs_ref=pos_xsens_avg(seq_ref); % avg or normal?
Reference = position_xs_ref;

    for ii=N1:N2
        
        B1=ii;
        part2=char(sprintf(name,B1));
        seq_measure=eval(part2);

        position_xs_measure=pos_xsens_avg(seq_measure); % avg or normal?
        Measurement = position_xs_measure;

        [~,ix,iy]=dtw(Reference(:,1:end-2)',Measurement(:,1:end-2)');
        DTWref= Reference(ix,:);
        DTWmeasure= Measurement(iy,:);
       
        [Sync_error(n),Sync_error_per(n),Accuracy(n),~,~]=errors(DTWref,DTWmeasure);
        
        [sync_error,sync_error_per,...
        accuracy,s1new_events,s2new_events]=errors(DTWref,DTWmeasure);
        n=n+1;
    end

SumAccuracy (nn) = sum(Accuracy,2);
SumSyncError (nn) = sum(Sync_error,2);
SumSyncErrorPer (nn) = sum(Sync_error_per,2);
nn=nn+1;
end

% (N1-1) is added because when N1 is not 1, also the correct measurement
% number is returned.

[~,ref_sync]= min(SumSyncError);
[~,ref_sync_per]= min(SumSyncErrorPer);
[~,ref_acc] = max(SumAccuracy); % max for accuracy, min for errors

ref_sync=ref_sync+(N1-1);
ref_sync_per=ref_sync_per+(N1-1);
ref_acc=ref_acc+(N1-1);

% if the outcomes do not agree, check path lenght
if ref_sync ~= ref_acc
    seq11=char(sprintf(name,ref_sync));
    seq1=eval(seq11);
    seq1=pos_xsens(seq1);
    seq22=char(sprintf(name,ref_acc));
    seq2=eval(seq22);
    seq2=pos_xsens(seq2);
    paths1=sum(sum(abs(diff(seq1(:,1:end-2)))));
    paths2=sum(sum(abs(diff(seq2(:,1:end-2)))));
    if paths1 <= paths2
        ref_seq=ref_sync;
    else
        ref_seq=ref_acc;
    end
else
    ref_seq=ref_acc;
end

