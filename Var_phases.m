%% Variantion of phases between experts
%% Creat normalization for body measurments
clear all
load('data0724_list');
n=15;
for i=1:n %insertion, retroflexion+inspect, intubation, retraction
    name=string("data0724_list.seq%d");%("data_list.seq%d");
    part=char(sprintf(name,i));
    seq=eval(part);
    segments=segment_prep(seq);
%     segments(:,1:end-2) = normc(segments(:,1:end-2)); %%???
    segments=note_phase(segments);
    sequences{i}=segments;
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
        seqminmean{ii}(jj,:)=sequences{ii}(jj,1:end-2)-meanseg;
        for column=1:size(seqminmean{ii},2)
            seqnorm{ii}(jj,column)=seqminmean{ii}(jj,column)/stdseg(:,column);
%             segnorm_phases{ii}(jj,column)=[seqnorm{ii}]
        end
    end
end

for h=1:15
    a{h}=sequences{h}(:,end-1:end);
    b=[seqnorm{h} a{h}];
    seqnorm_phases{h}=b;
end
%% Variation xsens
% clear all
load('data_list');
n=15;
for phase=1:4
    for i=1:n 
%         name=string("data_list.seq%d");
%         part=char(sprintf(name,i));
%         seq=eval(part);
%         segments=pos_xsens(seq);
%         segments=note_phase(segments);
    %     sequences{i}=segments;
        segments=seqnorm_phases{i};
        ind1=min(find(segments(:,end)==phase));
        ind2=max(find(segments(:,end)==phase));
        seq_phase = segments(ind1:ind2,:);
        exps_mean(i,:)=mean(seq_phase(:,1:end-2));
    %         for j=1:27
    %             stdvalue(i,j)=std(seq_phase(:,j));
    %         end
    %     std_seq(phase)=sum(sum(stdvalue));
    end
std_exps(phase,:)=sum(std(exps_mean));
std_exps(phase,2)=mean(std(exps_mean));
end
 
% normalization for body 

%% Variantion aurora
clear exps_mean
load('data0724_list');
n=15;
for phase=1:4
    for i=1:n 
    name=string("data0724_list.seq%d");
        part=char(sprintf(name,i));
        seq=eval(part);
        sensors=pos_aurora(seq,1,9);
        sensors=note_phase(sensors);
    %     sequences{i}=segments;
        ind1=min(find(sensors(:,end)==phase));
        ind2=max(find(sensors(:,end)==phase));
        seq_phase = sensors(ind1:ind2,:);
        exps_mean(i,:)=mean(seq_phase(:,1:end-2));
    %         for j=1:27
    %             stdvalue(i,j)=std(seq_phase(:,j));
    %         end
    %     std_seq(phase)=sum(sum(stdvalue));
    end
std_exps(phase,3)=sum(std(exps_mean));
std_exps(phase,4)=mean(std(exps_mean));
end
