%% Info all sequences
load('data_list');
% determin mean time and path
for ii=1:26
    name=string("data_list.seq%d");
    n=char(sprintf(name,ii));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % mean time
    t(ii)=length(seq_prep)/20; % in seconds (already cut mouth-mouth)
    Tmean=mean(t);
    % mean path length
    PathUpperBody(ii)=sum(sum(abs(diff(seq_prep(:,1:end-2))))); % in cm?
    PUBmean=mean(PathUpperBody);
    PathRightHand(ii)=sum(sum(abs(diff(seq_prep(:,13:15)))));
    PRHmean=mean(PathRightHand);
    PathLeftHand(ii)=sum(sum(abs(diff(seq_prep(:,25:27)))));
    PLHmean=mean(PathLeftHand);
end
%% Info per sequence
for i=1:26
    name=string("data_list.seq%d");
    n=char(sprintf(name,i));
    seq=eval(n);
    seq_prep=pos_xsens(seq);
    % time
    T(i,1)=length(seq_prep)/20; % in seconds (already cut mouth-mouth)
    % std from mean time
    Tstd(i,1)=T(i)-Tmean;
    % path length
    PathUB(i,1)=sum(sum(abs(diff(seq_prep(:,1:end-2))))); % in cm?
    PathRH(i,1)=sum(sum(abs(diff(seq_prep(:,13:15)))));
    PathLH(i,1)=sum(sum(abs(diff(seq_prep(:,25:27)))));
    % std from mean path
    PUBstd(i,1)=PathUB(i,1)-PUBmean;
    PRHstd(i,1)=PathRH(i,1)-PRHmean;
    PLHstd(i,1)=PathLH(i,1)-PLHmean;
    % most moved segments and in which direction
    segments=segment_prep(seq);
    segments=note_phase(segments); % make phases
    for j=1:(size(segments,2)-2) % std of all columns > segments
        std1=std(segments(:,j));
        std_column(1,j)=std1;
    end
    ind = floor(95/100*length(std_column)); % only top 5%
    newarr = sort(std_column);
    threshold = newarr(ind);
    moved_columns= find(std_column>threshold);
    moved_segments(i,:)=segments_moved(moved_columns);
    moved_seg{i,:}=strjoin(moved_segments(i,:),' - ');
    % smoothness rate
end
 
Info=horzcat(T,Tstd,PathUB,PUBstd,PathRH,PRHstd,PathLH,PLHstd);
Info2=horzcat(num2cell(T),num2cell(Tstd),num2cell(PathUB),num2cell(PUBstd),...
    num2cell(PathRH),num2cell(PRHstd),num2cell(PathLH),num2cell(PLHstd),num2cell(moved_seg));
columns={'time','std','pathUB','std1','pathRH','std2',...
    'pathLH','std3','segments'};
Tinfo=array2table(Info2,'VariableNames',columns);