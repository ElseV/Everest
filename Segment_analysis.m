%% Xsens segments analysis

seq=data0724.exp2.seq2;
position_xsens = seq.xsenspos; 
% position_xsens = [position_xsens(:,1:3) position_xsens(:,22:45) ...
%     position_xsens(:,end)];
% 1-3 = Pelvis, 22-45 = shoulder, upper arm, forearm & hand (see segments
% script)

position_xsens(:,end)=round(position_xsens(:,end));
annotations=round(seq.events(:,1)*1000);

a=zeros(length(position_xsens),1);
position_xsens = [position_xsens a];
j=1;
% adding annotations
for i=2:10 % mouth to mouth
    ind=find(annotations(i,1)==position_xsens(:,end-1));
    position_xsens(ind,end)=j;
    j=j+1;
end

begin=min(find(position_xsens(:,end)==1));
endd=max(find(position_xsens(:,end)==8));
position_xsens=position_xsens(begin:endd,:);

% make phases
for i=1:8 
    if i==5
        continue
    end
    if i==4
    ind1=min(find(position_xsens(:,end)==i));
    ind2=min(find(position_xsens(:,end)==i+2));
    position_xsens(ind1:ind2-1,end)=i;
    end
    ind1=min(find(position_xsens(:,end)==i));
    ind2=min(find(position_xsens(:,end)==i+1));
    position_xsens(ind1:ind2-1,end)=i;
end
%% Normalize for body dimensions?
%% Calculate Variance / std 
for i=1:size(position_xsens,2)
    var1=var(position_xsens(:,i));
    var_column(1,i)=var1;
end

% has same units as data
for i=1:(size(position_xsens,2)-2)
    std1=std(position_xsens(:,i));
    std_column(1,i)=std1;
end

ind = floor(85/100*length(std_column));
newarr = sort(std_column);
threshold = newarr(ind);
 
%threshold = mean(std_column);

moved_columns = find(std_column>threshold);

moved_segments=segments_moved(moved_columns);

%% Per phase
clear moved_segments
clear moved_columns
for i=1:7
    if i==5
        continue
    end
    ind1=min(find(position_xsens(:,end)==i));
    ind2=max(find(position_xsens(:,end)==i));
    for j=1:(size(position_xsens,2)-2)

        std1=std(position_xsens(ind1:ind2,j));
        std_column(i,j)=std1;
    end  
    ind = floor(85/100*length(std_column(i,:)));
    newarr = sort(std_column(i,:));
    threshold = newarr(ind);
    moved_columns(i,:) = find(std_column(i,:)>threshold);
    
    moved_segments(i,:)=segments_moved(moved_columns(i,:))';
end
