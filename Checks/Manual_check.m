%% Check similarity of config results
% the outcome of both errors is the same for all configurations. Only the
% distance outcome differs, it increases if you add data

load('data0724');
%% Pre proces
seq1=data0724_list.seq1;
position_xsens1=seq1.xsenspos;
position_xsens1(:,1:end-1) = zscore(position_xsens1(:,1:end-1)); % normailzation
% not normalization for time stamps
position_xsens1 = [position_xsens1(1:length(position_xsens1),1:3) position_xsens1(1:length(position_xsens1),22:45) ...
    position_xsens1(1:length(position_xsens1),end)]; % chose segments
% add annotations
position_xsens1(:,end)=round(position_xsens1(:,end));
annotations1=round(seq1.events(:,1)*1000);

a=zeros(length(position_xsens1),1);
position_xsens1 = [position_xsens1 a];
j=1;
for i=2:9
    ind=find(annotations1(i,1)==position_xsens1(:,end-1));
    position_xsens1(ind,end)=j;
    j=j+1;
end
% remove beginning and end
begin=min(find(position_xsens1(:,end)==1));
endd=max(find(position_xsens1(:,end)==8));
position_xsens1=position_xsens1(begin:endd,:);

seq2=data0724_list.seq1;
position_xsens2=seq2.xsenspos;
position_xsens2(:,1:end-1) = zscore(position_xsens2(:,1:end-1)); % normailzation
% not normalization for time stamps
position_xsens2 = [position_xsens2(1:length(position_xsens2),1:3) position_xsens2(1:length(position_xsens2),22:45) ...
    position_xsens2(1:length(position_xsens2),end)];
% add annotations
position_xsens2(:,end)=round(position_xsens2(:,end));
annotations2=round(seq2.events(:,1)*1000);

a=zeros(length(position_xsens2),1);
position_xsens2 = [position_xsens2 a];
j=1;
for i=2:9
    ind=find(annotations2(i,1)==position_xsens2(:,end-1));
    position_xsens2(ind,end)=j;
    j=j+1;
end
% remove beginning and end
begin=min(find(position_xsens2(:,end)==1));
endd=max(find(position_xsens2(:,end)==8));
position_xsens2=position_xsens2(begin:endd,:);
%% Add orientation?
orientation_xsens1=seq1.xsensori;
orientation_xsens1(:,1:end-1) = zscore(orientation_xsens1(:,1:end-1)); % normailzation
% not normalization for time stamps
orientation_xsens1 = [orientation_xsens1(1:length(orientation_xsens1),1:4) orientation_xsens1(1:length(orientation_xsens1),29:60) ...
    orientation_xsens1(1:length(orientation_xsens1),end)]; % chose sensors
% add annotations
orientation_xsens1(:,end)=round(orientation_xsens1(:,end));
annotations1=round(seq1.events(:,1)*1000);

a=zeros(length(orientation_xsens1),1);
orientation_xsens1 = [orientation_xsens1 a];
j=1;
for i=2:9
    ind=find(annotations1(i,1)==orientation_xsens1(:,end-1));
    orientation_xsens1(ind,end)=j;
    j=j+1;
end
% remove beginning and end
begin=min(find(orientation_xsens1(:,end)==1));
endd=max(find(orientation_xsens1(:,end)==8));
orientation_xsens1=orientation_xsens1(begin:endd,:);

orientation_xsens2=seq2.xsensori;
orientation_xsens2(:,1:end-1) = zscore(orientation_xsens2(:,1:end-1)); % normailzation
% not normalization for time stamps
orientation_xsens2 = [orientation_xsens2(1:length(orientation_xsens2),1:4) orientation_xsens2(1:length(orientation_xsens2),29:60) ...
    orientation_xsens2(1:length(orientation_xsens2),end)];
% add annotations
orientation_xsens2(:,end)=round(orientation_xsens2(:,end));
annotations2=round(seq2.events(:,1)*1000);

a=zeros(length(orientation_xsens2),1);
orientation_xsens2 = [orientation_xsens2 a];
j=1;
for i=2:9
    ind=find(annotations2(i,1)==orientation_xsens2(:,end-1));
    orientation_xsens2(ind,end)=j;
    j=j+1;
end
% remove beginning and end
begin=min(find(orientation_xsens2(:,end)==1));
endd=max(find(orientation_xsens2(:,end)==8));
orientation_xsens2=orientation_xsens2(begin:endd,:);
%% Aurora
position_au1=pos_aurora(seq1,1,9);
position_au2=pos_aurora(seq2,1,9);

orientation_au1=ori_aurora(seq1,1,12);
orientation_au2=ori_aurora(seq2,1,12);

old1=[orientation_au1];%(:,1:end-2) orientation_au1];
old2=[orientation_au2];%(:,1:end-2) orientation_au2];
[dist,ix,iy]=dtw(old1(:,1:end-2)',old2(:,1:end-2)');

