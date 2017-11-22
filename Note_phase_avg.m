%% Note phases of average sequence
load('AVG_Seq_all');
load('data_list')
nn=1;

for i = 1:7
n=1;  
name=string("AVG_Seq_all.seq%d"); % data list
A1=i;
part1=char(sprintf(name,A1));
seq_ref=eval(part1);

position_xs_ref=pos_xsens_avg(seq_ref); % avg or normal?
Reference = position_xs_ref;

    for ii=1:26
        name2=('data_list.seq%d');
        B1=ii;
        part2=char(sprintf(name2,B1));
        seq_measure=eval(part2);

        position_xs_measure=pos_xsens(seq_measure); % avg or normal?
        Measurement = note_phase(position_xs_measure);

        [~,ix,iy]=dtw(Reference(:,1:end-2)',Measurement(:,1:end-2)');
        DTWref= Reference(ix,:);
        DTWmeasure= Measurement(iy,:);
        
        if length(DTWref)==length(Reference)
            phases(:,ii)=DTWmeasure(:,end);
        end
    end
    dtwphases{i}=phases;

    clear phases
end
    % remove zero colums
for h=1:7
    for m=1:size(dtwphases{h},2)
        a(:,m)=dtwphases{h}(1,m)==0;
    end
    dtwphases{h}(:,a)=[];
    clear a
end
%% majority vote for phase
clear maj_phases
for j=1:7 % all avg
for k=1:length(dtwphases{j}) % all time points
    tbl{k}=tabulate(dtwphases{j}(k,:));
    a=max(tbl{k}(:,2));
    maj{k}=tbl{k}(tbl{k}(:,2)==a,1);
    if size(maj{k},1)>=2 % when 50/50 majority
        maj{k}=maj{k}(1,:); 
    end
end
maj_phases{j}=maj;
clear maj
end

%% add phases

for i=1:7
    nom=('AVG_Seq_all.seq%d');
    avgname=char(sprintf(nom,i));
    avgseq=eval(avgname);
    avgseq.xsnorm=[avgseq.xsnorm cell2mat(maj_phases{i}')];
    avgseq.xsorg=[avgseq.xsorg cell2mat(maj_phases{i}')];
    if length(avgseq.aunorm) <= length(cell2mat(maj_phases{i}'))
        a=length(cell2mat(maj_phases{i}'))-length(avgseq.aunorm);
        newphases=cell2mat(maj_phases{i}(:,1:end-a)');
        avgseq.aunorm=[avgseq.aunorm newphases];
        avgseq.auorg=[avgseq.auorg newphases];
    elseif length(avgseq.aunorm) >= length(cell2mat(maj_phases{i}'))
        b=length(avgseq.aunorm)-length(cell2mat(maj_phases{i}'));
        c=ones(b,1)*4;
        newphases=[cell2mat(maj_phases{i}');c];
        avgseq.aunorm=[avgseq.aunorm newphases];
        avgseq.auorg=[avgseq.auorg newphases];
    else
        avgseq.aunorm=[avgseq.aunorm cell2mat(maj_phases{i}')];
        avgseq.auorg=[avgseq.auorg cell2mat(maj_phases{i}')];
    end
    new{i}=avgseq;
end
AVG_Seq_all.seq1=new{1};
AVG_Seq_all.seq2=new{2};
AVG_Seq_all.seq3=new{3};
AVG_Seq_all.seq4=new{4};
AVG_Seq_all.seq5=new{5};
AVG_Seq_all.seq6=new{6};
AVG_Seq_all.seq7=new{7};

%% Add "avg" of Vicky and Leonardo to array

Leoxs=segment_prep(data_list.seq22);
Leoxs=note_phase(Leoxs);
Leoxs(:,end-1)=[];
% Leoau=sensor_prep(data_list.seq22,1,21);
% Leoau=note_phase(Leoau);
% Leoau(:,end-1)=[];
AVG_Seq_all.seq6.xsorg=Leoxs; % Leo
% AVG_Seq_all.seq6.auorg=Leoau;% Leo
AVG_Seq_all.seq7=new{6};
AVG_Seq_all.seq8=new{7};
Vickyxs=segment_prep(data_list.seq1);
Vickyxs=note_phase(Vickyxs);
Vickyxs(:,end-1)=[];
Vickyau=sensor_prep(data_list.seq1,1,21);
Vickyau=note_phase(Vickyau);
Vickyau(:,end-1)=[];
AVG_Seq_all.seq9.xsorg=Vickyxs; % Vicky
AVG_Seq_all.seq9.auorg=Vickyau; % Vicky
