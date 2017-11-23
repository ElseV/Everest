%% Variantion of phases between experts

%% Variation xsens
load('data_list');
clear sequences
n=15;
for phase=1:4
    for i=1:n 
        name=string("data_list.seq%d");
        part=char(sprintf(name,i));
        seq=eval(part);
        segments=pos_xsens(seq);
        segments=note_phase(segments);
    %     sequences{i}=segments;
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