s1new=old1(ix,:);
s2new=old2(iy,:);
%% From final sequence
        if length(position_xsens1) <= length(position_au1)
            position_au1=position_au1(~all(position_xsens1==0,2),:);
        else
            position_xsens1=position_xsens1(~all(position_au1==0,2),:);
        end
        
        if length(position_xsens2) <= length(position_au2)
            position_au2=position_au2(~all(position_xsens2==0,2),:);
        else
            position_xsens2=position_xsens2(~all(position_au2==0,2),:);
        end
        
        if length(orientation_xsens1) <= length(orientation_au1)
            orientation_au1=orientation_au1(~all(orientation_xsens1==0,2),:);
        else
            orientation_xsens1=orientation_xsens1(~all(orientation_au1==0,2),:);
        end
        
        if length(orientation_xsens2) <= length(orientation_au2)
            orientation_au2=orientation_au2(~all(orientation_xsens2==0,2),:);
        else
            orientation_xsens2=orientation_xsens2(~all(orientation_au2==0,2),:);
        end
old1=[position_xsens1];%orientation_au1(:,1:end-2) 
old2=[position_xsens2];%orientation_au2(:,1:end-2)
[dist,ix,iy]=dtw(old1(:,1:end-2)',old2(:,1:end-2)');
       
%% Create qarped sequences after dtw
s1new=old1(ix,:);
s2new=old2(iy,:);
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
    ind1=min(find(s1new(:,end)==i));
    ind2=min(find(s1new(:,end)==i+2));
    s1new(ind1:ind2-1,end)=i;   
    end
    ind1=min(find(s1new(:,end)==i));
    ind2=min(find(s1new(:,end)==i+1));
    s1new(ind1:ind2-1,end)=i;
end

for i=1:8 % make phases
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
    ind1=min(find(s2new(:,end)==i));
    ind2=min(find(s2new(:,end)==i+2));
    s2new(ind1:ind2-1,end)=i;   
    end
    ind1=min(find(s2new(:,end)==i));
    ind2=min(find(s2new(:,end)==i+1));
    s2new(ind1:ind2-1,end)=i;
end

%% Error distance mean to mean
% distance_error=0;
% k=0;
% for i=1:7
%     dis1=find(s1new(:,end)==i);
%     dis2=find(s2new(:,end)==i);
%     if isempty(dis1) || isempty(dis2)
%         i=i+1;
%         continue
%     end
%     distance = abs(mean(dis2)-mean(dis1)); % minimal distance between dtw and timestamp in [20 fps]
%     distance_error=distance_error+distance;
%     k=k+1;
% end
% sync_error_distance=distance_error/20; % in sec 20 frames per sec
% sync_error_distance_2=distance_error/length(s1new);
%% Error distance min to max
distance_error=0;
k=0;
for i=1:7
    dis1=find(s1new(:,end)==i);
    dis2=find(s2new(:,end)==i);
    if isempty(dis1) || isempty(dis2)
        i=i+1;
        continue
    end
    distance1 = abs(min(dis2)-min(dis1));
    distance2 = abs(max(dis2)-max(dis1)); 
    distance_error=distance_error+distance1+distance2;
    k=k+1;
end
sync_error_distance=distance_error/20; % in sec 20 frames per sec
sync_error_distance_per=distance_error/(length(s1new));% percentage
%% Error similarity duration of phase
% duration_error=0;
% k=0;
% for i=1:7
%     dur1=find(s1new(:,end)==i);
%     dur2=find(s2new(:,end)==i);
%     
%     duration_difference = abs(length(dur1)-length(dur2)); 
%     duration_error=duration_error+duration_difference;
%     k=k+1;
% end
% sync_error_duration=duration_error/20;% in sec 20 frames per sec
% sync_error_duration_2=duration_error/length(s1new); 
%% Accuracy
% Check if the aligned sequence contains the same row numbers
err_tot=0;
reeks_tot=0;
length_tot=0;
acc_tot=0;
for i=1:7; % goes till 8 since i and i+1 is taken
    % make array of indices for a specific phase after dtw (ex: retroflexion)
    ind1=min(find(s1new(:,size(s1new,2))==i));
    ind12=max(find(s1new(:,size(s1new,2))==i));
    reeks1=[ind1:ind12]';

    ind2=min(find(s2new(:,size(s2new,2))==i));
    ind22=max(find(s2new(:,size(s2new,2))==i));
    reeks2=[ind2:ind22]';
    
    err=sum(~ismember(reeks1,reeks2)); % gives number of cells that are not similar
    err_tot=err+err_tot;
    acc=sum(ismember(reeks1,reeks2));
    acc_tot=acc+acc_tot; 
    length_tot=length_tot+err+acc;
end
sym_error=err_tot/length_tot; % percentage > divede non similar cell by length to check percentange
accuracy=acc_tot/length_tot; % percentage of similarity