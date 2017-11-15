function [sync_error,sync_error_per,...
    accuracy,dtw_seq1,dtw_seq2]=errors(dtw_seq1,dtw_seq2)
%% Compute Synchronization error
% 1/n sum ||t(s1)-t(s2)||
% check if timestemps correspond with dtw synchronization

%% Make phases
for i=1:9 % make phases
%     if i==5
%         continue
%     end
%     if i==4
%     ind1=min(find(dtw_seq1(:,end)==i));
%     ind2=min(find(dtw_seq1(:,end)==i+2));
%     dtw_seq1(ind1:ind2-1,end)=i;
%     end
    if i==8
        continue
    end
    if i==7
    ind1=min(find(dtw_seq1(:,end)==i));
    ind2=min(find(dtw_seq1(:,end)==i+2));
    dtw_seq1(ind1:ind2-1,end)=i;   
    else
    ind1=min(find(dtw_seq1(:,end)==i));
    ind2=min(find(dtw_seq1(:,end)==i+1));
    dtw_seq1(ind1:ind2-1,end)=i;
    end
end

for i=1:9 % make phases
%     if i==5
%         continue
%     end
%     if i==4
%     ind1=min(find(dtw_seq2(:,end)==i));
%     ind2=min(find(dtw_seq2(:,end)==i+2));
%     dtw_seq2(ind1:ind2-1,end)=i;
%     end
    if i==8
        continue
    end
    if i==7
    ind1=min(find(dtw_seq2(:,end)==i));
    ind2=min(find(dtw_seq2(:,end)==i+2));
    dtw_seq2(ind1:ind2-1,end)=i;   
    else
    ind1=min(find(dtw_seq2(:,end)==i));
    ind2=min(find(dtw_seq2(:,end)==i+1));
    dtw_seq2(ind1:ind2-1,end)=i;
    end
end
%% Error distance min to max
distance_error=0;
k=0;
for i=1:7
    dis1=find(dtw_seq1(:,end)==i);
    dis2=find(dtw_seq2(:,end)==i);
    if isempty(dis1) || isempty(dis2)
        i=i+1;
        continue
    end
    distance1 = abs(min(dis2)-min(dis1));
    distance2 = abs(max(dis2)-max(dis1)); 
    distance_error=distance_error+distance1+distance2;
    k=k+1;
end
sync_error=distance_error/20; % in sec 20 frames per sec
sync_error_per=distance_error/(length(dtw_seq1));% percentage
%% Error distance mean to mean
% distance_error=0;
% k=0;
% for i=1:8
%     dis1=find(dtw_seq1(:,end)==i);
%     dis2=find(dtw_seq2(:,end)==i);
%     if isempty(dis1) || isempty(dis2)
%         i=i+1;
%         continue
%     end
%     distance = abs(mean(dis2)-mean(dis1)); % minimal distance between dtw and timestamp in [20 fps]
%     distance_error=distance_error+distance;
%     k=k+1;
% end
% sync_error_distance=distance_error/20; % in sec 20 frames per sec
% sync_error_distance_per=distance_error/length(dtw_seq1);% percentage of lenght
% 
% 
%% Error distance max to max
% distance_error_max=0;
% k=0;
% for i=1:7
%     dis1=find(dtw_seq1(:,end)==i);
%     dis2=find(dtw_seq2(:,end)==i);
%     if isempty(dis1) || isempty(dis2)
%         i=i+1;
%         continue
%     end
%     distance = abs(max(dis2)-max(dis1)); % minimal distance between dtw and timestamp in [20 fps]
%     distance_error_max=distance_error_max+distance;
%     k=k+1;
% end
% sync_error_distance_max=distance_error_max/20; % in sec 20 frames per sec
% sync_error_distance_max_per=distance_error_max/(length(dtw_seq1));% percentage
%% Error similarity duration of phase
% duration_error=0;
% k=0;
% for i=1:7
%     dur1=find(dtw_seq1(:,end)==i);
%     dur2=find(dtw_seq2(:,end)==i);
%     
%     duration_difference = abs(length(dur1)-length(dur2)); 
%     duration_error=duration_error+duration_difference;
%     k=k+1;
% end
% sync_error_duration=duration_error/20; 
% sync_error_duration_per=duration_error/length(dtw_seq1); % persentage of length
%% Accuracy
% Check if the aligned sequence contains the same row numbers
err_tot=0;
reeks_tot=0;
length_tot=0;
acc_tot=0;
for i=1:7; % goes till 8 since i and i+1 is taken
    % make array of indices for a specific phase after dtw (ex: retroflexion)
    ind1=min(find(dtw_seq1(:,size(dtw_seq1,2))==i));
    ind12=max(find(dtw_seq1(:,size(dtw_seq1,2))==i));
    reeks1=[ind1:ind12]';

    ind2=min(find(dtw_seq2(:,size(dtw_seq2,2))==i));
    ind22=max(find(dtw_seq2(:,size(dtw_seq2,2))==i));
    reeks2=[ind2:ind22]';
    
    err=sum(~ismember(reeks1,reeks2)); % gives number of cells that are not similar
    err_tot=err+err_tot;
    acc=sum(ismember(reeks1,reeks2));
    acc_tot=acc+acc_tot; 
    length_tot=length_tot+err+acc;
end
sym_error=err_tot/length_tot; % percentage > divede non similar cell by length to check percentange
accuracy=acc_tot/length_tot; % percentage of similarity
end