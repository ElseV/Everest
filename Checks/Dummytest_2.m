%% Create dummy data
dummy11= zeros(100,1);
dummy11(:,1)=rand([100 1],'like',data0724.exp2.seq1.xsenspos(:,1));


dummy22=zeros(200,1);
j=1;
for i=1:length(dummy11)
    dum=repmat(dummy11(i,:),2,1);
    dummy22(j:j+1,:)= dum;
    j=j+2;
end

%% dtw
[dist,ix,iy]=dtw(dummy11',dummy22');

%% add events
f=zeros(length(dummy11),1);
dummy11 = [dummy11 f];
dummy11(1:10,2)=0;
dummy11(11:20,2)=1;
dummy11(21:30,2)=2;
dummy11(31:40,2)=3;
dummy11(41:50,2)=4;
dummy11(51:60,2)=5;
dummy11(61:70,2)=6;
dummy11(71:80,2)=7;
dummy11(81:90,2)=8;
dummy11(91:100,2)=9;

g=zeros(length(dummy22),1);
dummy22 = [dummy22 g];

j=1;
for i=1:length(dummy11)
    dum=repmat(dummy11(i,2),2,1);
    dummy22(j:j+1,2)= dum;
    j=j+2;
end
dummy22(:,2)=dummy22(:,2)+1;
%%
b_new=dummy11(ix,:);
d_new=dummy22(iy,:);
%% Error distance 
% ix should have some locations as d(g)
distance_error=0;
k=0;
for i=0:9
    dis1=find(b_new(:,end)==i);
    dis2=find(d_new(:,end)==i);
    if isempty(dis1) || isempty(dis2)
        i=i+1;
        continue
    end
    distance = abs(mean(dis2)-mean(dis1)); % minimal distance between dtw and timestamp in [20 fps]
    distance_error=abs(distance_error+distance);
    k=k+1;
end
sync_error=(1/k*distance_error); % in sec 20 frames per sec


%% Error similarity
% Check if the aligned sequence contains the same row numbers
err_tot=0;
reeks_tot=0;
length_tot=0;
acc_tot=0;
for i=0:9; % goes till 8 since i and i+1 is taken
    % make array of indices for a specific phase after dtw (ex: retroflexion)
    ind1=min(find(b_new(:,size(b_new,2))==i));
    ind12=max(find(b_new(:,size(b_new,2))==i+1));
    reeks1=[ind1:ind12]';

    ind2=min(find(d_new(:,size(d_new,2))==i));
    ind22=max(find(d_new(:,size(d_new,2))==i+1));
    reeks2=[ind2:ind22]';
    
    err=sum(~ismember(reeks1,reeks2)); % gives number of cells that are not similar
    err_tot=err+err_tot;
    acc=sum(ismember(reeks1,reeks2));
    acc_tot=acc+acc_tot; 
    length_tot=length_tot+err+acc;
%     if isempty(reeks1) | isempty(reeks2)
%        reeks_tot=reeks_tot;
%        else
% 
%        if length(reeks1) >= length(reeks2)
%           reeks_tot=length(reeks1)+reeks_tot;
%        else
%           reeks_tot=length(reeks2)+reeks_tot;
%        end
%     end
end
sym_error=err_tot/length_tot; % percentage > divede non similar cell by length to check percentange
accuracy=acc_tot/length_tot; % percentage of simila