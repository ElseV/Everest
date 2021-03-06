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

% function reference_signal = phase_reference(N1,N2,maneuver)
clear all;
N1=1; 
N2=4; % amount of experts
event=1;
% load('data0724_list');
load('AVG_Seq_all');

AVG_Seq_2407.seq1=AVG_Seq_all.seq1;
AVG_Seq_2407.seq2=AVG_Seq_all.seq7;
AVG_Seq_2407.seq3=AVG_Seq_all.seq8;
AVG_Seq_2407.seq4=AVG_Seq_all.seq9;

for phase=1:4

    for k = N1:N2
        name=string("AVG_Seq_2407.seq%d");
        A1=k;
        part1=char(sprintf(name,A1));
        seq_ref=eval(part1);
        Reference=pos_aurora_avg(seq_ref,1,9);
        
%         if k==2 || k==3 || k==4 || k==5 || k==6
%             continue
%         end
%         if event==7
%             ind1=min(find(Reference(:,end)==event));
%             ind2=max(find(Reference(:,end)==event+2));
%             % Reference=position_xs_ref(ind1:ind2,:);
%             Reference(:,end)=0;
%             Reference(ind1:ind2,end)=phase;
%         else
%             ind1=min(find(Reference(:,end)==event));
%             ind2=min(find(Reference(:,end)==event+2));
%             % Reference = position_xs_ref(ind1:ind2-1,:);
%             Reference(:,end)=0;
%             Reference(ind1:ind2,end)=phase;
%         end

        for ii=N1:N2
            B1=ii;
            part2=char(sprintf(name,B1));
            seq_measure=eval(part2);
            Measurement=pos_aurora_avg(seq_measure,1,9);
%             if k==2 || k==3 || k==4 || k==5 || k==6
%                 continue
%             end
            
%             if event==7
%                 ind3=min(find(Measurement(:,end)==event));
%                 ind4=max(find(Measurement(:,end)==event+2));
%                 % Measurement=position_xs_measure(ind3:ind4,:);
%                 Measurement(:,end)=0;
%                 Measurement(ind3:ind4,end)=phase;
%             else
%                 ind3=min(find(Measurement(:,end)==event));
%                 ind4=min(find(Measurement(:,end)==event+2));
%                 % Measurement = position_xs_measure(ind3:ind4-1,:);
%                 Measurement(:,end)=0;
%                 Measurement(ind3:ind4,end)=phase;
%             end

            [~,ix,iy]=dtw(Reference(:,1:end-2)',Measurement(:,1:end-2)');
            DTWref= Reference(ix,:);
            DTWmeasure= Measurement(iy,:);

            % computre accuracy    
            %reeks1=[ind1:ind2]';
            reeks1=[min(find(DTWref(:,end)==phase)):max(find(DTWref(:,end)==phase))]';
            %reeks2=[ind3:ind4]';
            reeks2=[min(find(DTWmeasure(:,end)==phase)):max(find(DTWmeasure(:,end)==phase))]';
            err=sum(~ismember(reeks1,reeks2)); % gives number of cells that are not similar
            acc=sum(ismember(reeks1,reeks2));
            length_tot=err+acc;

            Accuracy(k,ii)=acc/length_tot; % percentage of similarity
            
            % compute synchronization error
            distance_error=0;
            dist1=abs(min(find(DTWref(:,end)==phase))-min(find(DTWmeasure(:,end)==phase)));
            dist2=abs(max(find(DTWref(:,end)==phase))-max(find(DTWmeasure(:,end)==phase)));
            dist_error=dist1+dist2;
            sync_error(k,ii)=dist_error/20;
            sync_error_per(k,ii)=dist_error/length(DTWref);%length(find(DTWref(:,end)==4));
        end
        SumAccuracy (phase,k) = sum(Accuracy(k,:));
        SumSyncError (phase,k) = sum(sync_error(k,:));
        SumSyncErrorPer (phase,k) = sum(sync_error_per(k,:));
    end
    event=event+2;
end

% (N1-1) is added because when N1 is not 1, also the correct measurement
% number is returned.
for j=1:4 % phases
    [~,ref_acc(j)] = max(SumAccuracy(j,:)); % max for accuracy, min for errors
%     ref_acc = ref_acc + (N1-1);
    SumSyncError(SumSyncError == 0) = NaN;
    [~,ref_err(j)] = min(SumSyncError(j,:));
%     ref_err = ref_err + (N1-1);
    SumSyncErrorPer(SumSyncErrorPer == 0) = NaN;
    [~,ref_errper(j)] = min(SumSyncErrorPer(j,:));
%     ref_errper = ref_errper + (N1-1);
end

% event=1;
for m=1:4
    if ref_err(m) ~= ref_acc(m)
        seq11=char(sprintf(name,ref_err(m)));
        seq1=eval(seq11);
        seq1=pos_xsens_avg(seq1);
%         if event==7
%             ind1=min(find(seq1(:,end)==event));
%             ind2=max(find(seq1(:,end)==event+2));
%             seq1part=seq1(ind1:ind2,:);
%         else
            ind1=min(find(seq1(:,end)==m));%event));
            ind2=max(find(seq1(:,end)==m));%event+2)); %change to min
            seq1part = seq1(ind1:ind2-1,:);
%         end
        seq22=char(sprintf(name,ref_acc(m)));
        seq2=eval(seq22);
        seq2=pos_xsens_avg(seq2);
%         if event==7
%             ind1=min(find(seq2(:,end)==event));
%             ind2=max(find(seq2(:,end)==event+2));
%             seq2part=seq2(ind1:ind2,:);
%         else
            ind1=min(find(seq2(:,end)==m));%event));
            ind2=max(find(seq2(:,end)==m));%event+2)); %change to min
            seq2part = seq2(ind1:ind2-1,:);
%         end
        paths1=sum(sum(abs(diff(seq1part(:,1:end-2)))));
        paths2=sum(sum(abs(diff(seq2part(:,1:end-2)))));
        if paths1 <= paths2
            ref_seq(m)=ref_err(m);
        else
            ref_seq(m)=ref_acc(m);
        end
    else
        ref_seq(m)=ref_acc(m);
    end
    event=event+2;
end
