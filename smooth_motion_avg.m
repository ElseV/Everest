function [seq_rate,rate]=smooth_motion_avg(datalist,namepart,n)
%% Normalization
load(datalist);
% n=26;
for i=1:n 
    name=string(namepart);%("data_list.seq%d");
    part=char(sprintf(name,i));
    seq=eval(part);
    segments=seq;
%     segments(:,1:end-2) = normc(segments(:,1:end-2)); %%???
%     segments=note_phase(segments);
    sequences{i}=segments.xsorg;
    % manual standardization to correct for different body dim
    for j=1:69
        meanvalue(i,j)=mean(sequences{i}(:,j));
        stdvalue(i,j)=std(sequences{i}(:,j));
    end
end
meanseg=mean(meanvalue); % mean
stdseg=mean(stdvalue); % std
% compute (data-mean)/std
for ii=1:n
    for jj=1:size(sequences{ii})
        seqminmean{ii}(jj,:)=sequences{ii}(jj,1:end-1)-meanseg;
        for column=1:size(seqminmean{ii},2)
            seqnorm{ii}(jj,column)=seqminmean{ii}(jj,column)/stdseg(:,column);
        end
    end
end

n=length(seqnorm);

%% path > velocity > acceleration
% calculate path / (length*20) > cm/s
% paths=sum(abs(diff(phase_seq)));
% vx=paths/(length(phase_seq)/20);
% ax=vx/(length(phase_seq)/20);
%% Calculate acceleration for all columns (except last 2)
for i=1:n
    columns=seqnorm{1,i}(:,1:end-2);
    ax{i}=(abs(diff(columns)))/(length(columns)/20)/(length(columns)/20);
end

% Only upper body
for i=1:n
    ax_upp{i} = [ax{1,i}(:,1:3) ax{1,i}(:,22:45)];
end

% Calculate variance(std) of acceleration
for j=1:n
    for i=1:size(ax_upp{1,j},2)
        std1=std(ax_upp{1,j}(:,i));
        std_column(1,i)=std1;
    end
    var_ax{j}=std_column;
end

%% Threshold for smooth motion
var_ax_tot=0;
for i=1:n
    var_ax_tot=[var_ax_tot var_ax{1,i}];
% var_ax_tot=[var_ax{1,1} var_ax{1,2} var_ax{1,3} var_ax{1,4} var_ax{1,5} var_ax{1,6}...
%     var_ax{1,7} var_ax{1,8} var_ax{1,9} var_ax{1,10} var_ax{1,11} var_ax{1,12}...
%     var_ax{1,13} var_ax{1,14} var_ax{1,15}];
end
var_ax_tot=var_ax_tot(:,2:end);

ind = floor(85/100*((length(var_ax_tot)/27)*27));
newarr = sort(var_ax_tot);
threshold = newarr(ind);

non_smooth = find(var_ax_tot>threshold);

% identify the sequence
for i=1:length(non_smooth)
if mod(non_smooth(:,i),27)~=0
   non_smooth(:,i)=floor(non_smooth(:,i)/27)+1;
else
    non_smooth(:,i)=floor(non_smooth(:,i)/27);
end
end
non_smooth_sequences=unique(non_smooth);

%% sort from not smooth to smooth
[~, order] = sort(var_ax_tot);
% first is smoothest, last is most non smooth
for i=1:length(order)
if mod(order(:,i),27)~=0
   smoothness_order(:,i)=floor(order(:,i)/27)+1;
else
   smoothness_order(:,i)=floor(order(:,i)/27);
end
end

%% Rate of non smoothness
% Each sequence (15) exists 27 times in the vector (all upper body
% segments). 
smoothness_order=smoothness_order(:,1:length(var_ax_tot));
for i=1:length(var_ax_tot)/27
    rate(i,:)=((sum(find(smoothness_order==i))/length(var_ax_tot))/27);
end

[~,seq_rate]=sort(rate);
% first is smoothest, last is most non smooth
end
