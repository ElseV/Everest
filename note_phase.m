function [seq_phase]=note_phase(seq)
% seq has to contain last colum with key timestamps
event=1;
for phase =1:4
    if event==7
        ind1=min(find(seq(:,end)==event));
        ind2=max(find(seq(:,end)==event+2));
        seq(ind1:ind2,end)=phase;
    else
        ind1=min(find(seq(:,end)==event));
        ind2=min(find(seq(:,end)==event+2));
        seq(ind1:ind2-1,end)=phase;
    end
    event=event+2;
end
seq_phase=seq;