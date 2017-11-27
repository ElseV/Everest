%% Info avg
load('AVG_Seq_all');
% determin mean time and path
for ii=1:9
    name=string("AVG_Seq_all.seq%d");
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=pos_xsens_avg(seq); % new pos_xsens_avg
    % mean time
    T(ii,1)=length(seq_prep)/20; % in seconds (already cut mouth-mouth)
    % mean path length
end
Tmean=mean(T);
%% Endoscope path
% determin mean time and path
for ii=1:9
    name=string("AVG_Seq_all.seq%d");
    n=char(sprintf(name,ii));
    seq=eval(n);
    if ii==1 || ii==7 || ii==8 || ii==9
        seq_prep=pos_aurora_avg(seq,1,3);
    % path length
        Path(ii,1)=sum(sum(abs(diff(seq_prep(:,1:end-1))))); % in cm?
    end
end
Pmean=mean(Path); % mean path length

for i=1:9
    name=string("AVG_Seq_all.seq%d");
    n=char(sprintf(name,i));
    seq=eval(n);
    if ii==1 || ii==7 || ii==8 || ii==9
%         seq_prep=pos_aurora_avg(seq,1,3);
    % std from mean path
        Pstd(i,1)=Path(i,1)-Pmean;
    end
end

%% Info per avg sequence
for i=1:9
    name=string("AVG_Seq_all.seq%d");
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=pos_xsens_avg(seq);
    % std from mean time
    Tstd(i,1)=T(i)-Tmean;
end
% smoothness rate
[seq_rate,rate]=smooth_motion_avg("AVG_Seq_all","AVG_Seq_all.seq%d",9); % of non smoothness
 
% add Vicky and Leonardo

Info=horzcat(T,Tstd,Path,Pstd,rate);
columns={'Time','stdT','Path','stdP','smoothnessrate'};
Tinfo2=array2table(Info,'VariableNames',columns);
